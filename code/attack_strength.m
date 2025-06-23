function g = attack_strength(Cp, Cq)
    % Calculate attack strength using Euclidean distance
    % Returns a value in [0,1] where 1 means identical pixels
    dist = norm(Cp(:) - Cq(:));
    g = 1 - (dist / sqrt(length(Cp)));
    g = max(0, min(1, g));  % Ensure output is in [0,1]
end