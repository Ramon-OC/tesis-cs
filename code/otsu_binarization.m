%   OTSU_BINARIZATION 
% 
%   NaN values ​​are removed from the grayscale image 'gray_image' and stored in 
%   'values_no_nans'. Then, an optimal threshold for image binarization is 
%   calculated using Otsu's method through the graythresh function applied 
%   to 'values_no_nans', resulting in the value level. Finally, this 
%   threshold is used to binarize the original 'gray_image' using imbinarize 
%   function
%
%   Input:
%       grayscale_image
%
%   Output:
%       binary_image - black and white image. It is logical type.
function binary_image = otsu_binarization(grayscale_image)
    values_no_nans = grayscale_image(~isnan(grayscale_image));
    level = graythresh(values_no_nans);
    binary_image = imbinarize(grayscale_image, level);
end