function spearmanScore(distortion,flag,dictSize,data)

    if(data == 1)
        if(distortion == 1)
            spath = '../../LIVE/result/jp2k/CorrelationScore/';
            load('../../LIVE/DMOS/dmos_JP2K.mat');
        elseif(distortion == 2)
            spath = '../../LIVE/result/jpeg/CorrelationScore/';
            load('../../LIVE/DMOS/dmos_JPEG.mat');
        elseif(distortion == 3)
            spath = '../../LIVE/result/wn/CorrelationScore/';
            load('../../LIVE/DMOS/dmos_AWGN.mat');
        else
            spath = '../../LIVE/result/gblur/CorrelationScore/';
            load('../../LIVE/DMOS/dmos_BLUR.mat');
        end
    elseif(data == 2)
        if(distortion == 1)
            spath = '../../TID/result/jp2k/CorrelationScore/';
            load('../../TID/DMOS/dmos_JP2K.mat');
        elseif(distortion == 2)
            spath = '../../TID/result/jpeg/CorrelationScore/';
            load('../../TID/DMOS/dmos_JPEG.mat');
        elseif(distortion == 3)
            spath = '../../TID/result/wn/CorrelationScore/';
            load('../../TID/DMOS/dmos_AWGN.mat');
        else
            spath = '../../TID/result/gblur/CorrelationScore/';
            load('../../TID/DMOS/dmos_BLUR.mat');
        end
    elseif(data == 3)
        if(distortion == 1)
            spath = '../../CSIQ/result/jp2k/CorrelationScore/';
            load('../../CSIQ/DMOS/dmos_JP2K.mat');
        elseif(distortion == 2)
            spath = '../../CSIQ/result/jpeg/CorrelationScore/';
            load('../../CSIQ/DMOS/dmos_JPEG.mat');
        elseif(distortion == 3)
            spath = '../../CSIQ/result/wn/CorrelationScore/';
            load('../../CSIQ/DMOS/dmos_AWGN.mat');
        else
            spath = '../../CSIQ/result/gblur/CorrelationScore/';
            load('../../CSIQ/DMOS/dmos_BLUR.mat');
        end
    end
    
    if(flag == 1)
        enpath = strcat(spath,'Energy_M.mat');
        load(enpath);
        
        srocc_energy = zeros(size(no_comp,2),1);
        lcc_energy = zeros(size(no_comp,2),1);
        krocc_energy = zeros(size(no_comp,2),1);

        srocc_error = zeros(size(no_comp,2),1);
        lcc_error = zeros(size(no_comp,2),1);
        krocc_error = zeros(size(no_comp,2),1);

        for i=1:size(no_comp,2)
            srocc_energy(i,1) = corr(all_energy(i,:)',dmos,'Type','Spearman');
            lcc_energy(i,1) = corr(all_energy(i,:)',dmos,'Type','Pearson');
            krocc_energy(i,1) = corr(all_energy(i,:)',dmos,'Type','Kendall');

            srocc_error(i,1) = corr(all_error(i,:)',dmos,'Type','Spearman');
            lcc_error(i,1) = corr(all_error(i,:)',dmos,'Type','Pearson');
            krocc_error(i,1) = corr(all_error(i,:)',dmos,'Type','Kendall');
        end
        
        pth = strcat(spath,'Correlation_Score_PCA.mat');
        save(pth,'srocc_energy','lcc_energy','krocc_energy','srocc_error','lcc_error','krocc_error','no_comp');
    else 
        enpath = strcat('Energy_DL_M_',num2str(dictSize));
        enpath = strcat(enpath,'.mat');
        enpath = strcat(spath,enpath);
        load(enpath);
        
        srocc_energy = corr(all_energy,jpeg_dmos','Type','Spearman');
        lcc_energy = corr(all_energy,jpeg_dmos','Type','Pearson');
        krocc_energy = corr(all_energy,jpeg_dmos','Type','Kendall');

        srocc_error = corr(all_error,jpeg_dmos','Type','Spearman');
        lcc_error = corr(all_error,jpeg_dmos','Type','Pearson');
        krocc_error = corr(all_error,jpeg_dmos','Type','Kendall');
        
        pth = strcat('Correlation_Scores_DL_',num2str(dictSize));
        pth = strcat(pth,'.mat');
        pth = strcat(spath,pth);
        save(pth,'srocc_energy','lcc_energy','krocc_energy','srocc_error','lcc_error','krocc_error','no_comp');
    end
end