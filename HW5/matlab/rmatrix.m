% build and analyze the R matrix
sigma_n2 = 0.001;
sigma_b2 = 1;
h_0 = 1;
h_1 = 1;
h = [h_0 ; h_1];
N = 32;

r_0 = sigma_n2 + sigma_b2 * (h_0^2 + h_1^2);
r_1 = sigma_b2 * h_0 * h_1;

R = eye(N) * r_0;
r1_diag = eye(N-1) * r_1;
up_diag = [ zeros(N-1,1) r1_diag ; zeros(N,1)'];

bot_diag = [zeros(N,1)'; r1_diag zeros(N-1,1) ];

R = R + up_diag + bot_diag;

lambda_i = eig(R);
ratio = max(lambda_i) / min(lambda_i)

