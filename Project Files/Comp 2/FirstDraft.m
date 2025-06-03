% dataInput = 0;
clear;
close all;
dataInput = load("jonteimaginary.txt");
dataInput = dataInput(:, 2:17);
dataInput(:,6) = [];

fs = 125;
T = 1/fs;
time = 0:T:(length(dataInput)-1)*T;
% t = 0:1/fs:(length(relaxing(:,4))/fs)-(1/fs);

%pwelch
% [pxx,f] = pwelch(dataInput(:, 4), 500, 200, 60, fs);
% figure;
% plot(f, 10*log10(pxx));
% title('Pwelch');

% pwelch(dataInput)

% [pxx,w] = periodogram(dataInput);
% plot(w,10*log10(pxx))

%% PLOT THE SIGNAL IN FFT, AFTER FILTERING AND FFT AFTER FILTER
% data = dataInput(:, 4);
% data = data';
% N = length(data);
% X0 = fft(data);
% X = X0(1:N/2+1);
% X_mag = abs(X)/N;
% X_mag(2:end-1) = X_mag(2:end-1)*2;
% freq = linspace(0, fs/2, N/2+1);
% figure;
% plot(freq, X_mag);
% title('FFT before filter');
% set(gca, 'ylim', [0 100]);
% 
% bpFilt = designfilt('bandpassfir','FilterOrder',150, ...
% 'CutoffFrequency1',8,'CutoffFrequency2',20, ...
% 'SampleRate',125);
% y = filtfilt(bpFilt, data);
% figure;
% plot(y)
% title('Filtered signal');
% 
% N = length(y);
% X0 = fft(y);
% X = X0(1:N/2+1);
% X_mag = abs(X)/N;
% X_mag(2:end-1) = X_mag(2:end-1)*2;
% freq = linspace(0, fs/2, N/2+1);
% figure;
% plot(freq, X_mag);
% title('FFT on filtered signal');
% set(gca, 'ylim', [0 10]);

%% WINDOWING 
relCount = 1;
gripCount = 1;
count = 1;

%1-9,5 seconds relaxing, first second removing because of noise etc and 0,5 second removed because of transition between relaxed and closed
for i = 125:100:1125
    for j = 1:1:15
        relaxing{relCount,j} = dataInput(i:i+100, j);
    end
    relCount = relCount+1;
end

%10,5-19,5 seconds gripping
for i = 1375:100:2375
    for j = 1:1:15
        gripping{gripCount, j} = dataInput(i:i+100, j);
    end
    gripCount = gripCount+1;
end

%20,5-29,5 seconds relaxing
for i = 2625:100:3625
    for j = 1:1:15
        relaxing{relCount,j} = dataInput(i:i+100, j);
    end
    relCount = relCount+1;
end

%30,5-39,5 seconds gripping
for i = 3875:100:4875
    for j = 1:1:15
        gripping{gripCount, j} = dataInput(i:i+100, j);
    end
    gripCount = gripCount+1;
end

%40,5-49,5 seconds relaxing
for i = 5125:100:6125
    for j = 1:1:15
        relaxing{relCount, j} = dataInput(i:i+100, j);
    end
    relCount = relCount+1;
end

%50,5-59.5 seconds gripping
for i = 6375:100:7375
    for j = 1:1:15
        gripping{gripCount, j} = dataInput(i:i+100, j);
    end
    gripCount = gripCount+1;
end

%60,5-69,5 seconds relaxing
for i = 7625:100:8625
    for j = 1:1:15
        relaxing{relCount, j} = dataInput(i:i+100, j);
    end
    relCount = relCount+1;
end

%70,5-79,5 seconds gripping
for i = 8875:100:9875
    for j = 1:1:15
        gripping{gripCount, j} = dataInput(i:i+100, j);
    end
    gripCount = gripCount+1;
end

%80,5-89,5 seconds relaxing
for i = 10125:100:11125
    for j = 1:1:15
        relaxing{relCount, j} = dataInput(i:i+100, j);
    end
    relCount = relCount+1;
end

%90,5-99,5 seconds gripping
for i = 11375:100:12375
    for j = 1:1:15
        gripping{gripCount, j} = dataInput(i:i+100, j);
    end
    gripCount = gripCount+1;
end

%100,5-109,5 seconds relaxing
for i = 12625:100:13625
    for j = 1:1:15
        relaxing{relCount, j} = dataInput(i:i+100, j);
    end
    relCount = relCount+1;
