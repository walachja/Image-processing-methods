% Hledani masky rostliny shora

function argout = maska_shora_hrasek(argin,metoda)

obr = argin;
obr2 = rgb2hsv(obr); % Prevod do HSV

H = obr2(:,:,1); % Hue
V = obr2(:,:,3); % Value

% Zelena plocha
zelena = (H<.30) & (H>.15) & (V>0.15) & (V<0.60);
zelena = bwmorph(zelena,'clean');
zelena = bwmorph(zelena,'close');


% Kombinace s vybranou metodou
if metoda == 0
    hrany = canny_hrasek(obr);
elseif metoda == 1
    hrany = cannymoje_hrasek(obr);
elseif metoda == 2
    hrany1 = gradientnifuzzy_hrasek(obr);
    hrany = fuzzykombinace_hrasek(zelena,hrany1);
elseif metoda == 3
    hrany = bodovyfuzzy_hrasek(obr);
end

% Kombinace zelene plochy se zvolenou metodou
% Za hrany rostliny povazuji hrany ze zvolene rostliny, ktere jsou v urite
% vzdalenosti od zelene barvy
vzdal = bwdist(zelena);
maska = zelena | (hrany & (vzdal<10));
maska = bwmorph(maska,'close'); % Morfologicke uzavreni

argout = maska;




