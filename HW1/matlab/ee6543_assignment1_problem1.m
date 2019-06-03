clear ;
clear functions ;
clf ;

Nbits      =  2^5 ;  % (-), number of bits per user.
mu         =  2^(-15) ;  % (-), LMS adaptation constant
Npoints_w  =  1 ;  % (-), number of points in w
D          =  0 ;  % (T-spaced samples), Decoding delay
sigman1    =  10^(-5) ;     % <======== sigma changed
a          =  10 ;  % Transmitter attenuation
b          =  10 ;  % Receiver attenuation
% transmitter data
d1    =   ( 2 * ( rand(1,Nbits) < 0.5 ) - 1 ) ;
s1 = a * b * d1 ;
n1  =  sqrt(sigman1) * randn(1,length(s1)) ;
r1  =  s1 + n1 ;
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
se_db  =  10 * log10(abs(errors1)+eps) ;
plot(se_db,'o') ;
% axis ( [ 0 (Nbits-1) -40 0] ) ;
    
subplot(313) ;
stem(wsave)
