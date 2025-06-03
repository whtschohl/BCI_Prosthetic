one = load("../data/OpenBCI-RAW-2021-12-21_20-11-24.txt");
two = load("../data/OpenBCI-RAW-2021-12-21_20-16-15.txt");
three = load("../data/OpenBCI-RAW-2021-12-21_20-19-23.txt");
four = load("../data/OpenBCI-RAW-2021-12-21_20-22-41.txt");
five = load("../data/OpenBCI-RAW-2021-12-22_18-29-37.txt");
six = load("../data/OpenBCI-RAW-2021-12-22_18-32-33.txt");
seven = load("../data/OpenBCI-RAW-2021-12-22_18-34-49.txt");
eight = load("../data/OpenBCI-RAW-2021-12-22_18-37-15.txt");
nine = load("../data/OpenBCI-RAW-2021-12-21_20-11-24.txt");

fs = 125;
interval = 6;
seconds = 120;
[classOne1, classTwo1] = extractTrials(one, interval, seconds, fs);
[classOne2, classTwo2] = extractTrials(two, interval, seconds, fs);
[classOne3, classTwo3] = extractTrials(three, interval, seconds, fs);
[classOne4, classTwo4] = extractTrials(four, interval, seconds, fs);
[classOne5, classTwo5] = extractTrials(five, interval, seconds, fs);
[classOne6, classTwo6] = extractTrials(six, interval, seconds, fs);
[classOne7, classTwo7] = extractTrials(seven, interval, seconds, fs);
[classOne8, classTwo8] = extractTrials(eight, interval, seconds, fs);
nine(:,9) = nine(:,11);
[classOne9, classTwo9] = extractTrials(nine, interval, seconds, fs);
%%
classOne = cat(3, classOne1, classOne2, classOne3, classOne4, classOne5, classOne6, classOne7, classOne8, classOne9);
classTwo = cat(3, classTwo1, classTwo2, classTwo3, classTwo4, classTwo5, classTwo6, classTwo7, classTwo8, classTwo9);
clearvars one two three four five six seven eight nine
clearvars classOne1 classOne2 classOne3 classOne4 classOne5 classOne6 classOne7 classOne8 classOne9
clearvars classTwo1 classTwo2 classTwo3 classTwo4 classTwo5 classTwo6 classTwo7 classTwo8 classTwo9


