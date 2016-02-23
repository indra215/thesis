function params = getParams(Xt,ed,iter,exact,dictsize)
    params.data = Xt;
    params.Edata = ed;
    params.iternum = iter;
    params.exact = exact;   
    if(size(Xt,2) < dictsize)
        params.dictsize = size(Xt,2);
    else 
        params.dictsize = dictsize;
    end
    
end