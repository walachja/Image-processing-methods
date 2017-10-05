% Hledani misky s 24 vzorky
function argout = miska_thaliana(argin1, argin2)

obr = argin1;
pars = argin2;

[mm nn] = size(obr);
pom = double(obr(:,:,1)).*double(obr(:,:,2)); % soucin R a G kanalu
pom = pom - min(pom(:));
pom = pom./max(pom(:));


cary = pom<.15;


cary1 = pom<.25;



% Hledani prave a leve pozici
pom = sum(cary);
pul = floor(length(pom)/2);
left = pom(1:pul);
kde1 = find(left==max(left(:)));
ods = kde1(1) + 40; % ods

right = pom((pul+1):end);
kde2 = find(right==max(right(:)));
dos = pul + kde2(1) - 40; %dos

kus = cary1(pars.cislo(1):pars.cislo(2), pars.cislo(3):pars.cislo(4)); % vyrez
pom = sum(kus,2);
[pks locs] = myfindpeaks(pom); % Najde maxima
kde = (pks<10);
pks(kde)=[];
locs(kde)=[];
if numel(locs)==0
    odr = 0;
else
    odr = locs(1) + 10; % prvni dost velke maximum shora
end

% Druhy napad na hledani horniho okraje
kus1 = obr(pars.cislo(1):pars.cislo(2),:,3); % Vyrez
maska = kus1>205;
maska = bwmorph(maska,'clean');
maska = bwmorph(maska,'majority'); 
m1 = diff(maska,1,1); % Derivace vertikalne
pom1 = sum(m1,2);
odr1 = find(pom1==max(pom1)); % Alternativni navrh
odr1 = odr1(1);



dor = odr + pars.miska(1) + 0.5*(190-odr);
dor = round(min(dor,mm));

dor1 = odr1 + pars.miska(1) + 0.5*(190-odr1);
dor1 = round(min(dor1,mm));

if odr==0
    odr = odr1;
end

argout = [odr dor ods dos; odr1 dor1 ods dos]; % Oba navrhy
    

