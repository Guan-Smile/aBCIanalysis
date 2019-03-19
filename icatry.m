%% icatry

   [ic, W, T, mu]=fastICA(source_signal{1}',5,'kurtosis',1);
   Zr = T \ W' * ic + repmat(mu,1,size(source_signal{1},1));
   
%    eegplot(ic,'winlength',60);
   eegplot(Zr,'winlength',60);
   