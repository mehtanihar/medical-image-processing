function [R]=myIntegration(image,t,theta,ds)
 
    %Initialization
    [row,col,dim]=size(image);
    theta=theta*pi/180;
    s=0;   
    x=t*cos(theta)-s*sin(theta);
    y=t*sin(theta)+s*cos(theta);
    xvec=[];yvec=[];
    
    %Case when the foot of perpendicular is inside the image
    if(abs(x)<((row-1)/2) && abs(y)<((col-1)/2))
        %Loop till s_max
        while(abs(x)<((row-1)/2) && abs(y)<((col-1)/2))
            
            s=s+ds;
            x=t*cos(theta)-s*sin(theta);
            y=t*sin(theta)+s*cos(theta);
            if(abs(x)<((row-1)/2) && abs(y)<((col-1)/2))
                xvec=[xvec x];
                yvec=[yvec y];
            end

        end

        s=0;
        x=t*cos(theta)-s*sin(theta);
        y=t*sin(theta)+s*cos(theta);
        
        %Loop till s_min
        while(abs(x)<((row-1)/2) && abs(y)<((col-1)/2))
            s=s-ds;
            x=t*cos(theta)-s*sin(theta);
            y=t*sin(theta)+s*cos(theta);
            if(abs(x)<((row-1)/2) && abs(y)<((col-1)/2))
                xvec=[xvec x];
                yvec=[yvec y];
            end

        end
    %Case when the foot of perpendicular is outside the circumcircle of image    
    elseif(t>(sqrt(((row-1)^2+(col-1)^2)/4)))
        R=0;
        return;
     %Case when the foot of perpendicular is outside the image, but inside the circumcircle  
    elseif(t<=(sqrt(((row-1)^2+(col-1)^2)/4)))
  
        s=0;
        x=t*cos(theta)-s*sin(theta);
        y=t*sin(theta)+s*cos(theta);
        %Loop till s_max crosses circumcircle
        while((t^2+s^2)<=((row-1)^2+(col-1)^2)/4)
            s=s+ds;
            x=t*cos(theta)-s*sin(theta);
            y=t*sin(theta)+s*cos(theta);
            if(abs(x)<((row-1)/2) && abs(y)<((col-1)/2))
                xvec=[xvec x];
                yvec=[yvec y];
            end
            
        end
        
        s=0;
        x=t*cos(theta)-s*sin(theta);
        y=t*sin(theta)+s*cos(theta);
        %Loop till s_min crosses circumcircle
        while((t^2+s^2)<=((row-1)^2+(col-1)^2)/4)
            s=s-ds;
            x=t*cos(theta)-s*sin(theta);
            y=t*sin(theta)+s*cos(theta);
            if(abs(x)<((row-1)/2) && abs(y)<((col-1)/2))
                xvec=[xvec x];
                yvec=[yvec y];
            end
            
        end
        
       
    end

    x=-(row-1)/2:1:(row-1)/2;
    y=-(col-1)/2:1:(col-1)/2;
    [X,Y]=meshgrid(x,y);
    data_points = interp2(X,Y,image,xvec,yvec);

    R = ds*sum(data_points); 
   
    
end