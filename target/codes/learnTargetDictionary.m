function learnTargetDictionary(Edata,iter,dictSize,distortion,data)
    
    if(data == 1)
        if(distortion == 1)
            files = dir('../../LIVE/result/jp2k/patches/*.mat');
            spath = '../../LIVE/result/jp2k/Dictionary/';
        elseif(distortion == 2)
            files = dir('../../LIVE/result/jpeg/patches/*.mat');
            spath = '../../LIVE/result/jpeg/Dictionary/';
        elseif(distortion == 3)
            files = dir('../../LIVE/result/wn/patches/*.mat');
            spath = '../../LIVE/result/wn/Dictionary/';
        else
            files = dir('../../LIVE/result/gblur/patches/*.mat');
            spath = '../../LIVE/result/gblur/Dictionary/';
        end
    elseif(data == 2)
        if(distortion == 1)
            files = dir('../../TID/result/jp2k/patches/*.mat');
            spath = '../../TID/result/jp2k/Dictionary/';
        elseif(distortion == 2)
            files = dir('../../TID/result/jpeg/patches/*.mat');
            spath = '../../TID/result/jpeg/Dictionary/';
        elseif(distortion == 3)
            files = dir('../../TID/result/wn/patches/*.mat');
            spath = '../../TID/result/wn/Dictionary/';
        else
            files = dir('../../TID/result/gblur/patches/*.mat');
            spath = '../../TID/result/gblur/Dictionary/';
        end
    elseif(data == 3)
        if(distortion == 1)
            files = dir('../../CSIQ/result/jp2k/patches/*.mat');
            spath = '../../CSIQ/result/jp2k/Dictionary/';
        elseif(distortion == 2)
            files = dir('../../CSIQ/result/jpeg/patches/*.mat');
            spath = '../../CSIQ/result/jpeg/Dictionary/';
        elseif(distortion == 3)
            files = dir('../../CSIQ/result/wn/patches/*.mat');
            spath = '../../CSIQ/result/wn/Dictionary/';
        else
            files = dir('../../CSIQ/result/gblur/patches/*.mat');
            spath = '../../CSIQ/result/gblur/Dictionary/';
        end
    end
    
    no_images = size(files);
    
    % for parallel processing
    matlabpool open 4
    
    parfor i=1:no_images(1)
    
        pat = files(i,1).name
        x = parLoad(pat);
        Xt = x.Xt;
        parClear(x);
        
        params = getParams(Xt,Edata,iter,1,dictSize);

        [target_dict,target_coeff] = ksvd(params);

        dict = strcat('TargetDictionary_',img);
        dict = strcat(dict,'_');
        dict = strcat(dict,num2str(dictSize));
        dict = strcat(dict,'.mat');
        dict = strcat(spath,dict);
        parSave(dict,target_dict,target_coeff,Edata,iter);
    
    end
    
    % close parallel loop
    matlabpool close

end