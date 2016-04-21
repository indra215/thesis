function domainadaptation(distortion,flag,dictSize,data)

    if(data == 1)
        if(distortion == 1)
            pca_files = dir('../../LIVE/result/jp2k/PCA/*.mat');
            dict = dir('../../LIVE/result/jp2k/Dictionary/*.mat');
            spath = '../../LIVE/result/jp2k/CorrelationScore/';
        elseif(distortion == 2)
            pca_files = dir('../../LIVE/result/jpeg/PCA/*.mat');
            dict = dir('../../LIVE/result/jpeg/Dictionary/*.mat');
            spath = '../../LIVE/result/jpeg/CorrelationScore/';
        elseif(distortion == 3)
            pca_files = dir('../../LIVE/result/wn/PCA/*.mat');
            dict = dir('../../LIVE/result/wn/Dictionary/*.mat');
            spath = '../../LIVE/result/wn/CorrelationScore/';
        else
            pca_files = dir('../../LIVE/result/gblur/PCA/*.mat');
            dict = dir('../../LIVE/result/gblur/Dictionary/*.mat');
            spath = '../../LIVE/result/gblur/CorrelationScore/';
        end
    elseif(data == 2)
        if(distortion == 1)
            pca_files = dir('../../TID/result/jp2k/PCA/*.mat');
            dict = dir('../../TID/result/jp2k/Dictionary/*.mat');
            spath = '../../TID/result/jp2k/CorrelationScore/';
        elseif(distortion == 2)
            pca_files = dir('../../TID/result/jpeg/PCA/*.mat');
            dict = dir('../../TID/result/jpeg/Dictionary/*.mat');
            spath = '../../TID/result/jpeg/CorrelationScore/';
        elseif(distortion == 3)
            pca_files = dir('../../TID/result/wn/PCA/*.mat');
            dict = dir('../../TID/result/wn/Dictionary/*.mat');
            spath = '../../TID/result/wn/CorrelationScore/';
        else
            pca_files = dir('../../TID/result/gblur/PCA/*.mat');
            dict = dir('../../TID/result/gblur/Dictionary/*.mat');
            spath = '../../TID/result/gblur/CorrelationScore/';
        end
    elseif(data == 3)
        if(distortion == 1)
            pca_files = dir('../../CSIQ/result/jp2k/PCA/*.mat');
            dict = dir('../../CSIQ/result/jp2k/Dictionary/*.mat');
            spath = '../../CSIQ/result/jp2k/CorrelationScore/';
        elseif(distortion == 2)
            pca_files = dir('../../CSIQ/result/jpeg/PCA/*.mat');
            dict = dir('../../CSIQ/result/jpeg/Dictionary/*.mat');
            spath = '../../CSIQ/result/jpeg/CorrelationScore/';
        elseif(distortion == 3)
            pca_files = dir('../../CSIQ/result/wn/PCA/*.mat');
            dict = dir('../../CSIQ/result/wn/Dictionary/*.mat');
            spath = '../../CSIQ/result/wn/CorrelationScore/';
        else
            pca_files = dir('../../CSIQ/result/gblur/PCA/*.mat');
            dict = dir('../../CSIQ/result/gblur/Dictionary/*.mat');
            spath = '../../CSIQ/result/gblur/CorrelationScore/';
        end
    end
    
    no_images = size(pca_files);
    
    % Subspace Alignment
    if(flag == 1)
        load('../../source/Source_PCA.mat');
        no_comp = [1:121];

        % save norms and error
        all_energy = zeros(size(no_comp,2),no_images,'double');
        all_error = zeros(size(no_comp,2),no_images,'double');

        for i=1:no_images

            f = pca_files(i,1).name;
            load(f);

            energy_M = [];
            error_M = [];
            
            % Do DA
            for j=1:size(no_comp,2)
                source = s_coeff(:,1:no_comp(j));
                target = t_coeff(:,1:no_comp(j));

                M = target'*source;

                % energy of M
                energy_M = [energy_M;norm(M,'fro')];
                % error in M
                error_M = [error_M;norm((target*M - source),'fro')];
            end
            all_energy(:,i) = energy_M;
            all_error(:,i) = error_M;
        end
        enpath = strcat(spath,'Energy_M.mat');
        save(enpath,'all_energy','all_error','no_comp');
    else
        load('../../source/Source_Dictionary.mat');
        all_energy = [];
        all_error = [];
        
        for i=1:no_images
    
            f = dict(i,1).name;
            data = load(f);
            target_dict = data.dict;
            clear data
    
            % fix the formula
            M = pinv(target_dict)*source_dict;
            %temp = pinv(target_dict'*target_dict);
            %M = temp*target_dict'*source_dict;

            ener = norm(M,'fro');
            error = norm((target_dict*M - source_dict),'fro');
            all_energy = [all_energy;ener];
            all_error = [all_error;error];
        end
        enpath = strcat('Energy_DL_M_',num2str(dictSize));
        enpath = strcat(enpath,'.mat');
        enpath = strcat(spath,enpath);
        save(enpath,'all_energy','all_error','dictSize');
    end
    
end
