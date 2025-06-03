

%% filter
%jag tycker vi ska byta ut till ett annat filter. och då ha filteret redan 
%i workspace
bpFilt = designfilt('bandpassiir','FilterOrder',30, ...
'HalfPowerFrequency1',8,'HalfPowerFrequency2',15, ...
'SampleRate',250);

%dataInput är window vi får
dataInput = filtfilt(bpFilt, dataInput);

%% CSP
% här måste vi också ha W i workspace innan. 
dataCSP = W'*dataInput';
dataCSP = dataCSP';
dataCSP = log(var(dataCSP(:,:)))';

%% SVM
dataSVM = dataCSP([1,end],:)';

%SVMModel måste också vara i workspace
guess = predict(SVMModel, dataSVM);

%bubbelkolla så att 0 är öppen hand, 1 är stängd
if guess == 0
    output = "0000000";
elseif guess == 1 
    output = "1000000";
end
    
%% Send to comp 3
% lägg in UDP koden här och så skickar vi output
