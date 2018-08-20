function Xc = centre(X)
    dim = size(X);
    n = dim(1);
    p = dim(2);
    for j = 1:p
        mj = 0;
        for i = 1:n
            mj = mj+X(i,j);
        end
        mj = mj/n;
        for k = 1:n
            Xc(k,j) = (X(k,j)-mj);
        end
    end
end