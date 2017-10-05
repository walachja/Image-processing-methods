% Funkce na hledani obrazu podle pohledu: 'zprava','zepredu','shora'.
% Podle zacatku jmena fotografie

function argout = pohled_hrasek(argin1,argin2)

pohled = argin1;
names = argin2;

zac = num2str(pohled);
ktere = false(length(names),1);
for i=1:1:length(names)
    jm = char(names(i));
    pis = jm(1);
    ktere(i) = pis==zac;
end
ktere = find(ktere); % Cisla obrazku na otevreni

argout = ktere;

