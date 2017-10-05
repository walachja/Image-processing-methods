% Obrys rostliny

function obrys_hrasek(argin1, argin2, argin3)

kytka = argin1;
maska = argin2;
parskresli = argin3; % ([pohled rostlina cislo mod])
% mod = 1 ulozeni na disk, mod = 2 zobrazeni na obrazovku

% Vytvoreni jmena ukladanemu souboru
if parskresli(1) == 1
    poh = 'zprava';
elseif parskresli(1) == 2
    poh = 'zhora';
else
    poh = 'zepredu';
end

if parskresli(2) == 1;
    kyt = 'predni kytka';
else
    kyt = 'zadni kytka';
end

perim = bwperim(maska);
[ii jj] = find(perim);

% Zobrazeni na obrazovku
if parskresli(4)==2 
    cislo = 10*parskresli(1) + parskresli(2);
    figure(cislo) 
    imshow(kytka)    
    hold on
    plot(jj,ii,'r.','MarkerSize',1);

    str = ['Pohled ' poh ', ' kyt ': automaticka kontura'];
    title(str)
    hold off
    
% Ulozeni na disk
elseif parskresli(4)==1 
    
    cis = num2str(parskresli(3),'%03g'); % cislo snimku
    jm = [cis '_' kyt '_' poh '.png'];
    kde = sub2ind(size(maska),ii,jj);
    c1 = kytka(:,:,1); c1(kde)=255;
    c2 = kytka(:,:,2); c2(kde)=255;
    c3 = kytka(:,:,3); c3(kde)=255;
    kytkaven = kytka;
    kytkaven(:,:,1) = c1;
    kytkaven(:,:,2) = c2;
    kytkaven(:,:,3) = c3;
    imwrite(kytkaven,jm,'png');

else
    % Zadna akce
    
end