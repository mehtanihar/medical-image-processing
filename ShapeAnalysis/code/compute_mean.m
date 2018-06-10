function [x_mean,x]=compute_mean(x)
    
    [D,N,M]=size(x);
    x_ref=x(:,:,1);
   
    
    x_ref=x_ref-repmat(mean(x_ref,2),[1,N]);
    x_ref=x_ref/norm(x_ref);
    
    x_mean=x_ref;
    x_prev=zeros(D,N);
    while(norm(x_mean-x_prev)>0.01)
        
        x_prev=x_mean;
        for i=1:M
           x(:,:,i)=align(x(:,:,i),x_ref);

        end
        x_mean=mean(x,3);
        x_mean=align(x_mean,x_ref);
        x_mean=x_mean/norm(x_mean);
        disp(norm(x_mean-x_prev));
    end


end