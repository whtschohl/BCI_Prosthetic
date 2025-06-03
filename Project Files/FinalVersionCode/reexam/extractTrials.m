function [classOne, classTwo]  = extractTrials(data, interval, seconds, fs)
    trials = seconds/interval;
    data = data(:,2:17);
    data(:,11) = [];
    data(:,7) = [];
    data(:,6) = [];
    samples = linspace(fs, ((fs*interval)-fs), ((fs*interval)-2*fs)/100+1);
    idxOne = 0;
    idxTwo = 0;
    for j = 0:2:trials-1
        for i = 1:interval-1
            classOne(:,:,i+((interval-1)*idxOne)) = data(samples(i)+fs*interval*j:samples(i+1)+fs*interval*j-1,:);
        end
        idxOne = idxOne+1;
    end
    for j = 1:2:trials
        for i = 1:interval-1
            classTwo(:,:,i+((interval-1)*idxTwo)) = data(samples(i)+fs*interval*j:samples(i+1)+fs*interval*j-1,:);
        end
        idxTwo = idxTwo+1;
    end
end