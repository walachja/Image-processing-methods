% Odstraneni odlesku u kvetinacu

function argout = odlesky_hrasek(argin1,argin2)

maska = argin1; 
pos = argin2; % Pozice kvetinacu
% [odr dor ods dos] s pozicema obou kvetinacu

sirka = 6; % Odlesky jsou obvykle takto siroke, proto je mazeme

odlesk = maska(pos(1,1):pos(1,2),pos(1,3):pos(1,4)); % Jenom odlesk u kvetinace
% tady je treba smazat horizontalni linky
odlesk1 = [ones(sirka,size(odlesk,2)); odlesk];
odlesk1((end-sirka+1):end,:)=[]; % Posun dolu
odlesk = (odlesk & odlesk1); % Smaze vodorovne linky o sirce 1 pixel
maska(pos(1,1):pos(1,2),pos(1,3):pos(1,4)) = odlesk;

odlesk = maska(pos(2,1):pos(2,2),pos(2,3):pos(2,4)); % Jenom odlesk u kvetinace
% Je potreba smazat horizontalni linky
odlesk1 = [ones(sirka,size(odlesk,2)); odlesk];
odlesk1((end-sirka+1):end,:)=[];
odlesk = (odlesk & odlesk1); % Smaze vodorovne linky o sirce 1 pixel
maska(pos(2,1):pos(2,2),pos(2,3):pos(2,4)) = odlesk;

argout = maska;

