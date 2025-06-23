function [labels] = make_growcut_mask(mask, d)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% mask - original mask
% d  - size of the increase or decrease length
% labels - output mask for the growcut algorithm (1's ; 0's ; -1's)

labels = round(zeros(size(mask)));
SE = strel("disk", d);

% Reducir el tamaño
bw1 = imerode(mask, SE);
border1 = bwmorph(bw1, 'remove');

% Aumentar el tamaño
bw2 = imdilate(mask, SE);
border2 = bwmorph(bw2, 'remove');

% Asignar 1's para la frontera pequeña
[x, y] = find(border1 == 1);  
for i = 1:length(x)
    labels(round(x(i)), round(y(i))) = 1;  % Usar (x, y)
end

% Asignar -1's para la frontera grande
[x1, y1] = find(border2 == 1); 
for i = 1:length(x1)
    labels(round(x1(i)), round(y1(i))) = -1;  % Usar (x1, y1)
end

end
