function [labels, strengths] = grow_cut_algorithm(image, labels, max_iterations)
    % Initialize strengths matrix
    strengths = zeros(size(labels));
    strengths(labels ~= 0) = 1;  % Set strength = 1 for initially labeled pixels
    
    % Convert image to double if not already
    image = double(image);
    
    % Normalize image if not already in [0,1]
    if max(image(:)) > 1
        image = image / 255;
    end
    
    % Get image dimensions
    [rows, cols, channels] = size(image);
    
    % Define neighborhood offsets (8-connectivity)
    neighbors = [-1 -1; -1 0; -1 1; 0 -1; 0 1; 1 -1; 1 0; 1 1];
    
    % Previous labels and strengths for convergence check
    prevLabels = labels;
    prevStrengths = strengths;
    
    % Maximum iterations and convergence threshold
    threshold = 1e-6;
    
    % Main loop
    for iter = 1:max_iterations
        % Create temporary matrices for updates
        newLabels = labels;
        newStrengths = strengths;
        
        % Iterate over all pixels
        for i = 2:rows-1
            for j = 2:cols-1
                % Get current pixel features
                if channels == 1
                    Cp = image(i,j);
                else
                    Cp = squeeze(image(i,j,:));
                end
                
                % Check all neighbors
                for n = 1:size(neighbors,1)
                    ni = i + neighbors(n,1);
                    nj = j + neighbors(n,2);
                    
                    % Get neighbor features
                    if channels == 1
                        Cq = image(ni,nj);
                    else
                        Cq = squeeze(image(ni,nj,:));
                    end
                    
                    % Calculate attack strength
                    g = attack_strength(Cp, Cq);
                    attack = g * strengths(ni,nj);
                    
                    % Update if attack is stronger than current strength
                    if attack > newStrengths(i,j)
                        newStrengths(i,j) = attack;
                        newLabels(i,j) = labels(ni,nj);
                    end
                end
            end
        end
        
        % Check for convergence
        if max(abs(newLabels(:) - prevLabels(:))) < threshold && ...
           max(abs(newStrengths(:) - prevStrengths(:))) < threshold
            break;
        end
        
        % Update matrices
        prevLabels = labels;
        prevStrengths = strengths;
        labels = newLabels;
        strengths = newStrengths;
    end
end
