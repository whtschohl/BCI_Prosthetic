function[W, WW] = getW(classOne, classTwo)
    for i = 1:size(classOne, 3)
        S1(:,:,i) = cov(classOne(:,:,i));
        S2(:,:,i) = cov(classTwo(:,:,i));
    end
    mS1 = mean(S1, 3);
    mS2 = mean(S2, 3);

    %Eigenvalue W
    [W,L] = eig(mS1, mS1 + mS2);   % Mixing matrix W (spatial filters are columns)

    %Whitening W
    [U,S,V] = svd(mS1 + mS2);
    SP = S.^(-0.5);
    SP(~isfinite(SP)) = 0;
    P = U*SP;
    [B,z,x] = svd(P'*mS2*P);
    WW = P*B;

    clearvars X1_CSP X2_CSP mS1 mS2 L i z x
    clearvars S1 S2
end