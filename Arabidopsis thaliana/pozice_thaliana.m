% Kvantifikace zelene plochy u zabince

function [argout1 argout2 argout3 argout4] = pozice_thaliana(argin)

jm = argin; % Nazev aktualnio souboru
% argout = [x y] na stole
% argout3 = datum akvizice jako cell
% argout4 je [x]x[y] jako cell

kde1 = strfind(jm,'_');
if length(kde1)~=5
    error('Invalid name format!')
end

% Datum je mezi 2. a 3.
od = kde1(2)+6;
do = kde1(3)-1;
kus = jm(od:do);
argout3 = cellstr(kus); % Datum akvizice

od = kde1(4)+1;
do = kde1(5)-1;
kus = jm(od:do);

kde2 = strfind(kus,'-');
kde3 = strfind(kus,'x');
% Kazde tam musi byt prave jednou
if length(kde2)~=1 || length(kde3)~=1
   error('Invalid name format!')
end

x = kus((kde2+1):(kde3-1));
x = str2double(x);

y = kus((kde3+1):end);
y = str2double(y);

argout1 = x;
argout2 = y;

argout4 = cellstr([num2str(x) 'x'  num2str(y)]);

