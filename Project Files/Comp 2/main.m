%% Import Data
load("D:\Neurotechnology\Project Files\FinalVersionCode\Code 2B\finalVersion\mat\classOne.mat");
load("D:\Neurotechnology\Project Files\FinalVersionCode\Code 2B\finalVersion\mat\classTwo.mat");
load("D:\Neurotechnology\Project Files\FinalVersionCode\Code 2B\finalVersion\mat\bpFilt.mat");
load("D:\Neurotechnology\Project Files\FinalVersionCode\Code 2B\finalVersion\mat\mdl.mat");
%% Filter
for i = 1:size(classOne, 3);
    classOne(:,:,i) = filtfilt(bpFilt, classOne(:,:,i));
    classTwo(:,:,i) = filtfilt(bpFilt, classTwo(:,:,i));
end
%% LogVar before CSP
for i = 1:size(classOne, 3) 
    vCO(:,i) = log(var(classOne(:,:,i))');
    vCT(:,i) = log(var(classTwo(:,:,i))');
end

mVCO = mean(vCO, 2);
mVCT = mean(vCT, 2);
both(:,1) = mVCO;
both(:,2) = mVCT;
figure
bar(both)
clearvars both
%clearvars vCO vCT
%clearvars mVCO mVCT
%% CSP
for i = 1:size(classOne, 3)
    S1(:,:,i) = cov(classOne(:,:,i));
    S2(:,:,i) = cov(classTwo(:,:,i));
end
mS1 = mean(S1, 3);
mS2 = mean(S2, 3);
[W,L] = eig(mS1, mS1 + mS2);   % Mixing matrix W (spatial filters are columns)

for i = 1:size(classOne, 3)
    X1_CSP(:,:,i) = W'*classOne(:,:,i)';
    X2_CSP(:,:,i) = W'*classTwo(:,:,i)';
end

pX1_CSP = permute(X1_CSP,[2 1 3]);
pX2_CSP = permute(X2_CSP,[2 1 3]);
clearvars X1_CSP X2_CSP mS1 mS2 L S1 S2
%% LogVar after CSP
for i = 1:size(pX1_CSP, 3) 
    vX1_CSP(:,i) = log(var(pX1_CSP(:,:,i))');
    vX2_CSP(:,i) = log(var(pX2_CSP(:,:,i))');
end

mvX1_CSP = mean(vX1_CSP, 2);
mvX2_CSP = mean(vX2_CSP, 2);
both(:,1) = mvX1_CSP;
both(:,2) = mvX2_CSP;
figure
bar(both);
clearvars both mvX1_CSP mvX2_CSP
%% Extract Ends
X1_F = vX1_CSP([1,end],:)';
X2_F = vX2_CSP([1,end],:)';
%% Split Data
cv = cvpartition(size(X1_F, 1),'HoldOut',0.2);
idx = cv.test;
% Separate training and test data
dataTrainOne = X1_F(~idx,:);
dataTrainTwo = X2_F(~idx,:);
dataTestOne  = X1_F(idx,:);
dataTestTwo  = X2_F(idx,:);
trainData = cat(1, dataTrainOne, dataTrainTwo);
testData = cat(1, dataTestOne, dataTestTwo);
clearvars dataTrainOne dataTrainTwo dataTestOne dataTestTwo

trainLabelOne = zeros(round(size(classOne,3)*0.8),1);
trainLabelTwo = ones(round(size(classTwo,3)*0.8),1);
trainLabels = cat(1, trainLabelOne, trainLabelTwo);
clearvars trainLabelOne trainLabelTwo

testLabelOne = zeros(round(size(classOne,3)*0.2),1);
testLabelTwo = ones(round(size(classTwo,3)*0.2),1);
testLabels = cat(1, testLabelOne, testLabelTwo);
clearvars testLabelOne testLabelTwo

%allLabels = zeros(120,1);
%allLabels(61:120) = 1;
%% SVM
%SVMModel = fitcsvm(trainData,trainLabels,'Standardize',true,'KernelFunction','Linear');
%% SVM Optimize
%cData = [X1_F;X2_F];
cv = cvpartition(size(trainData, 1),'KFold',5);
opts = struct('CVPartition',cv,'AcquisitionFunctionName','expected-improvement-plus');
Mdl = fitcsvm(trainData,trainLabels,'KernelFunction','linear', ...
    'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts);
%sum(predict(SVMModel, testData)==testLabels)/24*100
%CVSVM = crossval(SVMModel);
%miss = kfoldLoss(CVSVM)
%% Pretict SVM
%guess = predict(SVMModel, testData);
%acc = sum(testLabels == guess)/24
%% Predict Opt
v = predict(Mdl, testData);

acc = sum(testLabels == v)/round(size(classTwo,3)*0.2*2)
%L_test = loss(Mdl, testData, testLabels)
