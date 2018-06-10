function dgdu=discontinuity_adaptive_grad(A,gamma)
    dgdu=A;
    [row,col]=size(A);
    
    for i=1:row
        for j=1:col
            u=A(i,j);
            dgdu(i,j)=gamma*sign(u)*(1-1/(1+abs(u)/gamma));

        end
    end
    
end