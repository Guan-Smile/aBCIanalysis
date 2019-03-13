%% 合并数据

FOR_TRAIN=[X,Y];
%% 
% 注意每次需要训练模型并将模型导出，注意代码中的模型名称与导出模型名称对应。

% 
% %% my deal _ for ori run
%  X_test = dataAll(indexTest,:);
% yfit(1,:) = trainedModel.predictFcn(X_test);%
% yfit(2,:) = trainedModel1.predictFcn(X_test);%svmc
% yfit(3,:)= trainedModel2.predictFcn(X_test);%svmq
% yfit(4,:)= Ld.predictFcn(X_test); %es SD
% 
% Y_targetTrue = targetAll(indexTest);  %%测试集真实标签
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

Y_targetTrue = Y %%测试集真实标签
 
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
legend('原始标签Y','预测标签yfit');
axis([0 length(Y_targetTrue) -1 1]);
title('预测结果与真实情况的对比')

% num_err=length(find(Y~=yfit));
% accrate=1-num_err/length(Y)




