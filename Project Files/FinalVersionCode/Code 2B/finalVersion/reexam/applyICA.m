rawData = readtable("OpenBCI-RAW-2021-12-22_18-29-37.txt");
dataToRemove = {'SampleIndex','Other','Other_1','Other_2','Other_3','Other_4','Other_5','Other_6','AnalogChannel0','AnalogChannel1','AnalogChannel2','Other_7','Timestamp_Formatted_'};
rawDataNew = removevars(rawData,dataToRemove);
data = table2array(rawDataNew);

q=18;
%% PCA
Data_PCA = pca(data, 'NumComponents', q);
%% ICA
mdl = rica(Data_PCA, q);

Data_ICA = transform(mdl, Data_PCA);

%% Plots
% define number of plots per column of figure
plotsPerCol = 9;
% plot components
figure(2)
for i = 1:q

 subplot(plotsPerCol,ceil(q/plotsPerCol),i)
 plot(Data_ICA(:,i))
 title(strcat("Component ", string(i), " Squared"))
 ax = gca;
 ax.XTickLabel = {};

end
