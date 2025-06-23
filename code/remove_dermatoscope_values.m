%   REMOVE_DERMATOSCOPE_VALUES 
% 
%   Replaces all lower values ​​within an image with NaN 
%   values. This to simulate the dermatoscope values area
%
%   Input:
%       gray_image: gray scale image
%
%   Inner variables:
%       max_gray_value: maximum treshold value for the hair removal
%
%   Output:
%       free_dermatoscope_values: black and white image with values ​​of 
%                                 type double. The dermatoscope values ​​are 
%                                 replaced by NaN type
%
% PD: It is possible to modify the max_gray_value value in order to remove 
% clearer or darker pixels
function image_no_dermatoscope_values = remove_dermatoscope_values(gray_image)
    max_gray_value = 0.12;
    gray_image = im2double(gray_image);
    gray_image(gray_image >= 0.0 & gray_image <= max_gray_value) = NaN;
    image_no_dermatoscope_values = gray_image;
end