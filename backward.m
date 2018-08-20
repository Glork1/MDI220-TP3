clear all;
close all;
clc;

load usa.txt;

Y = usa(:,1);
n = size(Y);
n = n(1);
sig_hat_modele_complet = 21.9357;
usa_aux = usa(:,2:14);
phi = [ones(n,1) usa_aux]; %phi du modèle complet

CONF{1}='1111111111111'; %modèle complet: 1 représente une variable retenue
q=14
for j=2:q
        usa_aux_bis = usa_aux
        for i = 2:14
                if (CONF{1}(i-1)=='1')  %i-1 n'a pas encore été éliminée
                    usa_aux_bis(:,i-1+1)=[];
                    phibis = [phi usa_aux_bis];
                    beta_hat= pinv(phibis'*phibis)*phibis'*Y;
                    Y_hat = phibis*beta_hat;
                    e = Y-Y_hat;
                    p = size(phibis);
                    p = p(2)-1;   
                    RSS(i-1) = e'*e;
                end
        end
        min_RSS(j-1) = min(RSS);
        i_selec = find(RSS==min(min(RSS))); %i_selec: indice de la variable ajoutée qui minimise le RSS
        usa_aux(:,i_selec) = [];
        phi = [phi usa_aux];
        CONF{1}(i_selec) = '0';
        CONF{j} = CONF{1};%on met dans CONF{j} le modèle courant dans l'algorithme forward
        p = size(phi);
        p = p(2)-1;
        d = p;
        AIC(j-1,1) = (min_RSS(j-1)/(sig_hat_modele_complet^2)) +2*d; %+ const ?
        BIC(j-1,1) = n*log(min_RSS(j-1)/n)+log(n)*d; %+ const ?
        q = q-1;
end
min_AIC = min(AIC)
i_mod_aic = find(AIC==min(min(AIC)));
CONF{i_mod_aic} = dec2bin(bin2dec(CONF{i_mod_aic})+(2^14)-1);
CONF{i_mod_aic}
min_BIC = min(BIC)
i_mod_bic = find(BIC==min(min(BIC)));
CONF{i_mod_bic} = dec2bin(bin2dec(CONF{i_mod_bic})+(2^14)-1);
CONF{i_mod_bic}


