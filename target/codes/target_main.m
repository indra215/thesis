function target_main(w,no_target_patches,entropy_thresh,data,distortion,basisFlag)

    % main file for the target set

    tic
    clear all
    close all

    %% extract patches and save in the result folder
    getTargetPatches(w,no_target_patches,entropy_thresh,distortion,data);

    %% perform PCA 

    doTargetPCA(distortion,data);

    %% Dictionary Learning

    % params for dictionary learning
    Edata = 0.05;
    iter = 15;
    dictSize = 500;
    learnTargetDictionary(Edata,iter,dictSize,distortion,data);

    %% Subspace Alignment

    % 1 for PCA basis
    % 2 for Dictionary Learning basis
    domainadaptation(distortion,basisFlag,dictSize,data);

    %% Correlation Scores

    spearmanScore(distortion,basisFlag,dictSize,data);

    %%
    toc
end