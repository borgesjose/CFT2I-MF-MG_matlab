function [ Mp, Te, Ms ] = find_Mp_Te_Ms(h,ref,Ts)
    
    
    [mm, ii] = max(h' - ref);
    
    if mm > 0
        Mp = mm/ref(ii);
        
    else
        Mp = 0;
        
    end
    
    
    hh = [1:1:size(h,1)];
    count  = 0;
    for i = hh
        count  = count + 1;
        if(h(i)<0.95*ref(i) | h(i)>1.05*ref(i)) 
            Te = i*Ts; 
        end;   
    end        
            
    
    Ms = 0;
    
end