% Upraveny findpeaks
% Hleda i vrcholy pokud jsou dve stejne hodnoty vedle sebe

function [pks locs] = myfindpeaks(argin)

% argin je vektor 
% pks.... hodnoty 
% locs... jsou posice


x = argin;
siz = size(x);
if length(siz)~=2
    error('MyFindPeaks expects a vector')
elseif siz(1)~=1 && siz(2)~=1
    error('MyFindPeaks expects a vector')
end

kde = false(size(x)); % Alokace na je/neni peak
n = length(x); % delka vektoru
for i=2:1:(n-1)
    podm = x(i-1)<=x(i) && x(i+1)<=x(i);
    if podm
        kde(i)=true;
    end
end

pks = x(kde);
locs = find(kde);
