load assignment3problem1data1
bm = assignment3problem1data1 ;

load assignment3problem1data2
m = assignment3problem1data2 ;

load assignment3problem1data3
t = assignment3problem1data3 ;

load assignment3problem1data4
T = assignment3problem1data4 ;

[r, L] = size(t);

Fs = 1/Ts;

% fourier transform
Y = fft(bm);
%spectrum
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1);
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')