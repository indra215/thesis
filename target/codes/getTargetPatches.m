function getTargetPatches(w,no_target_patches,entropy_thresh,distortion,data)
    
    if(data == 1)
        if(distortion == 1)
            files = dir('../../LIVE/data/jp2k/*.bmp');
            spath = '../../LIVE/result/jp2k/patches/';
        elseif(distortion == 2)
            files = dir('../../LIVE/data/jpeg/*.bmp');
            spath = '../../LIVE/result/jpeg/patches/';
        elseif(distortion == 3)
            files = dir('../../LIVE/data/wn/*.bmp');
            spath = '../../LIVE/result/wn/patches/';
        else
            files = dir('../../LIVE/data/gblur/*.bmp');
            spath = '../../LIVE/result/gblur/patches/';
        end
    elseif(data == 2)
        if(distortion == 1)
            files = dir('../../TID/data/jp2k/*.bmp');
            spath = '../../TID/result/jp2k/patches/';
        elseif(distortion == 2)
            files = dir('../../TID/data/jpeg/*.bmp');
            spath = '../../TID/result/jpeg/patches/';
        elseif(distortion == 3)
            files = dir('../../TID/data/wn/*.bmp');
            spath = '../../TID/result/wn/patches/';
        else
            files = dir('../../TID/data/gblur/*.bmp');
            spath = '../../TID/result/gblur/patches/';
        end
    elseif(data == 3)
        if(distortion == 1)
            files = dir('../../CSIQ/data/jp2k/*.png');
            spath = '../../CSIQ/result/jp2k/patches/';
        elseif(distortion == 2)
            files = dir('../../CSIQ/data/jpeg/*.png');
            spath = '../../CSIQ/result/jpeg/patches/';
        elseif(distortion == 3)
            files = dir('../../CSIQ/data/wn/*.png');
            spath = '../../CSIQ/result/wn/patches/';
        else
            files = dir('../../CSIQ/data/gblur/*.png');
            spath = '../../CSIQ/result/gblur/patches/';
        end
    end
            
    no_images = size(files);
    
    for i=1:no_images
    
        Xt = [];
        img = files(i,1).name;
        I = imread(img);
        I = rgb2gray(I);

        [P,locations,mx,my,ent] = getpatchesDict(I,w,entropy_thresh);
        noP = size(P,2);
        if(noP < no_target_patches)
            no_patches = ceil(noP);
            p = randsample(noP,no_patches);
        else
            p = randsample(noP,no_target_patches);
        end
        Xt = [Xt P(:,p)];


        saveT = strcat('Target_Patches_',img);
        saveT = strcat(saveT,'.mat');
        saveT = strcat(spath,saveT);
        save(saveT,'Xt');
    end
end