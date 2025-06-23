%   EXTRACT_LARGEST_ELEMENT
% 
%   Processes a binary image to identify and extract the largest 
%   connected component
%
%   Input:
%       binary_image: grayscale image
%
%   Output:
%       resized_image: grayscale image with the largest region.
function biggest_region = extract_largest_element(binary_image)
    
    [a, bc] = bwlabel(binary_image);
    b = [];
    temp = 0;
    gk = 1;
    [f, g] = size(a);
    
    for i=1:bc
        for wk=1:f
            for tk=1:g
                if(a(wk,tk)==gk)
                    temp=temp+1;
                end
            end
        end
        b =[b temp];
        temp=0;
        gk=gk+1;
    end
    
    [m, n] = max(b);
    
    output = [f,g];
    for i=1:f
        for j=1:g
            if(a(i,j)==n)
                output(i,j)=0;
            elseif(a(i,j)>=1)
                output(i,j)=1;
            else
                output(i,j)=0;
            end
        end
    end
    
    biggest_region = [f,g];

    for i=1:f
        for j=1:g
            if(a(i,j)==n)
                biggest_region(i,j)=255;
            else
                biggest_region(i,j)=0;
            end
        end
    end

    biggest_region = uint8(biggest_region);
   
end

