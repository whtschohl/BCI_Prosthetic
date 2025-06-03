clear;
close all;

%%udp config%%
u=udpport("IPV4");
configureTerminator(u,"CR/LF");
%%..............................%%

%%%.....................input training matrixes and filters.....%%%
W=load('D:\Neurotechnology\Project Files\FinalVersionCode\Code 1B\W.mat');
W=W.W;
SVMModel=load('D:\Neurotechnology\Project Files\FinalVersionCode\Code 1B\mdl.mat', '-mat')
SVMModel=SVMModel.SVMModel
bpFilt=load('D:\Neurotechnology\Project Files\FinalVersionCode\Code 1B\bpFilt.mat');
bpFilt=bpFilt.bpFilt;


% %%..........................................................%%%%%%%%
% 
% % instantiate the library
% disp('Loading the library...');
% lib = lsl_loadlib();
% 
% % resolve a stream...
% disp('Resolving an EEG stream...');
% result = {};
% while isempty(result)
%     result = lsl_resolve_byprop(lib,'type','PUKK');
% end
% 
% % create a new inlet
% disp('Opening an inlet...');
% inlet = lsl_inlet(result{1});
% 
% packetcount=0;
% count=0;
% 
% disp('Now receiving data...');
% %%tic; %%%gets timestamps for the system
% while true
% count=count+1;
% [vec,ts] = inlet.pull_sample();
% 
% %-------Broken electrodes-------------%
% vec(:,9)=vec(:,11); %change place for 9 and 11 due channel 9 is broken
% vec(:,11)=[]; %removes channel 11
% vec(:,6)=[]; %remove channel 6
% vec(:,6)=[]; %remove channel 7
% %--------------------%
% 
% arr(count,:)=vec;
% if(count>=100)
% %matrix(1+(count*(packetcount-1)):count*packetcount,:)=arr;%%saves to
% %matrix
%   count=0;
%   packetcount=packetcount+1;
%   prediction(arr,W,bpFilt,SVMModel,packetcount,u);
% 
%    % timematrix(1,packetcount)=toc; %%relates to tic
% end
% end
% 
% function prediction(packet,W,bpFilt,SVMModel,packetcount,u)
% 
% dataInput=packet;
% % filter
% 
% %dataInput är window vi får
% dataInput = filtfilt(bpFilt, dataInput);
% 
% % CSP
% % här måste vi också ha W i workspace innan. 
% dataCSP = W'*dataInput';
% dataCSP = dataCSP';
% dataCSP = log(var(dataCSP(:,:)))';
% 
% % SVM
% dataSVM = dataCSP([1,end],:)';
% 
% %SVMModel måste också vara i workspace
% guess = predict(SVMModel, dataSVM);
% 
% %bubbelkolla så att 0 är öppen hand, 1 är stängd
% if guess == 0
%     output = "0000000";
% elseif guess == 1 
%     output = "1000000";
% end
%  disp([packetcount, guess]);
%  writeline(u,output,"10.132.191.224",1337);
% % Send to comp 3 IP=10.132.191.224
% 
% end