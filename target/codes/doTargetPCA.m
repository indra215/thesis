function doTargetPCA(distortion,data)

    if(data == 1)
        if(distortion == 1)
            files = dir('../../LIVE/result/jp2k/patches/*.mat');
            spath = '../../LIVE/result/jp2k/PCA/';
        elseif(distortion == 2)
            files = dir('../../LIVE/result/jpeg/patches/*.mat');
            spath = '../../LIVE/result/jpeg/PCA/';
        elseif(distortion == 3)
            files = dir('../../LIVE/result/wn/patches/*.mat');
            spath = '../../LIVE/result/wn/PCA/';
        else
            files = dir('../../LIVE/result/gblur/patches/*.mat');
            spath = '../../LIVE/result/gblur/PCA/';
        end
    elseif(data == 2)
        if(distortion == 1)
            files = dir('../../TID/result/jp2k/patches/*.mat');
            spath = '../../TID/result/jp2k/PCA/';
        elseif(distortion == 2)
            files = dir('../../TID/result/jpeg/patches/*.mat');
            spath = '../../TID/result/jpeg/PCA/';
        elseif(distortion == 3)
            files = dir('../../TID/result/wn/patches/*.mat');
            spath = '../../TID/result/wn/PCA/';
        else
            files = dir('../../TID/result/gblur/patches/*.mat');
            spath = '../../TID/result/gblur/PCA/';
        end
    elseif(data == 3)
        if(distortion == 1)
            files = dir('../../CSIQ/result/jp2k/patches/*.mat');
            spath = '../../CSIQ/result/jp2k/PCA/';
        elseif(distortion == 2)
            files = dir('../../CSIQ/result/jpeg/patches/*.mat');
            spath = '../../CSIQ/result/jpeg/PCA/';
        elseif(distortion == 3)
            files = dir('../../CSIQ/result/wn/patches/*.mat');
            spath = '../../CSIQ/result/wn/PCA/';
        else
            files = dir('../../CSIQ/result/gblur/patches/*.mat');
            spath = '../../CSIQ/result/gblur/PCA/';
        end
    end
        
    no_images = size(files);
    
    for i=1:no_images
        
        pat = files(i,1).name;
        load(pat);
        
        [t_coeff,~,~,~,t_explained] = pca(Xt');
        savePCA = strcat('Target_PCA_',img);
        savePCA = strcat(savePCA,'.mat');
        savePCA = strcat(spath,savePCA);
        save(savePCA,'t_coeff','t_explained');
    end
end