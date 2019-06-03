
% This is the adaptation in module SA, but with no noise added.

clear ;
clear functions ;
clf ;

Nbits      =  2^7 ;  % (-), number of bits per user.
mu         =  2^(-1) ;  % (-), LMS adaptation constant
Npoints_w  =  1 ;  % (-), number of points in w
D          =  0 ;  % (T-spaced samples), Decoding delay
a          =  1 ;  % Transmitter attenuation
b          =  1 ;  % Receiver attenuation

% transmitter data
d1    =   ( 2 * ( rand(1,Nbits) < 0.5 ) - 1 ) ;

% i = 0:(Nbits-1) ;
% stem(i,d1,'o') ;

s1 = a * b * d1 ;

% There is no noise added.
r1  =  s1 ;

w   =  zeros(1,Npoints_w) ;
rn  =  zeros(1,Npoints_w) ;

errors1   =   0 * d1 ;

wsave = [] ;
for i  =  1 : length(r1) ,
    if   ( 1 <= (i-D) )  &  ( (i-D) <= length(d1) )  ,

        rn  =  [ r1(i)  rn( 1 : (Npoints_w-1) ) ] ;
        u1  =  w * (rn .') ;

        e1  =  d1( i - D ) - u1 ;
        errors1(i-D) = e1 ;

        w   =   w  +  mu * e1 * rn ;
        wsave  =  [ wsave w ] ;
    end
end

iw = [ 0 : (length(w)-1) ] ;

subplot(311) ;
stem(iw,abs(w).^2,'o') ;
ylabel('|w|^2') ;
xlabel('Index, i, (-)') ;
    
subplot(312) ;
se_db  =  20 * log10(abs(errors1)+eps) ;
plot(se_db,'o') ;
% axis ( [ 0 (Nbits-1) -40 0] ) ;
    
subplot(313) ;
stem(wsave)
