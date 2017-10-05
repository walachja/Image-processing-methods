% Hledani masky rostliny
function argout = maska_hrasek(argin1,argin2)

pars.metoda = argin1;
obr = argin2;

obr2 = rgb2hsv(obr); % Prevod do HSV

H = medfilt2(obr2(:,:,1),[5,5]); % Medianovy filtr pouzity na hue
zelena = (H<.25); % & (H>.05); % Zelena plocha
zelena = bwmorph(zelena,'clean'); % Odstraneni samostatnych pixelu

% Kombinace s vybranou metodou
if pars.metoda == 0
    hrany = canny_hrasek(obr);
elseif pars.metoda == 1
    hrany = cannymoje_hrasek(obr);
elseif pars.metoda == 2
    hrany1 = gradientnifuzzy_hrasek(obr);
    hrany = fuzzykombinace_hrasek(zelena,hrany1);
elseif pars.metoda == 3
    hrany1 = bodovyfuzzy_hrasek(obr);
    hrany = fuzzykombinace_hrasek(zelena,hrany1);
end
    
% Kombinace zelene plochy se zvolenou metodou
% Za hrany rostliny povazuji hrany ze zvolene rostliny, ktere jsou v urite
% vzdalenosti od zelene barvy
vzdal = bwdist(zelena);
maska = zelena | (hrany & (vzdal<10));
maska = bwmorph(maska,'close'); % Morfologicke uzavreni

argout = maska;




