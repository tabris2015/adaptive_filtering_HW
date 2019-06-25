
load assignment3problem1data1
d = assignment3problem1data1 ; % mother and baby
load assignment3problem1data2
x = assignment3problem1data2 ;  % mother
load assignment3problem1data3
t = assignment3problem1data3 ; %timestamps
load assignment3problem1data4
T = assignment3problem1data4 ;

[r, L] = size(t);

% filter coefficients
mu         =  2^(-8) ;  % (-), LMS adaptation constant
Npoints_w  =  4 ;  % (-), number of points in w
w = zeros(1, Npoints_w);
xn  =  zeros(1,Npoints_w) ; 
% LMS algorithm
for i  =  1 : length(x) ,
    if   ( 1 <= (i) )  &&  ( (i) <= length(x) )  ,
        xn  =  [ x(i)  xn( 1 : (Npoints_w-1) ) ] ;
        u1  =  w * (xn .') ;
        e1  =  d(i) - u1 ;
        e(i) = e1 ;
        w   =   w  +  mu * e1 * xn ;
    end
end

%estimate BPM
last_i = 1;
delta_t = [];
for i = 2:length(x)-1
    if x(i) > max(x)/2
        if x(i) > x(i-1) && x(i) > x(i+1)
            delta_t = [delta_t (t(i) - t(last_i))];
            last_i = i;
        end
    end
end
BPM_mother = 60/mean(delta_t)

% for baby
last_i = 1;
delta_t = [];
for i = 2:length(e)-1
    if e(i) > max(e)/2
        if e(i) > e(i-1) && e(i) > e(i+1)
            delta_t = [delta_t (t(i) - t(last_i))];
            last_i = i;
        end
    end
end
BPM_bay = 60/mean(delta_t)
%plots
clf
subplot(311)
plot(t, x);
title('mother')
subplot(312)
plot(t, d);
title('mother and baby')
subplot(313)
plot(t, e);
title('baby estimated')

figure
stem(w)

