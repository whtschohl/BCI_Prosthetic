clear; close all; clc
warning('off')
load('openData')
% plot Fp1 electrode data (sits at front left part of head hear left eye)
% perturbations can be seen visually due to blinks
plot(openData(:,1))
title("Fp1 Before Blink Removal", 'FontSize', 14)

%% PCA
% DEFINE NUMBER OF PRINICPLE COMPONENTS TO KEEP
% NOTE: it is typically a good idea to try out different numbers and
% compare their total explained variation
q=17;
% PERFORM PCA
% NOTE: it is important to normalize data! (i.e. substract mean of each
% column and divide by standard deviation. MATLAB's pca function does this
% automatically :p
[coeff,Data_PCA,latent,tsquared,explained,mu] = pca(openData,'NumComponents', q);
% compute and display explained variation
disp(strcat("Top ", string(q), " principle components explain ", ...
string(sum(explained(1:q))), " of variation"))

%% ICA
% compute independent components from principle components
% train ICA model
Mdl = rica(Data_PCA, q);
% apply ica
Data_ICA = transform(Mdl, Data_PCA);

%% Plot Component

%  define number of plots per column of figure
plotsPerCol = 7;
% plot components
figure(2)
for i = 1:q
subplot(plotsPerCol,ceil(q/plotsPerCol),i)
plot(Data_ICA(:,i).^2)
title(strcat("Component ", string(i), " Squared"))
ax = gca;
ax.XTickLabel = {};
end

%% Remove embedded Blink Information

Components_blink = pickBlinkComponents(Data_ICA);
disp("Blink component(s):")

disp(Components_blink)

% zero all columns corresponsing to blink components
Data_ICA_noBlinks = Data_ICA;
Data_ICA_noBlinks(:,Components_blink) = ...
zeros(length(Data_ICA), length(Components_blink));
% perform inverse ica transform
Data_PCA_noBlinks = Data_ICA_noBlinks*Mdl.TransformWeights;
% perform inverse pca transform
Data_noBlinks = Data_PCA_noBlinks*coeff';
% plot Fp1 electrode before and after
figure(3)
subplot(2,1,1)
plot(openData(:,1))
title("Fp1 Before Blink Removal", 'FontSize', 14)
subplot(2,1,2)
plot(Data_noBlinks(:,1))
title("Fp1 After Blink Removal", 'FontSize', 14)
