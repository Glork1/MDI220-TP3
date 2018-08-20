clear all;
close all;
clc;

load usa.txt;

Y = usa(:,1);
n = size(Y);
n = n(1);
sig_hat_modele_complet = 21.9357;
%phi = [ones(n,1) usa(:,2:14)];

for i = 1:(2^13)-1
   phi = ones(n,1);
   CONF{i} = dec2bin(i,13);
   for j = 2:14
       if CONF{i}(j-1)=='1'
           phi = [phi usa(:,j)];
       end
   end
   beta_hat= pinv(phi'*phi)*phi'*Y;
   Y_hat = phi*beta_hat;
   e = Y-Y_hat;
   p = size(phi);
   p = p(2)-1;
   RSS = e'*e;
   d = p;
   AIC(i,1) = (RSS/(sig_hat_modele_complet^2)) +2*d; %+ const ?
   BIC(i,1) = n*log(RSS/n)+log(n)*d; %+ const ?
end
min_AIC = min(AIC)
i_mod_aic = find(AIC==min(min(AIC)));
CONF{i_mod_aic}
min_BIC = min(BIC)
i_mod_bic = find(BIC==min(min(BIC)));
CONF{i_mod_bic}


    



