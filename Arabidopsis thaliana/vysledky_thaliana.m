% Zapsani vysledku

function vysledky_thaliana(argin1,argin2,argin3,argin4,argin5)

name = argin1;
polohy = argin2;
plochy = argin3;
names = argin4;
fileid = argin5; % [datum  xxy]
names = names'; % sloupec

jm = char(name); % sem to napise
head = [cellstr('nazev_souboru') cellstr('datum_akvizice') cellstr('[sour_x]x[sour_y]') cellstr('souradnice_x')	cellstr('souradnice_y')...	
    cellstr('R1_S1')	cellstr('R2_S1')	cellstr('R3_S1')	cellstr('R4_S1')	cellstr('R5_S1')	cellstr('R6_S1')...	
    cellstr('R1_S2')	cellstr('R2_S2')	cellstr('R3_S2')	cellstr('R4_S2')	cellstr('R5_S2')	cellstr('R6_S2')...	
    cellstr('R1_S3')	cellstr('R2_S3')	cellstr('R3_S3')	cellstr('R4_S3')	cellstr('R5_S3')	cellstr('R6_S3')...	
    cellstr('R1_S4')	cellstr('R2_S4')	cellstr('R3_S4')	cellstr('R4_S4')	cellstr('R5_S4')	cellstr('R6_S4')];

xlswrite(jm, head);
xlswrite(jm, names, 1 , 'A2');
xlswrite(jm, fileid(:,1), 1 , 'B2');
xlswrite(jm, fileid(:,2), 1 , 'C2');
xlswrite(jm, polohy, 1, 'D2');
xlswrite(jm, plochy, 1, 'F2');









