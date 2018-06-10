function dgdu=huber_grad(A,gamma)
    dgdu=A;
    [row,col]=size(A);
    
    for i=1:row
        for j=1:col
            u=A(i,j);
            
            if(abs(u)<=gamma)
                dgdu(i,j)=u;
            else
                dgdu(i,j)=gamma*sign(u);
            end
        end
    end
    
end