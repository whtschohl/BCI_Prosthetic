clear;
close all;
%%
Fs = 125;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 5002;             % Length of signal
t = (0:L-1)*T;        % Time vector


S = 0.3*sin(2*pi*8*t) + 0.3*sin(2*pi*9*t) + 0.3*sin(2*pi*10*t) + 0.3*sin(2*pi*11*t) + 0.3*sin(2*pi*12*t);

% figure;
% plot(t, S);
% title('signal uncorupted');


X = S + 2*randn(size(t));
%%
% figure;
% plot(t,X)
% title('Signal Corrupted with Zero-Mean Random Noise')
% xlabel('t (milliseconds)')
% ylabel('X(t)')
test = load('OpenBCI-RAW-2021-12-21_20-11-24.txt');
%X = test(:,2:17);
test = test(125:end,2:17);
test(:,6) = [];
test(:,7) = [];
X = test;
%X = test(:,4);


figure;
plot(X);
title('raw signal');

Y = fft(X);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
set(gca,'ylim',[0 20]);

% Works good
% bpFilt = designfilt('bandpassiir','FilterOrder',30, ...
%          'HalfPowerFrequency1',8,'HalfPowerFrequency2',25, ...
%          'SampleRate',125);
     
bpFilt = designfilt('bandpassiir','FilterOrder',30, ...
'HalfPowerFrequency1',8,'HalfPowerFrequency2',15, ...
'SampleRate',125);
y = filtfilt(bpFilt, X);


%bpFilt = designfilt('bandpassiir','FilterOrder',30, ...
%         'PassbandFrequency1',8,'PassbandFrequency2',15, ...
%         'SampleRate',125, 'DesignMethod', 'butter');
%bpFilt = designfilt('bandpassiir', 'PassbandFrequency1', 8, 'PassbandFrequency2', 15,...
%                    'SampleRate', 125, 'DesignMethod', 'butter', ...
%                    'MatchExactly', 'passband');
%bpFilt = designfilt('bandpassiir', 'PassbandFrequency1', 8, 'PassbandFrequency2', 15, ...
%                    'PassbandRipple', 1, 'SampleRate', 125, 'DesignMethod', 'butter');
% bpFilt = designfilt('bandpassiir', 'FilterOrder', 30, ...
%                     'PassbandFrequency1', 8, 'PassbandFrequency2', 15, ...
%                     'PassbandRipple', 1);


%bpFilt = chebyll()
% bpFilt = load('butter.mat');
% SOS = bpFilt.SOS;
% G = bpFilt.G;
% %y = sosfilt(bpFilt, X);
% [b,a] = sos2tf(SOS,G);
% y = filtfilt(b, a, X);
%y = filtfilt(bpFilt, X);

     
% bpFilt = designfilt('bandpassfir','FilterOrder',80, ...
%          'CutoffFrequency1',8,'CutoffFrequency2',20, ...
%          'SampleRate',125);
% y = filter(bpFilt, X);


fvtool(bpFilt);
figure;
plot(y)
title('signal efter filter');


Y = fft(y);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);


f = Fs*(0:(L/2))/L;
figure;
plot(f,P1) 
title('fft after filtering')
xlabel('f (Hz)')
ylabel('|P1(f)|')



% Y = fft(S);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);


% figure;
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of S(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
