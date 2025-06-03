function Components_blink = pickBlinkComponents(Data_ICA)
% get total number of components from input array
[~, q] = size(Data_ICA);
% initialize counter and output array
i = 1;
Components_blink = [];
while i<q
% find peaks of ith component
% MinPeakDistance informed by average blink rate of 22 blinks/min
% and 500 Hz sampling rate
% MinPeakProminence defined by trial and error
pks = findpeaks(Data_ICA(:,i), ...
'MinPeakDistance', 1500, ...
'MinPeakProminence', 100);
4
% if four peaks exist choose as blink component
if length(pks)==4
Components_blink = [Components_blink i];
end
% increment counter
i = i + 1;
end
end