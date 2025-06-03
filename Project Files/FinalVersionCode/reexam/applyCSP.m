function [pX1_CSP, pX2_CSP]  = applyCSP(classOne, classTwo, W)
for i = 1:size(classOne, 3)
    X1_CSP(:,:,i) = W'*classOne(:,:,i)';
    X2_CSP(:,:,i) = W'*classTwo(:,:,i)';
end
pX1_CSP = permute(X1_CSP,[2 1 3]);
pX2_CSP = permute(X2_CSP,[2 1 3]);

clearvars X1_CSP X2_CSP mS1 mS2 L i z x
clearvars S1 S2