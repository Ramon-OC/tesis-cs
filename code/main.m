images_path = '../images/image_02.jpg';
original_image = imread(images_path);

no_iterations = 800;
gc_iterations = 100;
mask_distance = 30;

% 0 for active contours, 1 for grow cut
segmentation_model = 0; 

%% IMAGE PREPROCESSING
% 01: hair removal and reference marks
[~, ~, hair_free_grayscale_smooth] = remove_hair(original_image);
% 02: binarization with the Otsu method (before, remove dermatoscope values)
image_no_dermatoscope_values = remove_dermatoscope_values(hair_free_grayscale_smooth);
binary_image = otsu_binarization(image_no_dermatoscope_values);
% 03: generating the complement of a binary image
binary_image_complement = imcomplement(binary_image);
% 04: removal of noFOV objects
dermatoscope_free_image = imclearborder(binary_image_complement);
% 05: filling of holes in lesions
image_filling = imfill(dermatoscope_free_image, 'holes');
% 06: extraction of the largest element
largest_area = extract_largest_element(image_filling);

%% IMAGE SEGMENTATION
if segmentation_model == 0
    segmentation = active_contours(hair_free_grayscale_smooth, largest_area, no_iterations);
else 
    [segmentation, ~] = grow_cut(hair_free_grayscale_smooth, largest_area, mask_distance, gc_iterations);
end

imshow(segmentation);