function [Dict,Coeff,Edata,iter] = learnDictionary(params)

    [Dict,Coeff] = ksvd(params);
    Edata = params.Edata;
    iter = params.iternum;
    
end