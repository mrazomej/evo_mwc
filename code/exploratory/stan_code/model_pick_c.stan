functions{
    real fitness(real delta_G, real p, real cte, real c, real g){
        real expo = -delta_G + log(cte) - log(1 + g*p);
        return (1/(1+exp(expo)) - c)/(1 - c);
    }
}

data{
    int N;
    real g[N];
    real F[N];
    real log_cte;
}

transformed data{
    real cte = 10^log_cte;
    
}

parameters{
    real delta_G;
    real log_p;
    real c;
    
    real<lower=0> sigma;
}

transformed parameters{
    real p = 10^log_p;
    real mu[N];
    for (i in 1:N){
        mu[i] = fitness(delta_G, p, cte, c, g[i]);
    }
}


model{
    delta_G ~ normal(-13.8, 3);
    c ~ beta(1.1, 10);
    log_p ~ normal(1, 0.8);
    sigma ~ normal(0, 0.1);
    
    F ~ normal(mu, sigma);
}

generated quantities{
    real F_ppc[N];
    
    for (i in 1:N){
        F_ppc[i] = normal_rng(mu[i], sigma);
    }

}