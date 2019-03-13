%% ============ 20170727 自动读取拼接多段数据

function  [S,event,clab] = read_multifile(file)
     
     [S,event,clab] = readcnt(file{1});
     if length(file)>1
        for file_idx =2:length(file)
             [S2,event2,clab] = readcnt(file{file_idx});
            event.type = cat(1,event.type,event2.type);% TYPE
            event2.pos = event2.pos + size(S,1);       % POS
            event.pos = cat(1,event.pos,event2.pos);  % POS
            S = cat(1,S,S2);                           % Signal


        end
     
     end






end