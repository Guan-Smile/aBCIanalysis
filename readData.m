function [varargout] = readData(datasource, winlen,  hdfilter)

if isstruct(datasource)
    S = datasource.S;
    eventStruct = datasource.eventStruct;
    clab = datasource.clab;
else
    [S,eventStruct,clab] = read_multifile(datasource);
end

SEEG = S;

%% Regress out EOG
% SEOG = S(:,1:2);
% SEEG = S-SEOG*(SEOG'*SEOG)^(-1)*(SEOG'*S);

%% Adaptive filtering
% SEOG = S(:,1:2);
% M = 3; % order
% gamma = 0.99; % RLS forgetting factor
% P0 = eye(M);
% ha = adaptfilt.rls(M,gamma,P0);
% SEEG = S - filter(ha,SEOG(:,1),S);
% SEEG = SEEG - filter(ha,SEOG(:,2),S);

% Re-reference
% S_filtered = S - kron(mean(S,2), ones(1, size(S,2))); % CAR
% if exist('reflen','var')
%     numRef = reflen;
% else
%     numRef = 0;
% end

if exist('hdfilter','var')
     S_filtered = filter(hdfilter, SEEG);
    %S_filtered = filtfilt(hdfilter.numerator,1,SEEG);
else
    S_filtered = S;
end

fs=250;
% zhouyajun_20180421
% eventStruct.type(546)=77;
% eventStruct.type = [eventStruct.type(1:235);20;eventStruct.type(236:end)];
% eventStruct.pos = [eventStruct.pos(1:235);eventStruct.pos(236)-5*fs;eventStruct.pos(236:end)];

% gaowei_20180427
% eventStruct.type(114)=77;
% eventStruct.type = [eventStruct.type(1:539);88;eventStruct.type(540:end)];
% eventStruct.pos = [eventStruct.pos(1:539);eventStruct.pos(539)+22*fs;eventStruct.pos(540:end)];

% zhouyajun_20180428
% eventStruct.type(422)=77;
%eventStruct.type = [eventStruct.type(1:664);88;eventStruct.type(665:end)];
%eventStruct.pos = [eventStruct.pos(1:664);eventStruct.pos(664)+20*fs;eventStruct.pos(664:end)];
% zhouyajun_20180428
% eventStruct.type(422)=77;
% eventStruct.type = [eventStruct.type(1:507);88;eventStruct.type(508:end)];
% eventStruct.pos = [eventStruct.pos(1:507);eventStruct.pos(507)+20*fs;eventStruct.pos(508:end)];

cue_pos = find(eventStruct.type>=0 & eventStruct.type<=60);
end_pos = find(eventStruct.type==88);
numTrials = max(length(end_pos),length(cue_pos));
%numTrials = length(cue_pos);% The last character may not be complete.
%numChars = length(unique(eventStruct.type(cue_pos(1)+1:cue_pos(2)-1)));
%numResponse = 150;
%numSamples = numRef + numResponse;
%numRepeats = round((cue_pos(2)-cue_pos(1))/numChars);
numChannels = size(S, 2);
base_line = cell(numTrials, 1);
source_signal = cell(numTrials, 1);
target = zeros(numTrials, 1);

for i = 1:numTrials
    source_signal{i} = S_filtered(eventStruct.pos(cue_pos(i))+1+3*fs:eventStruct.pos(end_pos(i)),:);
     %source_signal{i} = S_filtered(eventStruct.pos(cue_pos(i))+1+3*fs:eventStruct.pos(cue_pos(i))+3*fs+winlen*fs,:);
    base_line{i} = S_filtered(eventStruct.pos(cue_pos(i))+1:eventStruct.pos(cue_pos(i))+3*fs,:);
    target(i) = eventStruct.type(cue_pos(i));
end

if nargout == 3
    varargout{1} = source_signal;
    varargout{2} = base_line;
    varargout{3} = target;
elseif nargout == 4
    varargout{1} = source_signal;
    varargout{2} = base_line;
    varargout{3} = target;
    varargout{4} = clab;
end