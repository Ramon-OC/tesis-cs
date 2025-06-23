%   GROW_CUT
% 
%   Given an image and a binary mask, perform a segmentation using the 
%   grow cut algorithm.
%
%   Inputs:
%       grayscale_image - image with the skin lesion
%       mask            - binary mask as a starting point
%       max_iterations  - maximum number of iterations the algorithm will 
%                         execute
%
%   Output:
%       segmented_image: binary image with the lesion in foreground
%       strengths: 
%
%   PD: for more information on the original grow cut implementation:
%       Interactive Multi-Label N-D Image Segmentation By Cellular Autonoma
%       by Vladimir Vezhnevets and Vadim Konouchine
%       coded by: Shawn Lankton (www.shawnlankton.com)
% 
function [segmented_image, strengths] = grow_cut(grayscale_image, mask, mask_distance, max_iterations)
    % Get the border of the original mask
    border1 = bwmorph(mask, 'remove');
    [x, y] = find(border1 == 1);

    % create grow cut labeling
    [labels] = make_growcut_mask(mask, mask_distance);

    [segmented_image, strengths] = grow_cut_algorithm(grayscale_image, labels, max_iterations);
    segmented_image = imfill(segmented_image,'holes');

end
