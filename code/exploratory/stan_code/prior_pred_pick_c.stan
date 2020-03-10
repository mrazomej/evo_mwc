functions{
    real fitness(real delta_G, real p, real cte, real c, real g){
        real expo = delta_G - log(cte) + log(1 + g*p);
        return (1/(1+exp(-expo)) - c)/(1 - c);
    }
}

data{
    int N;
    real g[N];
    real mu_G;
    real sigma_G;
    real log_cte;
    real alpha_c;
    real beta_c;
    real mu_p;
    real sigma_p;
    real sigma_sigma;
}

transformed data{
    real cte = 10^log_cte;
}

generated quantities{
    // Parameters
    real delta_G = normal_rng(mu_G, sigma_G);
    real c = beta_rng(alpha_c, beta_c);
    real log_p = normal_rng(mu_p, sigma_p);
    real sigma = abs(normal_rng(0, sigma_sigma));
    
    real p = 10^log_p;
    
    real mu;
    
    real F[N];
    
    for (i in 1:N){
        mu = fitness(delta_G, p, cte, c, g[i]);
        F[i] = normal_rng(mu, sigma);
    }
}