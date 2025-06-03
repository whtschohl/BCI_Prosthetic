function [trainData, testData, trainLabels, testLabels]  = splitData(X1_F, X2_F, classOne, classTwo)
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
    clearvars X1_F X2_F
end