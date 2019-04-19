% function  diff_entropy  = extract_DE_new(epoch_std,Fs)
% %      extract_ED_feature
% %   compute ES of every 1s data,and then compute DE
% %         HHY. 2016.
% NFFT=512;
% f = Fs/2*linspace(0,1,NFFT/2); 
% 
% for channel =1:size(epoch_std,1)
%     for section =1:floor( length(epoch_std)/(5*Fs) )%round( length(epoch_std)/Fs )%ÿ����Ϊһ�� ����psd
%       
%         section_data = epoch_std(channel,(section-1)*Fs+1:section*Fs );
%         window =hanning(length(section_data))';
%         Pxx = abs (fft(section_data .* window,NFFT));
%         section_de(section,:) = band_DE(Pxx,f);
%     end
%     de_mean = mean(section_de,1);
%     de(channel,:) = de_mean;
% end
% 
%    diff_entropy =reshape(de',1,size(de,1)*size(de,2));%% de' feature rank through channels
%    
% end
%function  [diff_entropy rasm_feature] = extract_DE_CV(epoch_std,Fs,window_length)
function  [diff_entropy,Pxx_out_mean ] = extract_DE_CV_guan(epoch_std,Fs,window_length)
%      extract_ED_feature
time_sec =  window_length;%1*Fs ; %length(epoch_std);%  %�Զ೤����Ϊһ������
NFFT=2^nextpow2(time_sec);
f = Fs/2*linspace(0,1,NFFT/2);
%window = hanning(time_sec);
for channel =3:size(epoch_std,1)
    PXX_all=[];
    for section =1:floor( length(epoch_std)/time_sec )%ÿ��������Ϊһ�� ����psd
    %%%%%%%%%% design hanning window :   
        window =hanning(time_sec)';
   %%%%%%%%%%%%% 
        section_data = epoch_std(channel,(section-1)*time_sec+1:section*time_sec );
        Pxx = abs (fft(section_data .*window,NFFT));
        PXX_all=[PXX_all;Pxx];
        section_de(section,:) = band_DE(Pxx,f);
    end
    Pxx_mean=mean(PXX_all,1);
%     [X,Y] = meshgrid(200:length(Pxx)/2,1:section);
% R =X+Y;
% Z = PXX_all(R);
%    figure(1)
%    surface(Z)
%    view(3)
    de_mean = mean(section_de,1);
    de(channel,:) = de_mean;
    Pxx_out(channel,:) = Pxx_mean;
end
%%%=======DE Feature
   diff_entropy =reshape(de',1,size(de,1)*size(de,2));%% de' feature rank through channels
    Pxx_out_mean=mean(Pxx_out,1);
%     [X,Y] = meshgrid(200:length(Pxx)/2,1:size(Pxx_out,1));
% R =X+Y;
% Z = Pxx_out(R);
%    figure(1)
%    surface(Z)
%    view(3)
%%%======= RASM = DE_left / DE_ right;
    % rasm_channel = RASM(de);
   %rasm_feature =reshape( rasm_channel' , 1,size(rasm_channel,1)*size(rasm_channel,2));
   
end
function band_DE = band_DE(Pxx,f)
    band(1, :) = [1 3];%[2 3.8];% delta band
    band(2, :) = [4 7];% theta band
    band(3, :) = [8 10];% alpha band p1
    band(6, :) = [11 13];%alpha band p2
    band(4, :) = [14 22];% beta band p1
    band(7, :) = [23 30];% beta band p2
    band(5, :) = [31 48];% gamma band
    for i = 1:size(band,1)
        idx = find( f>=band(i, 1) & f<=band(i, 2) );
       % psd(1, i) = mean( Pxx(idx) );
        psd(1,i) =mean( Pxx(idx).*Pxx(idx) );% ES band MEAN energy spectral
    end
    band_DE = log10(psd);
end
function RASM_feature = RASM(de)
    RASM_feature(1,:) = de(1,:)./de(2,:);% [FP1 FP2]
    
    RASM_feature(2,:) = de(3,:)./de(7,:);% [F7 F8]
    RASM_feature(3,:) = de(4,:)./de(6,:);% [F3 F4]
    
    RASM_feature(4,:) = de(8,:)./de(12,:);% [FT7 FT8]
    RASM_feature(5,:) = de(9,:)./de(11,:);% [FC3 FC4]
    
    RASM_feature(6,:) = de(13,:)./de(17,:);% [T7 T8]
  %  RASM_feature(7,:) = de(14,:)./de(16,:);% [C3 C4]
    
%     RASM_feature(8,:) = de(18,:)./de(22,:);% [TP7 TP8]
%     RASM_feature(9,:) = de(19,:)./de(21,:);% [CP3 CP4]
%     
%     RASM_feature(10,:) = de(23,:)./de(27,:);% [P7 P8]
%     RASM_feature(11,:) = de(24,:)./de(26,:);% [P3 P4]
%     
%     RASM_feature(12,:) = de(28,:)./de(30,:);% [O1 O2]
end