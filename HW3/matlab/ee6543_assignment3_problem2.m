
clear ;
clear functions ;
clf ;

Nbits      =  2^16 ;  % (-), number of bits per user.
mu         =  2^(-10) ;  % (-), LMS adaptation constant
Npoints_w  =  2^5 ;  % (-), number of points in w
D          =  2^4 ;  % (T-spaced samples), Decoding delay
sigman1    =  10^(-4) ;

% transmitter data
d1    =   ( 2 * ( rand(1,Nbits) < 0.5 ) - 1 ) ;

% channel
h = [ 1  1    1    0   ] ;
%h = [ 1  0.5  0.3  0.2 ] ;
%h = [ 0  1    0    0   ] ; 
% h = [ 1  0    0    0   ] ; 
%h = [ 1  0    0    0   ] ; 

% received signal
s1 = conv(h,d1) ;

% generate noise
n1  =  sqrt(sigman1) * randn(1,length(s1)) ;

% add noise
r1  =  s1 + n1 ;

w   =  zeros(1,Npoints_w) ;
rn  =  zeros(1,Npoints_w) ;

% Make a vector to hold all the errors.
errors1   =   0 * d1 ;

% Implement the LMS algorithm in this loop.
for i  =  1 : length(r1) ,
    if   ( 1 <= (i-D) )  &&  ( (i-D) <= length(d1) )  ,

        rn  =  [ r1(i)  rn( 1 : (Npoints_w-1) ) ] ;
        u1  =  w * (rn .') ;

        e1  =  d1( i - D ) - u1 ;
        errors1(i-D) = e1 ;

        w   =   w  +  mu * e1 * rn ;
    end
end

iw = [ 0 : (length(w)-1) ] ;

subplot(211) ;
stem(iw,abs(w).^2,'o') ;
ylabel('|w|^2') ;
xlabel('Time index, i, (-)') ;
    
subplot(212) ;
se_db  =  20 * log10(abs(errors1)) ;
plot(se_db) ;
axis ( [ 0 (Nbits-1) -40 0] ) ;
ylabel('Squared error, SE, (dB)') ;
xlabel('Time index, i, (-)') ;
