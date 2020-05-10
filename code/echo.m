[x,fs]=audioread('audio1.wav');
%calculate impulse response 
n=0:1:size(x,1);
h1=dirac(n);
index=h1==Inf;
h1(index)=1;
h2=dirac(n-0.25*fs);
index=h2==Inf;
h2(index)=0.9;
h3=dirac(n-0.5*fs);
index=h3==Inf;
h3(index)=0.8;
h4=dirac(n-0.75*fs);
index=h4==Inf;
h4(index)=0.7;
h=h1+h2+h3+h4;
stem(n(1,1:fs),h(1,1:fs));
title('Impulse Response');
xlabel('Time');
ylabel('Impulse Response');
%generate echo sound
echo_sound=conv(x,h);
%remove silent part at the end
echo_sound=echo_sound(1,1:size(x,1)+(fs*0.75));
audiowrite('echo_sound.wav',echo_sound,fs);
%remove echo
echo_sound_freq=fft(echo_sound);
h_freq=fft(h,size(echo_sound,2));
original_sound_freq=echo_sound_freq./h_freq;
original_sound_time=ifft(original_sound_freq,size(x,1));
audiowrite('original_sound.wav',real(original_sound_time),fs);