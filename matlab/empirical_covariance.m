S = zeros(10,10);
for i=1:10
    Xi = X(Y == i, :);
    mi = mean(Xi, 1);
    for j=i:10
        Xj = X(Y == j,:);
        mj = mean(Xj, 1);
        P = bsxfun(@minus, Xi, mi) * bsxfun(@minus, Xj, mj)';
        S(i, j) = mean(P(:));
    end
end