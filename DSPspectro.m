info = audioinfo("OldLove_PartialSolo.wav");
[y,Fs] = audioread("OldLoveSolo.wav");
%info = audioinfo("solo2.wav");
%[y,Fs] = audioread("solo2.wav");
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);
y = y(:,1);
M = 50;
L = 10;
g = bartlett(M);
Ndft = 2048;
yf = DSPisolate(400,1000, y, Fs, info); %300 1100 for case solo2
ftest = transpose(linspace(0,2048,5000));
[s, f, t, psd] = spectrogram(yf, 300, 10, ftest, Fs, "psd", "yaxis");
%[s, f, t, psd] = spectrogram(yf, 300, 10, 2048, 4096, "reassigned", "onesided", "psd");
colormap(flipud(jet))
sound(yf,Fs)

maxfreq = zeros(1,length(psd(1,:)));
for i = 1:length(maxfreq)
    [val, fidx] = max(psd(:,i));
    maxfreq(1,i) = f(fidx);
end
maxfreq = maxfreq;
minv = min(maxfreq);
maxv = max(maxfreq);
figure(1)
plot(movmean(maxfreq,20),'LineWidth',3);
title('Moving average of maximum power frequency of filtered signal')
noteline(minv, maxv)
%plot(movmean(yf,300))
