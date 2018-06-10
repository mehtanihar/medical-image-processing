function [x,prev_rrmse,data_rec]=huber(imageNoiseless,y,alpha,gamma)
    step=0.1;
    prev_rrmse=100;
    x=y;
    data_rec=[];
     while(abs(rrmse(imageNoiseless,x)-prev_rrmse)>0.00001)
                  
         prev_rrmse=rrmse(imageNoiseless,x);
         grad_prior=huber_grad(x-circshift(x,1,1),gamma)+huber_grad(x-circshift(x,-1,1),gamma)+huber_grad(x-circshift(x,1,2),gamma)+huber_grad(x-circshift(x,-1,2),gamma);
         grad=2*(1-alpha)*(x-y)+alpha*grad_prior;
         x=x-step*grad;
         data_rec=[data_rec prev_rrmse];
          %disp(rrmse(imageNoiseless,x));

     end
     


end