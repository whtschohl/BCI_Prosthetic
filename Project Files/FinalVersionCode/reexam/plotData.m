load("vX1_CSP.mat");
load("vX2_CSP.mat");
load("vCO.mat");
load("vCT.mat");
figure
scatter(vCO, vCO);
hold on;
scatter(vCT, vCT);
hold on;

figure
scatter(vX1_CSP, vX1_CSP);
hold on;
scatter(vX2_CSP, vX2_CSP);
hold on;


