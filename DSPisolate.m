function [yf] = filterT(l,h, y, Fs, info)
%info = audioinfo("OldLoveSolo.wav");
%[y,Fs] = audioread("OldLoveSolo.wav");
%sound(y,Fs)
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);
%plot(t,y(:,1))
%xlabel('Time')
%ylabel('Audio Signal')

s1 = fft(y(:,1));
P2 = abs(s1/length(s1));     %scaling perchè DFT/FFT è una somma
P1 = P2(1:(length(s1))/2+1);    %seleziono solo le frequenze che non sono duplicate
f = Fs*(0:(length(s1)))/length(s1);
% figure(1)
% plot(f(1:5000),P2(1:5000)) 
% xlabel("f (Hz)")
% ylabel("|P1(f)|")


%% Filter

indices320 = f>l; %400
indices650 = f<h; %1000
indicesf = f;
for i = 1:length(f)
    if indices320(1,i) == 1 && indices650(1,i) == 1
        indicesf(1,i) = 1;
    else
        indicesf(1,i) = 0;
    end
end

indicesf = transpose(indicesf);
indicesf = indicesf(1:end-1);
s2 = indicesf.*s1;
% figure(1)
% plot(f(1:end-1), s1) 
% figure(2)
% plot(f(1:end-1), s2)
s3 = s1;
s3(1:(length(s1))/2+1) = s2(1:(length(s1))/2+1);
fs2 = flip(s2);
s3((length(s1))/2+1:end) = fs2((length(s1))/2+1:end);
% figure(3)
% plot(f(1:end-1), s3)

yf = ifft(s3,"symmetric");
%sound(yf,Fs)
%% Remove noise

% indicesn = abs(s3)>6;
% s4 = indicesn.*s3;
% % figure(3)
% % plot(f(1:end-1), s4)
% yn = ifft(s4,"symmetric");
% sound(yn,Fs)
end
