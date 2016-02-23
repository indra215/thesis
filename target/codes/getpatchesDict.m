function [P, locations, sx, sy, ent] = getpatchesDict(I,w,entropy_thresh)
% This function extracts small patches from an image using a sliding window
% Input:    I = image
%           w = patch size

% Output:   P = image patches (as vectors)
%           locations = patch locations (as points)
% Use:      P = sliding_window_patches(I,32,3);
% mean not removed.
    
%     tic
    n1 = size(I,1);
    n2 = size(I,2);
    stride = 4;
%     entropy_thresh = 3;
%     stride  = 1;
    
    % patch locations
    x = w/2:stride:n1-(w/2);
    y = w/2:stride:n2-(w/2);
    [dY,dX] = meshgrid(y,x);
    [r, c] = size(dX);
    
    % extract the patches
    P = [];
    locations = [];
    ent = [];
    
    I = im2double(I);
    
    for i=1:r(1)
        for j=1:c
            px = dX(i,j);
            py = dY(i,j);
            p = I(px-(w/2)+1:px+(w/2),py-(w/2)+1:py+(w/2));
           
            if(entropy_patch(p) > entropy_thresh)
                P = [P reshape(p,w^2,1)];
                locations = [locations;px py];
                ent = [ent;entropy_patch(p)];
            end
        end
    end
    
%     toc
	sx = size(x,2);
	sy = size(y,2);
end



