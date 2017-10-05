%% Gradientni fuzzy metoda
function argout = gradientnifuzzy_hrasek(argin)

Igray = argin;
% Prevod do stupnu sedi
[a b c] = size(Igray);
if c == 3
    Igray = rgb2gray(Igray);
end
% Medianivy filtr
Igray = medfilt2(Igray,[5,5]);

% Normovani
I = double(Igray);
classType = class(Igray);
scalingFactor = double(intmax(classType));
I = I/scalingFactor;

Gx = [-1 1];
Gy = Gx';
Ix = conv2(I,Gx,'same');
Iy = conv2(I,Gy,'same');

%% Nova fuzzy mnozina
fuzzymnozina = newfis('edgeDetection');

% Vstupy
fuzzymnozina = addvar(fuzzymnozina,'input','Ix',[-1 1]);
fuzzymnozina = addvar(fuzzymnozina,'input','Iy',[-1 1]);

sx = 0.1; sy = 0.1;
fuzzymnozina = addmf(fuzzymnozina,'input',1,'zero','gaussmf',[sx 0]);
fuzzymnozina = addmf(fuzzymnozina,'input',2,'zero','gaussmf',[sy 0]);

% Vystupy
fuzzymnozina = addvar(fuzzymnozina,'output','Iout',[0 1]);
fuzzymnozina = addmf(fuzzymnozina,'output',1,'cerna','trimf', [0 0.05 0.1]);
fuzzymnozina = addmf(fuzzymnozina,'output',1,'bila','trimf',[0.9 0.95 1]);

% Pravidla
p1 = 'If Ix is zero and Iy is zero then Iout is cerna';
p2 = 'If Ix is not zero or Iy is not zero then Iout is bila';
p = char(p1,p2);
fuzzymnozina = parsrule(fuzzymnozina,p);

% Hodnoceni
hodnoceni = zeros(size(I));
for ii = 1:size(I,1)
    hodnoceni(ii,:) = evalfis([(Ix(ii,:));(Iy(ii,:));]',fuzzymnozina);
end

argout=hodnoceni;
