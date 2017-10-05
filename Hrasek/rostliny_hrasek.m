% Hledani dvou rostlin
% Pripadne rucni rozdeleni rostlin v pripade, ze jsou spojene

% argout.vyrez1 je vyrez prvni rostliny
% argout.maska1 je maska prvni rostliny
% argout.vyrez2 je vyrez druhe rostliny
% argout.maska2 je maska druhe rostliny

function argout = rostliny_hrasek(argin1,argin2,argin3)

maska = argin1; % Upravena maska celeho snimku
obr = argin2; % Cely obrazek
pos = argin3; % Pozice, kde se s jistotou vyskytuje kus rostliny 

% 1.radek [odr dor ods dos] predni rostliny
% 2.radek [odr dor ods dos] zadni rostliny


[L num] = bwlabel(maska);
stats = regionprops(L,'Area','PixelIdxList');
plochy = [stats.Area];
plochy = plochy';

% Hledame nejvetsi souvisly kus, ktery protina pos
ktere = false(num,2); % Kandidati na prvni a druhou kytku
for i=1:1:num
    kde = stats(i).PixelIdxList; % Seznam pixelu
    [rad,sloup] = ind2sub(size(maska),kde); 
    podm1 = (rad > pos(1,1) & rad < pos(1,2));
    podm2 = (sloup > pos(1,3) & sloup < pos(1,4));
    podm = sum(podm1 & podm2)>100;
    ktere(i,1) = podm;
    
    podm1 = (rad > pos(2,1) & rad < pos(2,2));
    podm2 = (sloup > pos(2,3) & sloup < pos(2,4));
    podm = sum(podm1 & podm2)>100;
    ktere(i,2) = podm;
    
end
M = [plochy (1:1:num)'];

N = M(ktere(:,1),:); % Prvni rostlina, vsechny plochy
N = sortrows(N,-1); % Serazeni podle plochy sestupne
idx = N(1,2); % Cislo nejvetsiho objektu
kde = stats(idx).PixelIdxList; % Seznam pixelu
rostlina1 = false(size(maska));
rostlina1(kde) = true;

N = M(ktere(:,2),:); % Druha rostlina, vsechny plochy
N = sortrows(N,-1); % Serazeni podle plochy sestupne
idx = N(1,2); % Cislo nejvetsiho objektu
kde = stats(idx).PixelIdxList; % Seznam pixelu
kytka2 = false(size(maska));
kytka2(kde) = true;

% Pripadne rucni deleni
slite = rostlina1 & kytka2;
slite = any(slite(:));
if slite
    [rostlina1 kytka2] = rozsekni_hrasek(rostlina1,obr);
end

[mm nn] = size(maska);

kde = find(rostlina1); % Seznam pixelu
[rad,sloup] = ind2sub([mm nn],kde);
odr = max(1,min(rad)-50);
dor = min(mm,max(rad)+50);
ods = max(1,min(sloup)-50);
dos = min(nn,max(sloup)+50);

% Vzstupy funkce
argout.vyrez1 = obr(odr:dor,ods:dos,:);
pom = rostlina1(odr:dor,ods:dos,:);
argout.maska1 = bwmorph(pom,'close');

kde = find(kytka2); % Seznam pixelu
[rad,sloup] = ind2sub([mm nn],kde);
odr = max(1,min(rad)-50);
dor = min(mm,max(rad)+50);
ods = max(1,min(sloup)-50);
dos = min(nn,max(sloup)+50);

argout.vyrez2 = obr(odr:dor,ods:dos,:);
pom = kytka2(odr:dor,ods:dos,:);

argout.maska2 = bwmorph(pom,'close');
