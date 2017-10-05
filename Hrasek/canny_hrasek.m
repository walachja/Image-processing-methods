%% Cannyho metoda, pomoci funkce z matlabu

function argout = canny_hrasek(argin)

obr = argin;
%prah = 0.08;
prah = 0.06;
[a b c] = size(obr);

% Prevod do stupnu sedi
if c == 3
    obr = rgb2gray(obr);
end   

% Cannyho detekce hran
hrany = edge(obr,'canny',prah);

argout = hrany;