% Arabidopsis thaliana
% Program na vyhodnoceni zelene plochy

%% Zadavani parametru
pars.ramecek = [500 2150]; % [ods dos]
pars.miska =  [1670 1085]; % Velikost
pars.cislo = [1 350 450 1150]; % Cislo misky

load kolecka % Maska misek
mkdir('results')

%% Nacitani souboru

S = dir('imagess\*.png'); %Nacte jmena ve slozce images
names = {S.name}; % Jmena

polohy = zeros(length(names),2); % Alokace na [x y] pozici na stole
plochy = zeros(length(names),24); % Alokace na plochy zabince po sloupcich
fileid = cell(length(names),2); % [datum akvizice  [x]x[y]poloha]
kontrola = zeros(length(names),2); %[pokus chyba]

%% Zhotovi vyrezy a odstrani prazdne fotky

for i=1:1:length(names) % Pres vsechny soubory
    
    jm = ['imagess\' char(names(i))];
    obr1 = imread(jm,'png');
    disp(['Analyzing image ' jm '...'])
    disp(['...' num2str(i) ' out of ' num2str(length(names)) '.'])
    
    % Ulozeni ID snimku
    jm = char(names(i));
    [xx yy datum xxy] = pozice_thaliana(jm);
    polohy(i,:) = [xx yy]; % Ulozeni do hlavicky
    fileid(i,1) = datum; 
    fileid(i,2) = xxy;

    obr = obr1(:,pars.ramecek(1):pars.ramecek(2),:); % Vyrez
    rohy = miska_thaliana(obr,pars); % [odr dor ods dos]
    % Vraceni dvou navrhu : 
    % [odr dor ods dos] a druhy radek [odr1 dor1 ods dos]
    
    % Prvni pokus
    obr = obr(rohy(1,1):rohy(1,2),rohy(1,3):rohy(1,4),:); % Prvni navrh
    hsv = rgb2hsv(obr);
    H = hsv(:,:,1); S = hsv(:,:,2); V = hsv(:,:,3); 
    zelena = (H<.4) & (S>.1) & (V<.75);
    zelena = bwmorph(zelena,'close');
    zelena = bwmorph(zelena,'clean');
    
    kol = imresize(kolecka,size(zelena),'nearest');
    
    % Hledani chyb
    prunik = zelena & kol; % Zelena v kolech
    celek = sum(zelena(:)); % Celkem zelene
    mimo = celek - sum(prunik(:));
    pomer = mimo/celek; % Kolik zelene je mimo kola
    kontrola(i,1)=1; % Prvni pokus      
    
    if pomer > .1 % Pokud je mimo kolecka vice nez 10%        
        % Druhy pokus
        disp('Druhy pokus!')
        kontrola(i,1)=2; % Druhy pokus
        obr = obr1(:,pars.ramecek(1):pars.ramecek(2),:); % Vyrez
        obr = obr(rohy(2,1):rohy(2,2),rohy(2,3):rohy(2,4),:); % Prvni navrh
        hsv = rgb2hsv(obr);
        H = hsv(:,:,1); S = hsv(:,:,2); V = hsv(:,:,3); 
        zelena = (H<.4) & (S>.1) & (V<.75);
        zelena = bwmorph(zelena,'close');
        zelena = bwmorph(zelena,'clean');

        kol = imresize(kolecka,size(zelena),'nearest');

        % Hledani chyb
        prunik = zelena & kol; % Zelena v kolech
        celek = sum(zelena(:)); % celkem zelene
        mimo = celek - sum(prunik(:));
        pomer = mimo/celek; % Kolik zelene je mimo kola

        if pomer>.1
            disp('Ani jeden navrh nefunguje!')
            kontrola(i,2)=1; % Chyba
    
        end
    end
    
    
    perim = bwperim(kol);
    ven1 = obr(:,:,1); ven2 = obr(:,:,2); ven3 = obr(:,:,3);
    ven1(perim) = 255; ven2(perim)=0; ven3(perim)=0; % Obrys kolecka

    plosky = zeros(1,24); % Alokace na plochy
    
    for j=1:1:24
        
        jamka = kol==j; 
        vals = zelena(kol==j); % Maska jedne rostliny
        plosky(j) = sum(vals);

    end
    
    plochy(i,:) = plosky;
    perim = bwperim(zelena);
    ven1(perim)=0; ven2(perim)=0; ven3(perim)=255; % Modry obrys
    ven = uint8(zeros(size(ven1,1),size(ven1,2),3));
    ven(:,:,1) = ven1; ven(:,:,2) = ven2; ven(:,:,3) = ven3; 
    
    jm1 = ['results\' jm];
    imwrite(ven,jm1,'png'); % Zapis na disk
       
end

%% Reseni chyb

mkdir('chyby') 

disp('*********************************************')
disp('Moving incorrectly analyzed results to folder "chyby"')

kde = find((kontrola(:,2))==1);

for i=1:1:length(kde)
    idx = kde(i); % Index vadneho souboru
    source = ['results\' char(names(idx))];
    dest = ['chyby\' char(names(idx))];
    movefile(source,dest);
end

%% Zapis xlsx

polohy(kde,:)=[];
plochy(kde,:)=[];
names(:,kde)=[];
fileid(kde,:)=[];
    
name = 'results.xlsx';
vysledky_thaliana(name,polohy,plochy,names,fileid)

disp(['Results written to "' char(name) '" file.'])
disp('*********************************************')
    
%% Vytvoreni adresare rucne a prehazeni zdrojovych obrazku chyb   

disp('********************************************')
disp('Creating "rucne" folder and copying incorrectly analyzed images there')

mkdir('rucne')
S = dir('chyby\*.png'); %Nacte jmena slozek
names = {S.name}; % Vse v jedne slozce

for i=1:1:length(names) % Pres vsechny soubory

    source = ['images\' char(names(i))]; % Tohle kopirovat
    dest = ['rucne\' char(names(i))];
    copyfile(source,dest);
    
end