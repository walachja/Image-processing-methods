%% HRASEK
% '1_imgX' pohled z prave strany
% '2_imgX' pohled shora
% '3_imgX' pohled zepredu
% X je cislo snimku, stejna rostlina ma  vzdy stejne X
% Obrazek: ohranicena rostlina
pars.kresli = 1; % 0 zadna akce, 1 ulozeni na disk, 2 zobrazeni na obrazovku

% Metoda analyzy
pars.metoda = 0; % 0 canny, 1 canny_vlastni, 2 gradientni fuzzy metoda, 3 bodova fuzzy metoda 

if pars.metoda == 3
    disp('This method might take a long time')
end
%% Nacitani obsahu slozky
S = dir('imagess\*.png'); % Nacteni jmen souboru 
names = {S.name};
del = floor(length(names)/3);
vysledek = zeros(del,6); % prelokace pro vzsledky

%% Manualni zadani polohy rostliny
% Urceni mista, kde rostlina vyrusta z kvetinace

% Z prave strany
pars.pohled1pos1 = [1700 1800 1150 1350]; % predni (vlevo)
pars.pohled1pos2 = [1600 1700 1510 1700]; % zadni (vpravo)

% Zepredu
pars.pohled3pos1 = [1250 1310 960 1150]; % zadni (vlevo)
pars.pohled3pos2 = [1280 1350 1530 1730]; % predni (vpravo)

% Shora
pars.pohled2pos1 = [540 890 720 1080]; % zadni (vlevo)  
pars.pohled2pos2 = [1020 1380 1520 1870]; % predni (vpravo) 

%% Z pravé strany

pars.pohled = 1; % Pohled z prave strany
ktere = pohled_hrasek(pars.pohled,names); % Indexy obrazku na otevreni

for i = 1:1:length(ktere)
    jm = ['imagess\' char(names(ktere(i)))];
    obr = imread(jm,'png');
    disp(['Analyzing image ' jm])

    maska = maska_hrasek(pars.metoda,obr);  % Vytvori masku obou rostlin
    pos = [pars.pohled1pos1; pars.pohled1pos2];  % Pozice korenu
    maska = odlesky_hrasek(maska,pos); % Odstraneni odlesku u kvetinacu
    maska = tycka_hrasek(maska); % Pokud rostlinu drzi tycka, propoji obe casti rostliny
    obe = rostliny_hrasek(maska,obr,pos); % Najde obe rostliny, pripadne je rucne rozdeli
    
    if pars.kresli>0 % Pokud chci vysledek ulozit nebo zobrazit
        parskresli = [pars.pohled 1 i pars.kresli]; % [pohled, rostlina, cislo]
        obrys_hrasek(obe.vyrez1,obe.maska1,parskresli);
        parskresli = [pars.pohled 2 i pars.kresli]; % [pohled, rostlina, cislo]
        obrys_hrasek(obe.vyrez2,obe.maska2,parskresli);
    end
    
    vysledek(i,1) = sum(obe.maska1(:)); % Plocha predni rostliny
    vysledek(i,4) = sum(obe.maska2(:)); % Plocha zadni rostliny
    
end

%% Zepredu 

pars.pohled = 3; % Pohled zepredu
ktere = pohled_hrasek(pars.pohled,names); % Indexy rostlin na otevreni

for i = 1:1:length(ktere)
    jm = ['images\' char(names(ktere(i)))];
    obr = imread(jm,'png');
    disp(['Analyzing image ' jm])
    
    obr(1380:end,:,:)=[]; % Orezani mista pod kvetinacema

    maska = maska_hrasek(pars.metoda,obr);  % Vytvori masku obou rostlin
    pos = [pars.pohled3pos1; pars.pohled3pos2];  % Pozice korenu
    maska = odlesky_hrasek(maska,pos); % Odstraneni odlesku u kvetinacu
    maska = tycka_hrasek(maska); % Pokud rostlinu drzi tycka, propoji obe casti rostliny
    obe = rostliny_hrasek(maska,obr,pos); % Najde obe rostliny, pripadne je rucne rozdeli
    
    if pars.kresli>0
        parskresli = [pars.pohled 2 i pars.kresli]; % [pohled, rostlina, cislo]
        obrys_hrasek(obe.vyrez1,obe.maska1,parskresli);
        parskresli = [pars.pohled 1 i pars.kresli]; % [pohled, rostlina, cislo]
        obrys_hrasek(obe.vyrez2,obe.maska2,parskresli);
    end
    
    vysledek(i,5) = sum(obe.maska1(:)); % Plocha predni rostliny
    vysledek(i,2) = sum(obe.maska2(:)); % Plocha zadni rostliny
    
end

%% Shora

pars.pohled = 2;
ktere = pohled_hrasek(pars.pohled,names);  %Indexy obrazku na otevreni

for i = 1:1:length(ktere)
    jm = ['images\' char(names(ktere(i)))];
    obr = imread(jm,'png');
    disp(['Analyzing image ' jm])
    % V tomto pripade nic neorezavam
    
    maska = maska_shora_hrasek(obr,pars.metoda);  % Vytvori masku obou rostlin
    pos = [pars.pohled2pos1; pars.pohled2pos2];  % Pozice korenu
    maska = tycka_hrasek(maska); % Odstraneni odlesku u kvetinacu
    obe = rostliny_hrasek(maska,obr,pos); % Najde obe rostliny, pripadne je rucne rozdeli
    
    if pars.kresli>0
        parskresli = [pars.pohled 2 i pars.kresli]; % [pohled, rostlina, cislo]
        obrys_hrasek(obe.vyrez1,obe.maska1,parskresli);
        parskresli = [pars.pohled 1 i pars.kresli]; % [pohled, rostlina, cislo]
        obrys_hrasek(obe.vyrez2,obe.maska2,parskresli);
    end

    vysledek(i,6) = sum(obe.maska1(:)); % Plocha predni rostliny
    vysledek(i,3) = sum(obe.maska2(:)); % Plocha zadni rostliny
    
end

%% Zapis dat

csvwrite('results.csv',vysledek)

% Poradi:   1) Predni z prave strany
%           2) Predni zepredu
%           3) Predni shora
%           4) Zadni z prave strany
%           5) Zadni zepredu
%           6) Zadni shora

