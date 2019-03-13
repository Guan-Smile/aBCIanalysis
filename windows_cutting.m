function [source_signal_cut,base_line_cut,target_cut]=windows_cutting(source_signal,base_line,target,winlen,slidelen)
%winlen:所需窗长
%slidelen:最小间隔窗长
numTrials = length(target);
source_signal_cut = [];
base_line_cut = [];
target_cut = [];
for i = 1 : numTrials
    numWin = floor((size(source_signal{i},1) - winlen)/slidelen)+1;
    source_temp = [];
    base_temp = [];
    target_temp = [];
    for j = 1 : numWin
        source_temp{j,1} = source_signal{i}((j-1)*slidelen+1:(j-1)*slidelen+winlen,:);
        base_temp{j,1} = base_line{i};
        target_temp(j,1) = target(i);
    end
    source_signal_cut = [source_signal_cut; source_temp];
    base_line_cut = [base_line_cut; base_temp];
    target_cut = [target_cut;target_temp];
end