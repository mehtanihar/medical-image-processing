function [filtered_image]=myFilter(image,filter_id,L)
    
    %First shift to frequency domain
    fft_image=fft(image);
    [M,N]=size(image);
    w=2*pi/M*(0:M-1);
    w =(w-w(round(M/2)))';


    %Ram-Lak filter
    if(filter_id==1)
        filter=abs(w).*(abs(w)<=L);
    end

    %Shepp-Logan filter
    if(filter_id==2)
        filter=abs(w).*((abs(w)<=L).*(sin(0.5*pi*w/L)./(0.5*pi*w/L)));
        filter(w==0)=0;
    end
    %Cosine filter
    if(filter_id==3)
        filter=abs(w).*(abs(w)<=L).*cos(0.5*pi*w/L);
    end
    
    %Back to space domain
    filtered_image=real(ifft(fft_image.*repmat(ifftshift(filter),1,N)));
    
end