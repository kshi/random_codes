T = zeros(10,10);
for i=1:10
    for j=1:10
        if i~=j
            T(i,j) = random_classifier_probability(X,Y,i,j);
        end
    end
end