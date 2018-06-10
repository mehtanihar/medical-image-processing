%% PART 1

%Initialization
image=phantom(256);
theta=0:3:177;
radon_trans=radon(image,theta);
[M,N]=size(image);
w_max=pi*(M-1)/M;

%Back projection
filtered_image=myFilter(radon_trans,1,w_max/2);
back_projected_ram_lak_a=0.5*iradon(filtered_image,theta,'linear','none',1,256);

filtered_image=myFilter(radon_trans,1,w_max);
back_projected_ram_lak_b=0.5*iradon(filtered_image,theta,'linear','none',1,256);

filtered_image=myFilter(radon_trans,2,w_max/2);
back_projected_shepp_logan_a=0.5*iradon(filtered_image,theta,'linear','none',1,256);

filtered_image=myFilter(radon_trans,2,w_max);
back_projected_shepp_logan_b=0.5*iradon(filtered_image,theta,'linear','none',1,256);

filtered_image=myFilter(radon_trans,3,w_max/2);
back_projected_cosine_a=0.5*iradon(filtered_image,theta,'linear','none',1,256);

filtered_image=myFilter(radon_trans,3,w_max);
back_projected_cosine_b=0.5*iradon(filtered_image,theta,'linear','none',1,256);

%Plots
figure;
subplot(3,2,1)
imshow(back_projected_ram_lak_a); title('Ram-Lak filter with L = w_{max}/2');
subplot(3,2,2)
imshow(back_projected_ram_lak_b); title('Ram-Lak filter with L = w_{max}');
subplot(3,2,3)
imshow(back_projected_shepp_logan_a); title('Shepp-Logan filter with L = w_{max}/2');
subplot(3,2,4)
imshow(back_projected_shepp_logan_b); title('Shepp-Logan filter with L = {w_max}');
subplot(3,2,5)
imshow(back_projected_cosine_a); title('Cosine filter with L = w_{max}/2');
subplot(3,2,6)
imshow(back_projected_cosine_b); title('Cosine filter with L = w_{max}');
%% PART 2

%Gaussian blurring of the image
S0=image;
mask = fspecial('gaussian', 11, 1);
S1 = conv2 (image, mask, 'same');
mask = fspecial('gaussian', 51, 5);
S5 = conv2 (image, mask, 'same');

%Back projection via inverse radon function
filtered_image=myFilter(radon(S0,theta),1,1);
R0=0.5*iradon(filtered_image,theta,'linear','none',1,256);

filtered_image=myFilter(radon(S1,theta),1,1);
R1=0.5*iradon(filtered_image,theta,'linear','none',1,256);

filtered_image=myFilter(radon(S5,theta),1,1);
R5=0.5*iradon(filtered_image,theta,'linear','none',1,256);

%Plots
figure;
subplot(3,2,1);imshow(S0);title('Original image');
subplot(3,2,2);imshow(R0);title('Reconstructed original image');
subplot(3,2,3);imshow(S1);title('sigma=1');
subplot(3,2,4);imshow(R1);title('Reconstructed sigma=1');
subplot(3,2,5);imshow(S5);title('sigma=5');
subplot(3,2,6);imshow(R5);title('Reconstructed sigma=5');

%RRMSE values
disp('The RRMSE values are:');

disp(RRMSE(S0,R0));
disp(RRMSE(S1,R1));
disp(RRMSE(S5,R5));

disp('The RRMSE value is highest for the original image and lowest for the');
disp('blurred image. This is because the blurred image is the smoothest');
disp('and the iradon method is known to not cause any further blurring.');

%% PART 3

vec1=[]; vec2=[];vec3=[];
for L=1:w_max
    filtered_image=myFilter(radon(S0,theta),1,L);
    R0_loop=0.5*iradon(filtered_image,theta,'linear','none',1,256);
    filtered_image=myFilter(radon(S1,theta),1,L);
    R1_loop=0.5*iradon(filtered_image,theta,'linear','none',1,256);

    filtered_image=myFilter(radon(S5,theta),1,L);
    R5_loop=0.5*iradon(filtered_image,theta,'linear','none',1,256);
    vec1=[vec1 RRMSE(S0,R0_loop)];
    vec2=[vec2 RRMSE(S1,R1_loop)];
    vec3=[vec3 RRMSE(S5,R5_loop)];
end

figure;
subplot(3,1,1); plot(1:w_max,vec1); title('RRMSE(S0,R0) vs L)');
subplot(3,1,2); plot(1:w_max,vec2); title('RRMSE(S1,R1) vs L)');
subplot(3,1,3); plot(1:w_max,vec3); title('RRMSE(S2,R2) vs L)');

disp('RRMSE seems to increase with L. As L increases, our constraint');
disp('on the frequency is further relaxes, due to which noise is highly amplified');
disp('for higher frequencies. Hence RRMSE increases with L.');
