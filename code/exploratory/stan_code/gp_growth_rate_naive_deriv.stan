functions {
    // Function to generate posterior predictive samples
    vector gp_ppc_rng(
        real[] x_ppc,  // time points where to evaluate ppc
        vector y,  // OD measurements
        real[] x_data,  // time points for OD measurements
        real alpha,  // marginal standard deviation
        real rho,  // time scale
        real sigma,  // measurement error
        real delta // extra value added for numerical stability
    ) {
    // Define variables for evaluation
    int N_data = rows(y);  // number of data points
    int N_ppc = size(x_ppc);  // number of time points on ppc
    vector[2 * N_ppc] f_df_ppc;  //  posterior predictive samples

    // Build necessary covariance matrices
    // 1. Build bottom left covariance matrix K_22
    // 1.1 Build Kx*x*
    matrix[N_ppc, N_ppc] K_xs_xs = cov_exp_quad(x_ppc, alpha, rho);
    // 1.2 Initialize dx_Kx*x*
    matrix[N_ppc, N_ppc] dx_K_xs_xs;
    // 1.3 Initialize dxx_Kx*x*
    matrix[N_ppc, N_ppc] d2xx_K_xs_xs;
    // 1.4 Compute derivatives of the matrices by multiplying by corresponding
    // prefactors
    for (i in 1:N_ppc){
        for (j in 1:N_ppc){
            dx_K_xs_xs[i, j] = -2 / rho^2 * (x_ppc[i] - x_ppc[j]) *
                               K_xs_xs[i, j];
            d2xx_K_xs_xs[i, j] = 2 / rho^2 * 
            (1 - 2 * (x_ppc[i] - x_ppc[j])^2 / rho^2) * K_xs_xs[i, j];
        }
    }
    // 1.5 Initialize matrices for concatenation
    matrix[N_ppc, 2 * N_ppc] K_22_top;
    matrix[N_ppc, 2 * N_ppc] K_22_bottom;
    matrix[2 * N_ppc, 2 * N_ppc] K_22;
    // 1.6 Concatentate matrices
    K_22_top = append_col(K_xs_xs, dx_K_xs_xs);
    K_22_bottom = append_col(dx_K_xs_xs', d2xx_K_xs_xs);
    K_22 = append_row(K_22_bottom, K_22_top);
    
    // 2. Compute top right and bottom left matrices K_12, K_21
    // 2.1 Build Kxx*
    matrix[N_data, N_ppc] K_x_xs = cov_exp_quad(x_data, x_ppc, alpha, rho);
    // 2.2 Initialize dx_Kxx*
    matrix[N_data, N_ppc] dx_K_x_xs;
    // 2.3 Compute derivative of matrices by multiplying by corresonding
    // prefactors
    for (i in 1:N_data) {
        for (j in 1:N_ppc) {
            dx_K_x_xs[i, j] = -2 / rho^2 * (x_data[i] - x_ppc[j]) *
                              K_x_xs[i, j];
        }
    }
    // 2.4 Initializ matrix to concatenate
    matrix[N_data, 2 * N_ppc] K_12;
    // 2.5 Concatenate matrices
    K_12 = append_col(K_x_xs, dx_K_x_xs);

    // 3. Solve equation Kxx * a = y
    // 3.1 Generate covariance matrix for the data Kxx
    matrix[N_data, N_data] K_x_x = cov_exp_quad(x_data, alpha, rho) +
                                diag_matrix(rep_vector(square(sigma), N_data));
    // 3.2 Perform Cholesky decomposition Kxx = Lxx * Lxx'
    matrix[N_data, N_data] L_x_x = cholesky_decompose(K_x_x);
    // 3.3 Solve for b = inv(Lxx) y taking advantage that Lxx is a triangular
    // matrix
    vector[N_data] b = mdivide_left_tri_low(L_x_x, y);
    // 3.4 Solve a = inv(Lxx') b taking advantage that Lxx is a triangular
    // matrix. Recall that a = inv(Kxx) y
    vector[N_data] a = mdivide_left_tri_low(L_x_x, b);

    // 4. Compute conditional mean <[f(x*), dx*f(x*)] | f(x)>
    vector[2 * N_ppc] mean_conditional = K_12' * a;

    // 5. Evaluate v = inv(Lxx) * Kxx*
    matrix[N_data, 2 * N_ppc] v = mdivide_left_tri_low(L_x_x, K_12);

    // 6. Compute conditional covariance
    matrix[2 * N_ppc, 2 * N_ppc] cov_conditional = K_22 - v' * v +
                                    diag_matrix(rep_vector(delta, 2 * N_ppc));

    // Generate random samples given the conditional mean and covariance
    f_df_ppc = multi_normal_rng(mean_conditional, cov_conditional);

    // Initialize matrix to be returned
    // matrix[N_ppc, 2] f_output;
    // // Slice output to have one column be f(x*) and the other df(x*)
    // f_output = append_col(head(f_df_ppc, N_ppc), tail(f_df_ppc, N_ppc));

    return f_df_ppc;
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
    matrix[N, N] cov_exp =  cov_exp_quad(t, alpha, rho);
    matrix[N, N] cov = cov_exp + diag_matrix(rep_vector(square(sigma), N));
    // Perform a Cholesky decomposition of the matrix, this means rewrite the
    // covariance matrix cov = L_cov L_cov'
    matrix[N, N] L_cov = cholesky_decompose(cov);
    
    // Sample data from a multinomial Gaussian with mean zero and rather than
    // covariance matrix, a Cholesky decomposed matrix
    y ~ multi_normal_cholesky(rep_vector(0, N), L_cov);
}

generated quantities {
    // Generate posterior predictive samples for the Gaussian process
    vector[2 * N_predict] f_predict = gp_ppc_rng(
        t_predict, y, t, alpha, rho, sigma, 1e-10
    );
    // Generate posterior predictive samples for the observation process
    vector[N_predict] y_predict;
    vector[N_predict] dy_predict;
    for (n in 1:N_predict) {
        y_predict[n] = normal_rng(f_predict[n], sigma);
        dy_predict[n] = normal_rng(f_predict[N_predict + n], 1e-5);
    }
}