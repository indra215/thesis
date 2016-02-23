% main file for source set

tic
clear all
close all


%% parameters for patch extraction
w = 16;
mlt = 50;
no_source_patches = 500;
entropy_thresh = 3;

%% extract patches and save in the result folder

Xs = getSourcePatches(w,mlt,no_source_patches,entropy_thresh);
save('Source_Patches.mat','Xs','entropy_thresh');

%% perform PCA 

[s_coeff, ~, ~, ~, s_explained] = pca(Xs');
save('Source_PCA.mat','s_coeff','s_explained');

%% Dictionary Learning

% params for dictionary learning
params.data = Xs;
params.Edata = 0.01;
params.iternum = 15;
params.exact = 1;
params.dictsize = 500;
[source_dict,source_coeff,Edata,iter] = learnDictionary(params);
save('Source_Dictionary.mat','source_dict','source_coeff','Edata','iter');

%%
toc