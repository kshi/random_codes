function [ success_prob ] = random_classifier_probability( X, Y, y1, y2 )
margin = 0.1;
lambda = 0.001;
[n, d] = size(X);
N = double(max(Y));
E = bsxfun(@eq, Y(:), 1:N);
Xatt = X( or(Y==y1, Y==y2), :);
Eatt = E( or(Y==y1, Y==y2), :);
zatt = zeros(10,1);
zatt(y1) = 1;
zatt(y2) = -1;
p = E' * X * inv(X'*X + lambda * eye(d,d)) * sign(-inv(Xatt'*Xatt + lambda * eye(d,d)) * Xatt' * Eatt * zatt);
bias = [p(y1), p(y2)];
prem = p;
prem([y1, y2]) = [];
num_samples = 10000;
deltas = sign(rand(num_samples, N-2) - 0.5) * prem + sum(abs(bias)) > margin;
success_prob = sum(deltas) / num_samples;
end