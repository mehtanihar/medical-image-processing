function radon_trans=myRadonTrans(image,dt,ds)
    radon_trans=zeros(37,36);
    
    i=0;
    for t=-90:dt:90
        i=i+1;
        j=0;
        for theta=0:5:175
            j=j+1;
            radon_trans(i,j)=myIntegration(image,t,theta,ds);
        end
    end
end