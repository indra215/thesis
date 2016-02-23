function Xs = getSourcePatches(w,mlt,no_source_patches,entropy_thresh)

    % read images
    jpg_files = dir('../data/*.jpg');
    jpg_len = size(jpg_files);

    bmp_files = dir('../data/*.bmp');
    bmp_len = size(bmp_files);

    Xs = [];

    for i=1:jpg_len

        img = jpg_files(i,1).name;
        I = imread(img);
        if(size(I,3) ~= 1)
            I = rgb2gray(I);
        end

        % extract random patches
        P = extract_patches_random(I,w,mlt,entropy_thresh);
        noP = size(P,2);
        if(noP < no_source_patches)
            no_patches = ceil(noP);
            p = randsample(noP,no_patches);
        else
            p = randsample(noP,no_source_patches);
        end
        P = im2double(P);
        Xs = [Xs P(:,p)];
    end

    for i=1:bmp_len

        img = bmp_files(i,1).name
        I = imread(img);
        if(size(I,3) ~= 1)
            I = rgb2gray(I);
        end

        % extract random patches
        P = extract_patches_random(I,w,mlt,entropy_thresh);
        noP = size(P,2);
        if(noP < no_source_patches)
            no_patches = ceil(noP);
            p = randsample(noP,no_patches);
        else
            p = randsample(noP,no_source_patches);
        end
        P = im2double(P);
        Xs = [Xs P(:,p)];
    end
end