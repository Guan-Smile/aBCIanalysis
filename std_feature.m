function X = std_feature(input_epoch,std_means)

switch(std_means)

    case 'zscore_trial'
        for i=1:size(input_epoch,1)
             X(i,:) = zscore(input_epoch(i,:));
        end
    case 'svmscale'
        X = svmscale(input_epoch,[0 1],'models/range','s');
    case 'zscore'
        X = zscore(input_epoch);
    case 'mapminmax' 
        X = mapminmax(input_epoch);
    case 'none'
        X = input_epoch;
end 


end