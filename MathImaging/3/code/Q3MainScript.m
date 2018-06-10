
%% PART A

clear all
%Initialization
ct_chest=load('../../data/CT_Chest.mat');
image1=mat2gray(ct_chest.imageAC);
theta=1:150;
rrmse=zeros(1,150);
radon_trans=radon(image1,1:180);
[M,N]=size(image1);
w_max=pi*(M-1)/M;

%Loop all possible angle permutations
for i=1:180
    angles=sort(mod((1:150)+i,180)+1);
    radon_trans_loop=radon_trans(:,angles);
    filtered_image=myFilter(radon_trans_loop,1,w_max);
	reconstructed_image=mat2gray(0.5*iradon(filtered_image, angles,'linear','none',1,M));
    rrmse(i)=sqrt(sum((image1(:)-reconstructed_image(:)).^2)/sum((image1(:).^2)));
end
index=find(rrmse==min(rrmse));
radon_trans_new=radon(image1,theta+index);
filtered_image=myFilter(radon_trans_new,1,w_max);
best_reconstructed_image=mat2gray(0.5*iradon(filtered_image, mod(theta + index,180),'linear','none',1,M));

%Plots
figure;
subplot(2,1,1); plot(rrmse); title('CT Chest RRMSE vs Theta')
subplot(2,1,2); imshow(best_reconstructed_image); title('CT Chest bestReconstructed Image')

%% PART B
clear all
%Initialization
myPhantom=load('../../data/myPhantom.mat');
image2=mat2gray(myPhantom.imageAC);
rrmse=zeros(1,150);
radon_trans=radon(image2,1:180);
[M,N]=size(image2);
w_max=pi*(M-1)/M;
theta=1:150;

%Loop all possible angle permutations
for i=1:180
    angles=sort(mod((1:150)+i,180)+1);
    radon_trans_loop=radon_trans(:,angles);
    filtered_image=myFilter(radon_trans_loop,1,1);
	reconstructed_image=mat2gray(0.5*iradon(filtered_image, angles,'linear','none',1,M));
	rrmse(i)=sqrt(sum((image2(:)-reconstructed_image(:)).^2)/sum((image2(:).^2)));
end
index=find(rrmse==min(rrmse));
radon_trans_new=radon(image2,theta+index);
filtered_image=myFilter(radon_trans_new,1,1);
best_reconstructed_image=mat2gray(0.5*iradon(filtered_image, mod(theta + index,180),'linear','none',1,M));

%Plots
figure;
subplot(2,1,1); plot(rrmse); title('Phantom RRMSE vs Theta')
subplot(2,1,2); imshow(best_reconstructed_image); title('Phantom bestReconstructed Image')