end

%110,5-119,5 seconds gripping
for i = 13875:100:14875
    for j = 1:1:15
        gripping{gripCount, j} = dataInput(i:i+100, j);
    end
    gripCount = gripCount+1;
end  

%% FILTER

% figure;
% plot(relaxing{:, 4})
% title('Relaxing before filtering');

% bpFilt = designfilt('bandpassiir','FilterOrder',30, ...
%     'HalfPowerFrequency1',8,'HalfPowerFrequency2',15, ...
%     'SampleRate',125);

% bpFilt = designfilt('bandpassfir','FilterOrder',20, ...
% 'CutoffFrequency1',8,'CutoffFrequency2',15, ...
% 'SampleRate',125);
% 
% for i = 1:1:size(relaxing, 1)
%     for j = 1:1:size(relaxing, 2)
%         filterRelaxing{i, j} = filt(bpFilt, relaxing{i, j});
%     end
% end
% 
% % fvtool(bpFilt);
% 
% figure;
% plot(filterRelaxing(:, 4));
% title('Filter Relaxing');
% 
% for i = 1:1:size(gripping, 1)
%     for j = 1:1:size(gripping, 2)
%         filterGripping{i, j} = filtfilt(bpFilt, gripping{i, j});
%     end
% end

% figure;
% plot(filterGripping(:, 4));
% title('Gripping After Filtering');

%% CSP

for i = 1:1:size(relaxing,1)
    for j = 1:1:size(relaxing,2)
        V_relaxing(i, j) = log(var(relaxing{i,j}));
    end
end

for i = 1:1:size(gripping, 1)
    for j = 1:1:size(gripping, 2)
        V_gripping(i, j) = log(var(gripping{i,j}));
    end
end

for i = 1:1:15
    meanRelaxing(1, i) = mean(V_relaxing(:, i));
    meanGripping(1, i) = mean(V_gripping(:, i));
end

meanRelaxing = meanRelaxing';
meanGripping = meanGripping';

figure;
V_together(:, 1) = meanRelaxing;
V_together(:, 2) = meanGripping;
bar(V_together);

% figure;
legend('Relaxing', 'Gripping'); hold off;
title('Variance of relaxing and gripping');

X1 = V_relaxing';    % Positive class data: X1~[C x T]
X2 = V_gripping';    % Negative class data: X2~[C x T]
[W,l,A] = csp(X1,X2);
X1_CSP = W'*X1;
X2_CSP = W'*X2;

% figure;
% scatter(X1_CSP(1,:), X1_CSP(2,:)); hold on;
% scatter(X2_CSP(1,:), X2_CSP(2,:)); hold on;
% legend('class 1', 'class 2'); hold off;
% axis equal; grid on;
% title('After CSP filtering');
% xlabel('Channel 1'); ylabel('Channel 2');
% 

% for i = 1:1:15
%     CSP_relaxing(1, i) = mean(X1_CSP(:, i));
%     CSP_gripping(1, i) = mean(X2_CSP(:, i));
% end

% CSP_relaxing = CSP_relaxing';
% CSP_gripping = CSP_gripping';

figure;
CSP_after(:, 1) = X1_CSP(:, 4)';
CSP_after(:, 2) = X2_CSP(:, 4)';
bar(CSP_after);
legend('Relaxing', 'Gripping'); hold off;

function [W, lambda, A] = csp(X1, X2)

    % Error detection
    if nargin < 2, error('Not enough parameters.'); end
    if length(size(X1))~=2 || length(size(X2))~=2
        error('The size of trial signals must be [C x T]');
    end
    
    % Compute the covariance matrix of each class
    S1 = cov(X1');   % S1~[C x C]
    S2 = cov(X2');   % S2~[C x C]
    
    % Solve the eigenvalue problem S1·W = l·S2·W
    [W,L] = eig(S1, S1 + S2);   % Mixing matrix W (spatial filters are columns)
    lambda = diag(L);           % Eigenvalues
    A = (inv(W))';              % Demixing matrix
    
    % Further notes:
    %   - CSP filtered signal is computed as: X_csp = W'*X;
end

%Plot data as time
% t = 0:1/fs:(length(dataInput)/fs)-(1/fs);
% 
% for i = 2:17
% 
%     figure;
%     plot(t, dataInput(:,i));
% 
% end







