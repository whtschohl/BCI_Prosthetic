function [vCO, vCT]  = logVar(classOne, classTwo, boolPlot, boolAxis)
    for i = 1:size(classOne, 1) 
        vCO(:,i) = log(var(classOne(:,:,i))');
        vCT(:,i) = log(var(classTwo(:,:,i))');
    end
    if boolPlot == 1
        mVCO = mean(vCO, 2);
        mVCT = mean(vCT, 2);
        both(:,1) = mVCO;
        both(:,2) = mVCT;
        figure
        bar(both)
        title('Natural logaritmic variance of each channel averaged over all trials')
        xlabel('Channels');
        ylabel('Natural Logaritc Variance')
        if boolAxis == 1
            legend({'Class One','Class Two'},'Location','northeast')
            axis([0 14 0 6])
        end
        if boolAxis == 2
            legend({'Class One','Class Two'},'Location','southeast')
            axis([0 14 -2 0])
        end
        %clearvars both i
        %clearvars vCO vCT
        %clearvars mVCO mVCT
    end
end