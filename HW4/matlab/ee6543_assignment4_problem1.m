clear ;
clear functions ;
clf ;
Nbits      =  60 ;  % (-), number of bits.
Npoints_w  =  2^5 ;  % (-), number of points in w
D          =  2^4 ;  % (T-spaced samples), Decoding delay
sigman2    =  10^(-4) ;
% For RLS, time starts at 1.
% transmitter data
sigmab2 = 1 ;
bn    =   ( 2 * ( rand(Nbits,1) < 0.5 ) - 1 ) ;
dn    =   [ zeros(D,1) ; bn ] ;
% channel
h = [ 1  1   0   0     ].' ;
% received signal
sn = conv(h,bn) ;
% generate noise
eta_n  =  sqrt(sigman2) * randn(length(sn),1) ;
% add noise
rn  =  sn + eta_n ;
% Set the un vector.
un  =  zeros(Npoints_w,1) ;
% Make a vector to hold all the errors.
errors1   =   0 * dn ;
Emins     =   0 * dn ;
woptn = zeros(Npoints_w,1) ;
% RLS initialization, time n=0 belongs here:
% Put your code here.
%%%%%%%%%%%%%%%CODE%%%%%%%%%%%%%%%%%%
lambda = 0.95;      % forgetting factor
delta = sigman2 / (sigmab2 * (h' * h));     
Pn = (1/delta) * eye(Npoints_w);
Eminn = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for n  =  1 : Nbits ,
        % un is from
        un  =  [ rn(n) ; un( 1 : (Npoints_w-1) ) ] ;
        % dn is from
        %  dn(n)
        % RLS, times n = 1, 2, 3, ... belongs here:
        % and put your code here.
        %%%%%%%%%%%%%%%%%%%CODE%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Pin = Pn * un;
        kn = Pin / (lambda + un' * Pin);
        Pn = (1/lambda) * Pn - (1/lambda) * kn * Pin';
        alphan = dn(n) - woptn' * un;
        woptn = woptn + kn* alphan;
        en = dn(n) - woptn' * un;
        Eminn = lambda * Eminn + en*alphan;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        errors1(n)  =     en ;
        Emins(n)    =  Eminn ;
end

iw = [ 0 : (length(woptn)-1) ] ;
subplot(311) ;
stem(iw,woptn,'ok') ;
ylabel('wopt(n)') ;
xlabel('Time index, i, (-)') ;
subplot(312) ;
se_db  =  20* log10(abs(errors1)) ;
plot(se_db,'k-') ;
% axis ( [ 0 (Nbits-1) -40 0] ) ;
axis ( [ 0 (Nbits-1) -90 30] ) ;
ylabel('Squared error, SE, (dB)') ;
xlabel('Time index, i, (-)') ;
grid ; 
subplot(313) ;
se_db  =  20* log10(abs(Emins)) ;
plot(se_db,'k-') ;
ylabel('LS error, Emin, (dB)') ;
xlabel('Time index, i, (-)') ;
grid ; 

