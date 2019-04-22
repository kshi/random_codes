lambda = 0.01;
N = 10;
d = 784;
y1 = 1;
y2 = 2;
%Xtrain = [randn(N, d)];
Xtrain = zeros(N, d);
for i=1:10
    Xi = X(Y==i,:);
    Xtrain(i,:) = Xi(ceil(size(Xi, 1) * rand()), :);
end
Ytrain = [1:N];
Xatt = Xtrain( or(Ytrain==y1, Ytrain==y2), :);
zatt = [1; -1];
w = Xtrain * inv(Xtrain'*Xtrain + lambda * eye(d,d)) * sign(-inv(Xatt'*Xatt + lambda * eye(d,d)) * Xatt' * zatt)