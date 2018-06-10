function rrmse=RRMSE(A,B)
    rrmse=sqrt(sum((A(:)-B(:)).^2)/sum(A(:).^2));

end