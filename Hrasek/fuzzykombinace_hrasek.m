% Kombinace zelene a fuzzy

function argout = fuzzykombinace_hrasek(argin1,argin2)

A = argin1;
B = argin2;

[L,num] = bwlabel(A); % Najde objekty v A
stats = regionprops(L,'PixelIdxList');
for i=1:num
    idx = stats(i).PixelIdxList;
    vals = B(idx); % Cele je tady v B
    if any(vals)
    else
        A(idx) = 0;
    end
end

argout = A;