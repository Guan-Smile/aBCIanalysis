%% �ϲ�����

FOR_TRAIN=[X,Y];
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
 X_test = X;
yfit(1,:) = trainedModel4.predictFcn(X_test);%
yfit(2,:) = trainedModel1.predictFcn(X_test);%svmc
yfit(3,:)= trainedModel2.predictFcn(X_test);%svmq
yfit(4,:)= trainedModel3.predictFcn(X_test); %es SD

Y_targetTrue = Y %%���Լ���ʵ��ǩ
 
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




