%   REMOVE_HAIR 
% 
%   The algorithm decomposes the color image into its three channels. For 
%   each one uses a bottom hat filter, it obtains the darkest elements 
%   and all pixels below a predefined threshold (max_gray_value) are 
%   dilated to thicken the artifacts to be removed; the regionfill function 
%   fills the objects areas and finally concatenates the three channels into 
%   a single image to apply a median filter in order to soften the effects
%   of removal
%
%   Input:
%       original_color_image - RGB image (height x width x 3)
%
%   Inner variables:
%       disk_radius: disc radius for bottom hat filter
%       line_size: line dimension for the remove mask
%       line_rotation: line rotation for the remove mask
%       max_gray_value: maximum value for the hair removal threshold 
%       channel: specifies a channel of the RGB model
%
%   Output:
%       free_hair_color: color image without the presence of hair 
%       free_hair_color_smooth: color image without the presence of hair
%       with a median filter
%       hair_free_grayscale_smooth: grayscale image associated to the red 
%       channel without the presence of hair with a median filter
%
% PD: It is possible to modify the size of the structural element, its 
% rotation and the radius of the disk. Also, you can choose the channel for 
% the grayscale image (1 red, 2 green, 3 blue) in the inner variable channel. 
function [free_hair_color, free_hair_color_smooth, hair_free_grayscale_smooth] = remove_hair(original_color_image)
    disk_radius = 5;
    line_size = 10;
    line_rotation = 45;
    max_gray_value = 25;
    channel = 1;

    m = size(original_color_image, 1); 
    n = size(original_color_image, 2); 
    free_hair_color = zeros(m, n);
    hair_free_grayscale_smooth = zeros(m, n);

    for c = 1:3
        c_channel = original_color_image(:, :, c);

        se = strel('disk', disk_radius);
        hairs_mask = imbothat(c_channel, se);

        BW = hairs_mask > max_gray_value;
        BW1 = imdilate(BW, strel('line', line_size, line_rotation));
        BW2 = double(BW1);
        hair_free_channel = regionfill(c_channel, BW2);

        if(c == channel)
            hair_free_grayscale_smooth = medfilt2(hair_free_channel,[3 3]);
        end

        free_hair_color(:, :, c) = hair_free_channel;
    end
    free_hair_color_smooth = medfilt3(free_hair_color,[3,3,3]); 
end