%% Canny detekce hran postupne 
% treba promazat nepouzivane promenne

function argout = cannymoje_hrasek(argin)

I = argin;

[a b c] = size(I);
if c == 3
    I = rgb2gray(I);
end

%% Krok 1: Vyhlazeni
I = medfilt2(I,[5,5]); % V tomto pripade pouzivam medianovy filtr

%% Krok 2: Hledani gradientu
[Gx, Gy] = imgradientxy(I);
[Gmag, Gdir] = imgradient(Gx, Gy);

G=sqrt(Gx.^2+Gy.^2); % Celkove gradienty
%G=abs(Gx)+abs(Gy);

%% Lokalni maxima gradientu
% Pouze ve dvou smerech, ne ve ctyrech
p=uint8(Gmag);
[a b]=size(p);
maxima=zeros(a,b);
for i=2:a-1
     for j=2:b-1
         if abs(Gdir(i,j))>=45 && abs(Gdir(i,j))<=135
             if p(i,j)>=p(i-1,j) && p(i,j)>=p(i+1,j);
                 maxima(i,j)= p(i,j);
             end
         else 
             if p(i,j)>=p(i,j-1) && p(i,j)>=p(i,j-1)%max(p(i,j),p(i,j-1),p(i,j+1))==p(i,j)
                 maxima(i,j)= p(i,j);
             end
         end                
     end
end

%% Krok 4: Dvoji prahovani
GG_min=zeros(a,b); % Prelokace
GG_max=zeros(a,b); % Prelokace

% Prahy
horni=190;
dolni=80;

GG=maxima;
 for i=1:a
     for j=1:b
         if GG(i,j)>=horni
             GG_max(i,j)=GG(i,j);
             GG_min(i,j)=horni-1;
          elseif GG(i,j)<=horni && GG(i,j)>=dolni
              GG_min(i,j)=GG(i,j);
         else GG(i,j)=0;
         end         
     end
 end 
% Uprava
GG_max=bwmorph(GG_max,'skel',Inf);
GG_max=(GG_max)*255;


%% Krok 5: Sledovani hran
% R....silne hrany - bitmapa 0/1
% G....slabe hrany - bitmapa 0/1

G=GG_max;
R= im2bw(GG, 0.1);

% Objekty 
new=G;
[LR num]=bwlabel(R);
stateR=regionprops(LR,'PixelIdxList');
 for i=1:1:num % Pres vsechny objekty
     list=stateR(i).PixelIdxList; % Seznam pixelu i-teho R objektu
     vals = G(list); % Co je v tom slabeho
    if sum(vals)==0
    else new(list)=true;
     end
 end
 
% Puvodni hodnoty, nechci jenom 0,1 - kvuli zestihleni
 nove=zeros(a,b);
 for i=1:a
     for j=1:b
         if new(i,j)==1
             nove(i,j)=GG(i,j);
             if GG_max(i,j)>0
                 nove(i,j)=255;
             end
         end
     end
 end
 
% Zestihleni;
new = nove;
celkem = bwmorph(new, 'skel',Inf);

argout = celkem;


 


 