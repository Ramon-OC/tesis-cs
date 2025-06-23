%   ACTIVE_CONTOURS
% 
%   Given an image and a binary mask, perform a segmentation using the 
%   regional growth technique of active contours (snakes)
%
%   Inputs:
%       grayscale_image
%       mask - binary mask as a starting point
%       active_contours_iterations - maximum number of iterations the 
%       algorithm will execute
%
%   Inner variables:
%       smooth_fact: It is possible to modify the smoothing factor of the 
%       method, higher values ​​soften the boundaries of the regions, but 
%       also blur smaller details
%
%   Output:
%       segmented_image: binary image with the lesion in foreground
%
% PD: for more information on active contours, visit: 
%     https://la.mathworks.com/help/images/ref/activecontour.html
function segmented_image = active_contours(image, mask, active_contours_iterations)
    smooth_fact=5;
    segmented_image = activecontour(image,mask,active_contours_iterations,'Chan-Vese','ContractionBias',-0.3,'SmoothFactor',smooth_fact);
end
