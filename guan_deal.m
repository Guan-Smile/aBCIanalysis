% clear
%% ��ȡ�ļ�
datapath = '..\mat_data\';
 ALL_fortrain=[];
 ALL_fortest=[];
% namelist = dir([datapath '*.mat']);
% All_name=cat(1,namelist.name);
namelist = foreachDir(datapath);
All_name=cat(1,namelist{1:length(namelist)});
for con=1:size(All_name,1)
    All_name{con}
    foruse=load(All_name{con});
    ALL_fortrain=[ ALL_fortrain; foruse.FOR_TRAIN];
    ALL_fortest=[ ALL_fortest; foruse.FOR_TEST];
end
randIndex = randperm(size(ALL_fortrain,1));
ALL_fortrain=ALL_fortrain(randIndex,:);

%% �ϲ�����
% FOR_TRAIN=[X,Y];
%% 
% ע��ÿ����Ҫѵ��ģ�Ͳ���ģ�͵�����ע������е�ģ�������뵼��ģ�����ƶ�Ӧ��

% 
% %% my deal _ for ori run
%  X_test = dataAll(indexTest,:);
% yfit(1,:) = trainedModel.predictFcn(X_test);%
% yfit(2,:) = trainedModel1.predictFcn(X_test);%svmc
% yfit(3,:)= trainedModel2.predictFcn(X_test);%svmq
% yfit(4,:)= Ld.predictFcn(X_test); %es SD
% 
% Y_targetTrue = targetAll(indexTest);  %%���Լ���ʵ��ǩ
%  
% accrat =length(find(squeeze(yfit(1,:)) == Y_targetTrue'))/length(indexTest)
% accrat1 =length(find(squeeze(yfit(2,:)) == Y_targetTrue'))/length(indexTest)
% accrat2 =length(find(squeeze(yfit(3,:)) == Y_targetTrue'))/length(indexTest)
% accrat3 =length(find(squeeze(yfit(4,:)) == Y_targetTrue'))/length(indexTest)


%% my deal _ for other run
 X_test = ALL_fortest(:,1:150);%X;
yfit(1,:) = trainedModel.predictFcn(X_test);%
yfit(2,:) = trainedModel1.predictFcn(X_test);%svmc
yfit(3,:)= trainedModel2.predictFcn(X_test);%svmq
yfit(4,:)= trainedModel3.predictFcn(X_test); %es SD

Y_targetTrue = ALL_fortest(:,151);%Y %%���Լ���ʵ��ǩ
 
accrat =length(find(squeeze(yfit(1,:)) == Y_targetTrue'))/length(Y_targetTrue)
accrat1 =length(find(squeeze(yfit(2,:)) == Y_targetTrue'))/length(Y_targetTrue)
accrat2 =length(find(squeeze(yfit(3,:)) == Y_targetTrue'))/length(Y_targetTrue)
accrat3 =length(find(squeeze(yfit(4,:)) == Y_targetTrue'))/length(Y_targetTrue)

%% plot

plot(1:length(Y_targetTrue),Y_targetTrue,'*k-')
hold on
for ii=1:size(yfit,1)
plot(yfit(ii,:)','o-')
drawnow
end
legend('ԭʼ��ǩY','Ԥ���ǩyfit');
axis([0 length(Y_targetTrue) -1 1]);
title('Ԥ��������ʵ����ĶԱ�')

% num_err=length(find(Y~=yfit));
% accrate=1-num_err/length(Y)
%% plot2 -accrate
ap=zeros(1,length(Y_targetTrue));
[ap_yy,ap_xx]=find(squeeze(yfit(3,:)) == Y_targetTrue');
ap(ap_xx)=1;
plot(ap,'-p')


