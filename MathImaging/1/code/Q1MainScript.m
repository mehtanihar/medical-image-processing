%% PARTS 1 & 2

image=phantom(128);

ds=0.5;
dt=5;
tic;
R0=myRadonTrans(image,dt,ds);
figure; imagesc(R0); title('Radon transform with ds=0.5');
toc;

ds=1;
tic;
R1=myRadonTrans(image,dt,ds);
figure; imagesc(R1); title('Radon transform with ds=1');
toc;

ds=3;
tic;
R2=myRadonTrans(image,dt,ds);
figure; imagesc(R2); title('Radon transform with ds=3');
toc;

disp('Thus we can see that when ds increases,the computational time decreases.');
disp('But when ds increases, blurring also increases');
disp('Hence we can choose ds=1 as an optimum ds meeting the trade off between time and blurring');

disp('The interpolation scheme chosen in bilinear interpolation,');
disp('which is the default scheme of interp2 function');
disp('This scheme is chosen because it is well suited for discrete 2D images');



%% PART 3

ds=0.5;
theta=0; 
t=-90:dt:90;
len=length(t);
R=zeros(1,len);

for i=1:len
    R(i)=myIntegration(image,t(i),theta,ds);
end
figure; subplot(3,2,1);plot(t,R);
title('theta=0 and ds=0.5');
xlabel('t');
ylabel('Radon Transform');

ds=0.5;
theta=90; 
t=-90:dt:90;
len=length(t);
R=zeros(1,len);

for i=1:len
    R(i)=myIntegration(image,t(i),theta,ds);
end
subplot(3,2,2);plot(t,R);
title('theta=90 and ds=0.5');
xlabel('t');
ylabel('Radon Transform');

ds=1;
theta=0; 
t=-90:dt:90;
len=length(t);
R=zeros(1,len);

for i=1:len
    R(i)=myIntegration(image,t(i),theta,ds);
end
subplot(3,2,3);plot(t,R);
title('theta=0 and ds=1');
xlabel('t');
ylabel('Radon Transform');


ds=1;
theta=90; 
t=-90:dt:90;
len=length(t);
R=zeros(1,len);

for i=1:len
    R(i)=myIntegration(image,t(i),theta,ds);
end
subplot(3,2,4);plot(t,R);
title('theta=90 and ds=1');
xlabel('t');
ylabel('Radon Transform');


ds=3;
theta=0; 
t=-90:dt:90;
len=length(t);
R=zeros(1,len);

for i=1:len
    R(i)=myIntegration(image,t(i),theta,ds);
end
subplot(3,2,5);plot(t,R);
title('theta=0 and ds=3');
xlabel('t');
ylabel('Radon Transform');

ds=3;
theta=90; 
t=-90:dt:90;
len=length(t);
R=zeros(1,len);

for i=1:len
    R(i)=myIntegration(image,t(i),theta,ds);
end

subplot(3,2,6);plot(t,R);
title('theta=90 and ds=3');
xlabel('t');
ylabel('Radon Transform');

disp('The plots with theta=0 are less smoother than theta=90');
disp('The plots with higher ds are less smoother than those with lower ds.');
disp('This is due to the fact that the phantom image has short dark patches in X direction,which is theta=0,');
disp('but has long dark patches in the Y direction, which is theta=90');
disp('As ds increases,we save computation time, but we undersample the points');
disp('Hence the plots with higher ds are less smoother');


%% PART 4

ds=1;
dt=10;
tic;
R1=myRadonTrans(image,dt,ds);
figure; imagesc(R1); title('Radon transform with ds=1 and dt=10');
toc;
disp('Thus larger dT causes blurring in the radon transform');

disp('The two parameters ?t and ?? ?will define the x-y resolution of the transform,');
disp('which essentially is another way to sample Fourier transform.');
disp('At higher resolution, the exposure time to the radiation is longer for the patients');
disp('which is not recommended. At lower resolution,');
disp('increasing these parameters might introduce artifacts like aliasing in the reconstructed image.');
disp('Thus, according to the requirement of the resolution of the reconstructed image,');
disp('we can use and tune the parameters ?t and ??');

%% PART 5

disp('The parameter ?s relates to the quantisation noise.');
disp('Higher ?s results in coarser quantisation of the reconstructed image');
disp('and we can’t improve the noise beyond a certain limit even after lowering ?s');
disp('since the number of pixels in the grid is finite.');
disp('Also, ?s <<1 would lead to higher overhead for interpolation');
disp('and hence computationally infeasible and ?s >>1 would lead to loss in resolution of the reconstructed image.');
disp('Thus, there exists an optimum level for delta given the number of pixels in the grid and vice versa.');





