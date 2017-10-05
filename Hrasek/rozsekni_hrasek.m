% Rucni rozdeleni spojenych rostlin

function [argout1 argout2] = rozsekni_hrasek(argin1,argin2)

maska = argin1; % Maska spojenych rostlin
obr = argin2; % Puvodni RGB

kde = find(maska);
[mm nn] = size(maska);
[rad,sloup] = ind2sub([mm nn],kde);
odr = max(1,min(rad)-50);
dor = min(mm,max(rad)+50);
ods = max(1,min(sloup)-50);
dos = min(nn,max(sloup)+50);

kus_obr = obr(odr:dor,ods:dos,:);
kus_maska = maska(odr:dor,ods:dos);
delej = true;
while delej
    h = figure;
    imshow(kus_obr)
    title('Separate the two plants by polyline, doubleclick to finish')
    [xx yy] = getline(h);
    % xx jsou sloupce a yy radky matice
    if length(xx)<2 % Malo bodu
        disp('You have to select at least two points!')
    else
        delej = false;
    end
    
end % while
    
    
% Cerna cara
cara = false(size(kus_maska)); % Alokace
for k = 2:1:length(xx) % Pres vsechny body
    d = (xx(k)-xx(k-1))^2 + (yy(k)-yy(k-1))^2;
    d = sqrt(d); % Vzdalenost
    L = linspace(0,1,2*floor(d)); % Bezpecny pocet bodu cestou
    bx = L*xx(k-1) + (1-L)*xx(k);
    bx = round(bx');
    by = L*yy(k-1) + (1-L)*yy(k);
    by = round(by');
    kde = sub2ind(size(kus_maska),by,bx); % Aplikace na indexy
    cara(kde) = true;
end
cara = bwmorph(cara,'diag');
kus_maska(cara) = false;
maska(odr:dor,ods:dos) = kus_maska;

[L num] = bwlabel(maska);
if num<=1
    error('Segmentation failed, only one object present!')
end
stats = regionprops(L,'Area','PixelIdxList');
plochy = [stats.Area];
pom = [plochy' (1:1:num)'];
pom = sortrows(pom,-1); % Prvni dve
id1 = pom(1,2); % Index nejvetsiho kusu
id2 = pom(2,2); % Index nejvetsiho kusu
t1 = mean(stats(id1).PixelIdxList);
t2 = mean(stats(id2).PixelIdxList);
kytka1 = false(size(maska));
kytka2 = false(size(maska));

if t1<t2 % Prvni rostlina je vlevo = vpredu
    kytka1(stats(id1).PixelIdxList) = true;
    kytka2(stats(id2).PixelIdxList) = true;
else
    kytka2(stats(id1).PixelIdxList) = true;
    kytka1(stats(id2).PixelIdxList) = true;
end

close(h);
    
argout1 = kytka1;
argout2 = kytka2;


    
    
    