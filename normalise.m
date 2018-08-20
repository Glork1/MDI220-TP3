function Xn = normalise(X)
    dim = size(X);
    n = dim(1);
    p = dim(2);
    for j = 1:p
        mj = 0;
        sigjc = 0;
        for i = 1:n
            mj = mj+X(i,j);
        end
        mj = mj/n;
        for q = 1:n
            sigjc = (X(q,j)-mj)^2;
        end
        sigjc = sigjc/n;
        for k = 1:n
            Xn(k,j) = (X(k,j)-mj)/sqrt(sigjc*n);
        end
    end
end

            
            