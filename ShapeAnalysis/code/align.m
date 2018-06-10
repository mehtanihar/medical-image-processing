function z=align(z1,z2)
    [D,N]=size(z1);
    z1=z1-repmat(mean(z1,2),[1,N]);
    z2=z2-repmat(mean(z2,2),[1,N]);
    z1=z1/norm(z1);
    z2=z2/norm(z2);
    W=eye(N);
    [U,sigma,V]=svd(z1*W*z2');
    R=V*U';
    z=R*z1;
    
    
end