README: Hrasek.m

Program na vyhodnoceni zelene plochy u fotografii hrasku z centra regionu Hana pro biotechnologicky a zemedelsky vyzkum.

Hlavni soubor: 
Hrasek.m

Funkce, na ktere se Hrasek.m odvolava (vzdy maji koncovku "_hrasek"):
1)  pohled_hrasek.m
2)  maska_hrasek.m
3)  maska_shora_hrasek.m
4)  obrys_hrasek.m
5)  odlesky_hrasek.m
6)  pohled_hrasek.m
7)  rostliny_hrasek.m
8)  rozsekni_hrasek.m
9)  tycka_hrasek.m
10) bodovyfuzzy_hrasek.m
11) fuzzykombinace_hrasek.m
12) gradientnifuzzy_hrasek.m
13) canny_hrasek.m


Vstup:
Vstupem musi byt obrazky typu RGB. Musi byt ulozeny ve slozce "images".


Analyza zelene plochy:
Je provadena ctyrmi zpusoby podle zadani uzivatele.
Volba zpusobu probiha na v souboru Hrasek.m, radek 10, nastavenim parametru pars.kresli. 

Nastaveni metod: 
1) pars.metoda = 0 ...... Cannyho metoda, MatLab 		 
2) pars.metoda = 1 ...... Cannyho metoda vlastni tvorba		 
3) pars.metoda = 2 ...... Gradientni fuzzy metoda		 
4) pars.metoda = 3 ...... Bodova fuzzy metoda (pozor tato metoda trvá v øádu hodin!)


Vystup:
Vystupem jsou obrazky + soubor results.xls


Volba ukladani vysledku:
Volba zpusobu probiha na v souboru Hrasek.m, radek 7, nastavenim parametru pars.kresli. 

Nastaveni moznosti:
1) pars.kresli = 0 ...... Vysledky se neukladaji
2) pars.kresli = 1 ...... Ulozeni na disk
3) pars.kresli = 2 ...... Zobrazeni na obrazovku


Pokud jsou rostliny propletene, program vyvze uzivatele aby pomocí lomené èáry rostliny rozdìlil ruènì. Dvojité kliknutí znaèí konec.


