function [varargout] = readcnt(cntfile,eventrange)

if nargin < 2
    eventrange = [1 255];
end

HDR = sopen(cntfile,'r',[],'32bit');
[S,HDR] = sread(HDR,HDR.SPR/HDR.SampleRate,0);
%reorganize the events to delete the repeating events. GZH 04/12/08
firstEventPos = HDR.EVENT.POS(1);
eventPos = HDR.EVENT.POS-firstEventPos+1;
eventSeq = zeros(1,eventPos(end));
eventSeq(eventPos) = HDR.EVENT.TYP;
eventPos = find(eventSeq~=0);
eventType = eventSeq(eventPos);
eventPos = eventPos+firstEventPos-1;
% only valid events were kept
idx = find(eventType>=eventrange(1) & eventType<=eventrange(2));
output_event.type = eventType(idx)';
output_event.pos = eventPos(idx)';

event = output_event;
clab = HDR.Label;

if nargout == 2
    varargout{1} = S;
    varargout{2} = event;
elseif nargout == 3
    varargout{1} = S;
    varargout{2} = event;
    varargout{3} = clab;
end

end