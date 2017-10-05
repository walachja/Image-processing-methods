%% Bodova fuzzy metoda

function argout = bodovyfuzzy_hrasek(argin)

I = argin;

[a b c] = size(I);
if c == 3
    I = rgb2gray(I);
end

% Vstupy - sousede hodnoceneho pixelu
M1 = double(reshape(I(1:end-2,1:end-2),[],1));
M2 = double(reshape(I(1:end-2,2:end-1),[],1));
M3 = double(reshape(I(1:end-2,3:end),[],1));
M4 = double(reshape(I(2:end-1,1:end-2),[],1));
M5 = double(reshape(I(2:end-1,2:end-1),[],1));
M6 = double(reshape(I(2:end-1,3:end),[],1));
M7 = double(reshape(I(3:end,1:end-2),[],1));
M8 = double(reshape(I(3:end,2:end-1),[],1));
M9 = double(reshape(I(3:end,3:end),[],1));

edgeFIS = newfis('edgeDetection');

edgeFIS = addvar(edgeFIS,'input','M1',[0 255]);
edgeFIS = addvar(edgeFIS,'input','M2',[0 255]);
edgeFIS = addvar(edgeFIS,'input','M3',[0 255]);
edgeFIS = addvar(edgeFIS,'input','M4',[0 255]);
edgeFIS = addvar(edgeFIS,'input','M5',[0 255]);
edgeFIS = addvar(edgeFIS,'input','M6',[0 255]);
edgeFIS = addvar(edgeFIS,'input','M7',[0 255]);
edgeFIS = addvar(edgeFIS,'input','M8',[0 255]);
edgeFIS = addvar(edgeFIS,'input','M9',[0 255]);


edgeFIS = addmf(edgeFIS,'input',1,'B','trapmf',[-230 -25.5 80 100.2]);
edgeFIS = addmf(edgeFIS,'input',1,'W','trapmf',[80 169.7 281 485]);
edgeFIS = addmf(edgeFIS,'input',2,'B','trapmf',[-230 -25.5 80 100.2]);
edgeFIS = addmf(edgeFIS,'input',2,'W','trapmf',[80 169.7 281 485]);
edgeFIS = addmf(edgeFIS,'input',3,'B','trapmf',[-230 -25.5 80 100.2]);
edgeFIS = addmf(edgeFIS,'input',3,'W','trapmf',[80 169.7 281 485]);
edgeFIS = addmf(edgeFIS,'input',4,'B','trapmf',[-230 -25.5 80 100.2]);
edgeFIS = addmf(edgeFIS,'input',4,'W','trapmf',[80 169.7 281 485]);
edgeFIS = addmf(edgeFIS,'input',5,'B','trapmf',[-230 -25.5 80 100.2]);
edgeFIS = addmf(edgeFIS,'input',5,'W','trapmf',[80 169.7 281 485]);
edgeFIS = addmf(edgeFIS,'input',6,'B','trapmf',[-230 -25.5 80 100.2]);
edgeFIS = addmf(edgeFIS,'input',6,'W','trapmf',[80 169.7 281 485]);
edgeFIS = addmf(edgeFIS,'input',7,'B','trapmf',[-230 -25.5 80 100.2]);
edgeFIS = addmf(edgeFIS,'input',7,'W','trapmf',[80 169.7 281 485]);
edgeFIS = addmf(edgeFIS,'input',8,'B','trapmf',[-230 -25.5 80 100.2]);
edgeFIS = addmf(edgeFIS,'input',8,'W','trapmf',[80 169.7 281 485]);
edgeFIS = addmf(edgeFIS,'input',9,'B','trapmf',[-230 -25.5 80 100.2]);
edgeFIS = addmf(edgeFIS,'input',9,'W','trapmf',[80 169.7 281 485]);

