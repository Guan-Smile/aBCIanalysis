%% �ϲ�����

FOR_TRAIN=[X,Y];



%% my deal
 X_test = dataAll(indexTest,:);
yfit(1,:) = trainedModel.predictFcn(X_test);%
yfit(2,:) = trainedModel1.predictFcn(X_test);%svmc
yfit(3,:)= trainedModel2.predictFcn(X_test);%svmq
yfit(4,:)= Ld.predictFcn(X_test); %es SD

Y_targetTrue = targetAll(indexTest);  %%���Լ���ʵ��ǩ
 
accrat =length(find(squeeze(yfit(1,:)) == Y_targetTrue'))/length(indexTest)
accrat1 =length(find(squeeze(yfit(2,:)) == Y_targetTrue'))/length(indexTest)
accrat2 =length(find(squeeze(yfit(3,:)) == Y_targetTrue'))/length(indexTest)
accrat3 =length(find(squeeze(yfit(4,:)) == Y_targetTrue'))/length(indexTest)
%% plot

plot(1:length(Y_targetTrue),Y_targetTrue,'*r-')
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




