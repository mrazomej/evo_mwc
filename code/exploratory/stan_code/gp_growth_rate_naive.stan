functions {
    // Function to generate posterior predictive samples
    vector gp_ppc_rng(
        real[] t_ppc,  // time points where to evaluate ppc
        vector y,  // OD measurements
        real[] t_data,  // time points for OD measurements
        real alpha,  // marginal standard deviation
        real rho,  // time scale
        real sigma,  // measurement error
        real delta // extra value added for numerical stability
    ) {
    // Define variables for evaluation
    int N_data = rows(y);  // number of data points
    int N_ppc = size(t_ppc);  // number of time points on ppc
    vector[N_ppc] f_ppc;  //  posterior predictive samples
    {
        // Objective: 
        // Generate covariance matrix for the data
        matrix[N_data, N_data] K = cov_exp_quad(t_data, alpha, rho)
                               + diag_matrix(rep_vector(square(sigma), N_data));
        // We want to solve K ⍺ = y for ⍺. K can be written as K = L_K L_K'

        // 1. Perform Cholesky decomposition K = L_K L_K'
        matrix[N_data, N_data] L_K = cholesky_decompose(K);
        // This now allows us to write the equation to solve L_K L_K' ⍺ = y.
        // We can now compute L_K' ⍺ = inv(L_K) y

        // 2. Compute inv(L_K) y. Since L_K is a triangular matrix we can use
        // the mdivide_left_tri_low function
        vector[N_data] L_K_div_y_data = mdivide_left_tri_low(L_K, y);
        // With this result in hand we can now solve for alpha by computing
        // ⍺ = inv(L_k') inv(L_K) y. This is equivalent to ⍺ = inv(K) y

        // 3. Compute ⍺ = inv(L_k') inv(L_K) y. Since L_K' is a triangular 
        // matrix we can use the mdivide_right_tri_low function
        vector[N_data] K_div_y_data = mdivide_right_tri_low(
            L_K_div_y_data', L_K
        )';

        // Generate covariance matrix for both data an ppc
        matrix[N_data, N_ppc] k_t_data_t_ppc = cov_exp_quad(
            t_data, t_ppc, alpha, rho
        );
        // Evaluate the mean function of the Gaussian process, given by
        // f_µ = K' ⍺
        vector[N_ppc] f_mu = (k_t_data_t_ppc' * K_div_y_data);

        // Evaluate the variance function of the Gaussian process, given by
        // Σ = K* - K*' inv(K) K*,
        // where K* is the covariance matrix of all the points to be evaluated.
        // Using the fact that inv(K) = inv(L_K L_K') this can be rewritten as
        // Σ = K* - K*' inv(L_K L_K') K*,
        //   = K* - K*' inv(L_K) inv(L_K') K*.

        // 1. Evaluate inv(L_K) K*
        matrix[N_data, N_ppc] v_pred = mdivide_left_tri_low(
            L_K, k_t_data_t_ppc
        );
        // 2. Evaluate Σ = K* - K*' inv(L_K L_K') K*
        matrix[N_ppc, N_ppc] cov_f = cov_exp_quad(t_ppc, alpha, rho) 
                                     - v_pred' * v_pred
                                     + diag_matrix(rep_vector(delta, N_ppc));

        // Generate random samples given the variance and covariance functions
        // for the ppc samples
        f_ppc = multi_normal_rng(f_mu, cov_f);
    }
    return f_ppc;
    }
}

data {
    // Data from OD measurements
    int<lower=1> N;  // number of data points
    real t[N];  // time points where measurements were taken
    vector[N] y;  // optical density measurements

    // Posterior Predictive Checks
    int<lower=1> N_predict;  // number of points where to evalute ppc
    real t_predict[N_predict];  // time points where to evaluate ppc
}

parameters {
    real<lower=0> rho;  // time scale
    real<lower=0> alpha;  // marginal standard deviation
    real<lower=0> sigma;  // measurement standard deviation
}

model {
    // Define covariance matrix k(t, t')
    matrix[N, N] cov =  cov_exp_quad(t, alpha, rho)
                        + diag_matrix(rep_vector(square(sigma), N));
    // Perform a Cholesky decomposition of the matrix, this means rewrite the
    // covariance matrix cov = L_cov L_cov'
    matrix[N, N] L_cov = cholesky_decompose(cov);
    
    // Sample data from a multinomial Gaussian with mean zero and rather than
    // covariance matrix, a Cholesky decomposed matrix
    y ~ multi_normal_cholesky(rep_vector(0, N), L_cov);
}

// generated quantities {
//     // Generate posterior predictive samples for the Gaussian process
//     vector[N_predict] f_predict = gp_ppc_rng(
//         t_predict, y, t, alpha, rho, sigma, 1e-10
//     );
//     // Generate posterior predictive samples for the observation process
//     vector[N_predict] y_predict;
//     for (n in 1:N_predict) {
//         y_predict[n] = normal_rng(f_predict[n], sigma);
//     }
// }