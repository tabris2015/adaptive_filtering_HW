clear ;
clear functions ;
clf ;

load assignment3problem1data1
baby_and_mother = assignment3problem1data1 ;

load assignment3problem1data2
mother = assignment3problem1data2 ;

load assignment3problem1data3
times1 = assignment3problem1data3 ;

load assignment3problem1data4
Ts = assignment3problem1data4 ;

% Common parameters.
ref_heart_rate    =  60.0        ;  % (beats per minute), reference heart rate

subplot(211) ;
plot(times1,baby_and_mother*1e3) ;
title('Amplitude of baby and mother''s heart signal versus time') ;
ylabel('Amplitude, a_n, (mV)') ;
xlabel('Time, t, (s)') ;

subplot(212) ;
plot(times1,mother*1e3) ;
title('Amplitude of mother''s heart signal versus time') ;
ylabel('Amplitude, b_n, (mV)') ;
xlabel('Time, t, (s)') ;