% Vystupy
edgeFIS = addvar(edgeFIS,'output','Iout',[0 255]);
edgeFIS = addmf(edgeFIS,'output',1,'edge','trimf',[245 250 255]);
edgeFIS = addmf(edgeFIS,'output',1,'NON-edge','trimf',[10 15 20]);

% Pravidla
r1 = 'If M1 is B and M2 is B and M3 is B and M4 is W and M5 is W and M6 is W and M7 is W and M8 is W and M9 is W then Iout is edge';
r2 = 'If M1 is B and M2 is W and M3 is W and M4 is B and M5 is W and M6 is W and M7 is W and M8 is W and M9 is W then Iout is edge';
r3 = 'If M1 is W and M2 is W and M3 is W and M4 is W and M5 is W and M6 is W and M7 is B and M8 is B and M9 is B then Iout is edge';
r4 = 'If M1 is B and M2 is B and M3 is B and M4 is W and M5 is W and M6 is W and M7 is W and M8 is W and M9 is W then Iout is edge';
r5 = 'If M1 is B and M2 is B and M3 is W and M4 is B and M5 is W and M6 is W and M7 is W and M8 is W and M9 is W then Iout is edge';
r6=  'If M1 is W and M2 is B and M3 is B and M4 is W and M5 is W and M6 is B and M7 is W and M8 is W and M9 is W then Iout is edge';
r7 = 'If M1 is W and M2 is W and M3 is W and M4 is B and M5 is W and M6 is W and M7 is B and M8 is B and M9 is W then Iout is edge';
r8 = 'If M1 is W and M2 is W and M3 is W and M4 is W and M5 is W and M6 is B and M7 is W and M8 is B and M9 is B then Iout is edge';
r9 = 'If M1 is B and M2 is B and M3 is B and M4 is B and M5 is W and M6 is W and M7 is W and M8 is W and M9 is W then Iout is edge';
r10 = 'If M1 is B and M2 is B and M3 is B and M4 is W and M5 is W and M6 is B and M7 is W and M8 is W and M9 is W then Iout is edge';
r11 = 'If M1 is B and M2 is B and M3 is W and M4 is B and M5 is W and M6 is W and M7 is B and M8 is W and M9 is W then Iout is edge';
r12 = 'If M1 is B and M2 is W and M3 is W and M4 is B and M5 is W and M6 is W and M7 is B and M8 is B and M9 is W then Iout is edge';
r13 = 'If M1 is W and M2 is W and M3 is W and M4 is B and M5 is W and M6 is W and M7 is B and M8 is B and M9 is B then Iout is edge';
r14 = 'If M1 is W and M2 is W and M3 is W and M4 is W and M5 is W and M6 is B and M7 is B and M8 is B and M9 is B then Iout is edge';
r15 = 'If M1 is W and M2 is B and M3 is B and M4 is W and M5 is W and M6 is B and M7 is W and M8 is W and M9 is B then Iout is edge';
r16 = 'If M1 is W and M2 is W and M3 is B and M4 is W and M5 is W and M6 is B and M7 is W and M8 is B and M9 is B then Iout is edge';
r17 = 'If M1 is B and M2 is B and M3 is B and M4 is W and M5 is W and M6 is B and M7 is W and M8 is W and M9 is B then Iout is edge';
r18 = 'If M1 is W and M2 is W and M3 is B and M4 is W and M5 is W and M6 is B and M7 is B and M8 is B and M9 is B then Iout is edge';
r19 = 'If M1 is B and M2 is W and M3 is W and M4 is B and M5 is W and M6 is W and M7 is B and M8 is B and M9 is B then Iout is edge';
r20 = 'If M1 is B and M2 is B and M3 is B and M4 is B and M5 is W and M6 is W and M7 is B and M8 is W and M9 is W then Iout is edge';
r21 = 'If M1 is B and M2 is B and M3 is B and M4 is B and M5 is W and M6 is B and M7 is W and M8 is W and M9 is W then Iout is edge';
r22 = 'If M1 is W and M2 is B and M3 is B and M4 is W and M5 is W and M6 is B and M7 is W and M8 is B and M9 is B then Iout is edge'; 
r23 = 'If M1 is W and M2 is W and M3 is W and M4 is B and M5 is W and M6 is B and M7 is B and M8 is B and M9 is B then Iout is edge';
r24 = 'If M1 is B and M2 is B and M3 is W and M4 is B and M5 is W and M6 is W and M7 is B and M8 is B and M9 is W then Iout is edge';
r25 = 'If M1 is B and M2 is B and M3 is B and M4 is W and M5 is W and M6 is B and M7 is W and M8 is B and M9 is B then Iout is edge';
r26 = 'If M1 is W and M2 is W and M3 is B and M4 is B and M5 is W and M6 is B and M7 is B and M8 is B and M9 is B then Iout is edge';
r27 = 'If M1 is W and M2 is W and M3 is B and M4 is B and M5 is W and M6 is B and M7 is B and M8 is B and M9 is B then Iout is edge';
r28 = 'If M1 is B and M2 is B and M3 is B and M4 is B and M5 is W and M6 is B and M7 is B and M8 is W and M9 is W then Iout is edge';
r29 = 'If M1 is B and M2 is B and M3 is W and M4 is W and M5 is W and M6 is W and M7 is W and M8 is W and M9 is W then Iout is edge';
r30 = 'If M1 is W and M2 is B and M3 is B and M4 is W and M5 is W and M6 is W and M7 is W and M8 is W and M9 is W then Iout is edge';
r31 = 'If M1 is W and M2 is W and M3 is B and M4 is W and M5 is W and M6 is B and M7 is W and M8 is W and M9 is W then Iout is edge';
r32 = 'If M1 is W and M2 is W and M3 is W and M4 is W and M5 is W and M6 is B and M7 is W and M8 is W and M9 is B then Iout is edge';
r33 = 'If M1 is W and M2 is W and M3 is W and M4 is W and M5 is W and M6 is W and M7 is W and M8 is B and M9 is B then Iout is edge';
r34 = 'If M1 is W and M2 is W and M3 is W and M4 is W and M5 is W and M6 is W and M7 is B and M8 is B and M9 is W then Iout is edge';
r35 = 'If M1 is W and M2 is W and M3 is W and M4 is B and M5 is W and M6 is W and M7 is B and M8 is W and M9 is W then Iout is edge';
r36 = 'If M1 is B and M2 is W and M3 is W and M4 is B and M5 is W and M6 is W and M7 is W and M8 is W and M9 is W then Iout is edge';
r37 = 'If M1 is B and M2 is B and M3 is B and M4 is B and M5 is W and M6 is B and M7 is B and M8 is B and M9 is B then Iout is NON-edge';
r38 = 'If M1 is B and M2 is B and M3 is B and M4 is B and M5 is B and M6 is B and M7 is B and M8 is B and M9 is B then Iout is NON-edge';
r39 = 'If M1 is W and M2 is W and M3 is W and M4 is W and M5 is b and M6 is W and M7 is W and M8 is W and M9 is W then Iout is NON-edge';
r40 = 'If M1 is W and M2 is W and M3 is W and M4 is W and M5 is W and M6 is W and M7 is W and M8 is W and M9 is W then Iout is NON-edge';

r = char(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31,r32,r33,r34,r35,r36,r37,r38,r39,r40);
edgeFIS = parsrule(edgeFIS,r);

%Vyhodnoceni
l = length(M1);
Ieval = zeros(1,l); % Prelokace
for ii = 1:l
    Ieval(ii) = evalfis([M1(ii);M2(ii);M3(ii);M4(ii);M5(ii);M6(ii);M7(ii);M8(ii);M9(ii);]',edgeFIS);
end
% Zpatky do matice
vysl=zeros(b,a);
vysl(2:end-1,2:end-1) = vec2mat(Ieval,(a-2));
vysl=uint8(vysl);
argout= vysl';
