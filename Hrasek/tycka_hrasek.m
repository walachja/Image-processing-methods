% Odstraneni podpurne tycky
% V pripade, ze je rostlina podpirana cernou tyckou, ktera rostlinu
% rozdeluje na dve casti, tato funkce tyto dve casti propoji

function argout = tycka_hrasek(argin)

maska = argin; % Maska po aplikace odlesky_hrasek.m

% Objekty v obraze
[L num] = bwlabel(maska);
stats = regionprops(L,'Area','PixelIdxList');
plochy = [stats.Area];
plochy = plochy'; 

% Rozhodnuti, zda jsou v obraze vice nez dva velke kusy
limit = max(plochy)/20;
kde = find(plochy>limit);

seznam = struct();
newmaska = maska;

if length(kde)>2 % Pokud je velkych kusu vice nez dva
    % Hledame dalsi velky kus do 20 pixelu daleko
    for k=1:1:length(kde)
        pomaska = false(size(maska));
        pomaska(stats(kde(k)).PixelIdxList) = true;
        dmaska = bwdist(pomaska);
        seznam(k).idx = kde(k);
        seznam(k).list = dmaska;
    end
    
    
 % Pres vsechny dvojice hledame pruseciky
    for ik = 1:1:length(kde)
        for jk = (ik+1):1:length(kde)
            prvni = seznam(ik).list;
            druhy = seznam(jk).list;
            oba = prvni + druhy;
            spolecne = oba<20;
            newmaska = newmaska | spolecne;
        end
    end
    
end

argout = newmaska;
    