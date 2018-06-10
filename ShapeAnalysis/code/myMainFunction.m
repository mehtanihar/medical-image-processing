load('../data/ellipses2D.mat');
[D,N,M]=size(pointSets);

fig = figure;set(gcf, 'Position', get(0,'Screensize'));
for k=1:M
plot(pointSets(1,:,k),pointSets(2,:,k),'--','LineWidth',0.1,'color',rand(1,3));
hold all
end
title('Input Pointsets');
saveas(fig,['../results/Input Pointsets Ellipses','.jpg'],'jpg');


[mean,xalligned]=compute_mean(pointSets);



fig = figure;set(gcf, 'Position', get(0,'Screensize'));
for k=1:M
    plot(xalligned(1,:,k),xalligned(2,:,k),'--','LineWidth',0.1,'color',rand(1,3));
    hold all
end
hold on;
plot(mean(1,:),mean(2,:),'-','LineWidth',3,'color','black');
title('The Aligned Pointsets and mean shape');
saveas(fig,['../results/Alligned pointsets Ellipses and mean shape','.jpg'],'jpg');



% covariance matrix which is stored below
cov_mat = zeros(D*N,N*D);
Vec_Mean=reshape(mean,[D*N,1]);
for k=1:M

% Computing variance over shapes
cov_mat(:,:) = squeeze(cov_mat(:,:)) + (reshape(xalligned(:,:,k),[D*N,1]) - Vec_Mean)*(reshape(xalligned(:,:,k),[D*N,1]) - Vec_Mean)';

end

% Sample variance so dividing by n-1;
cov_mat = cov_mat./(M - 1);

% Performing PCA over covariance matrix to get principal mode of variation

[V, Diag] = eig(squeeze(cov_mat(:,:)));

V=fliplr(V);% Precisely because eigen values were in ascending order


lambda = fliplr((diag(Diag))');% Precisely because eigen values were in ascending order
                
                
fig = figure;set(gcf, 'Position', get(0,'Screensize'));
plot(lambda,'b');
title('Eigenvalues')
saveas(fig,['../results/Eigenvalues Ellipses','.jpg'],'jpg');


% Computing modes of variation by adding scaled eigenvectors
mode1=Vec_Mean+2*(lambda(1)^0.5)*V(:,1);
mode2=Vec_Mean-2*(lambda(1)^0.5)*V(:,1);


mode1=reshape(mode1, [D,N]);
mode2=reshape(mode2, [D,N]);

for k=1:D
    disp(k)
mode1(k,:) = mode1(k,:) - sum(mode1(k,:))/N;
mode2(k,:) = mode2(k,:) - sum(mode2(k,:))/N;
end
mode1 = mode1./norm(mode1,'fro');
mode2 = mode2./norm(mode2,'fro');

fig = figure;set(gcf, 'Position', get(0,'Screensize'));
for k =1:M
plot(xalligned(1,:,k),xalligned(2,:,k),'*','LineWidth',0.1,'color',rand(1,3));
hold all;
end

h1= plot(mean(1,:),mean(2,:),'-','LineWidth',3,'color','r');
hold on;
h2=plot(mode1(1,:),mode1(2,:),'-','LineWidth',3,'color','y');
hold on;
h3=plot(mode2(1,:),mode2(2,:),'-','LineWidth',3,'color','k');
legend([h1,h2 ,h3 ],'Mean','Mean+2SD','Mean-2SD');
title('2 modes of variation and aligned dataset');
saveas(fig,['../results/Modes of variation and aligned dataset Ellipse','.jpg'],'jpg');
                
%% 

load('../data/hands2D.mat');
[D,N,M]=size(shapes);

fig = figure;set(gcf, 'Position', get(0,'Screensize'));
for k=1:M
plot(shapes(1,:,k),shapes(2,:,k),'--','LineWidth',0.1,'color',rand(1,3));
hold all
end
title('Input Pointsets');
saveas(fig,['../results/Input Pointsets Hand','.jpg'],'jpg');


[mean,xalligned]=compute_mean(shapes);



fig = figure;set(gcf, 'Position', get(0,'Screensize'));
for k=1:M
    plot(xalligned(1,:,k),xalligned(2,:,k),'--','LineWidth',0.1,'color',rand(1,3));
    hold all
end
hold on;
plot(mean(1,:),mean(2,:),'-','LineWidth',3,'color','black');
title('The Aligned Pointsets and mean shape');
saveas(fig,['../results/Alligned pointsets Hand and mean shape','.jpg'],'jpg');


% covariance matrix which is stored below
cov_mat = zeros(D*N,N*D);
Vec_Mean=reshape(mean,[D*N,1]);
for k=1:M

% Computing variance over shapes
cov_mat(:,:) = squeeze(cov_mat(:,:)) + (reshape(xalligned(:,:,k),[D*N,1]) - Vec_Mean)*(reshape(xalligned(:,:,k),[D*N,1]) - Vec_Mean)';

end

% Sample variance so dividing by n-1;
cov_mat = cov_mat./(M - 1);

% Performing PCA over covariance matrix to get principal mode of variation

[V, Diag] = eig(squeeze(cov_mat(:,:)));

V=fliplr(V);% Precisely because eigen values were in ascending order


lambda = fliplr((diag(Diag))');% Precisely because eigen values were in ascending order
                
                
fig = figure;set(gcf, 'Position', get(0,'Screensize'));
plot(lambda,'b');
title('Eigenvalues')
saveas(fig,['../results/Eigenvalues Hand','.jpg'],'jpg');


% Computing modes of variation by adding scaled eigenvectors
mode1=Vec_Mean+2*(lambda(1)^0.5)*V(:,1);
mode2=Vec_Mean-2*(lambda(1)^0.5)*V(:,1);


mode1=reshape(mode1, [D,N]);
mode2=reshape(mode2, [D,N]);

for k=1:D
    disp(k)
mode1(k,:) = mode1(k,:) - sum(mode1(k,:))/N;
mode2(k,:) = mode2(k,:) - sum(mode2(k,:))/N;
end
mode1 = mode1./norm(mode1,'fro');
mode2 = mode2./norm(mode2,'fro');

fig = figure;set(gcf, 'Position', get(0,'Screensize'));
for k =1:M
plot(xalligned(1,:,k),xalligned(2,:,k),'*','LineWidth',0.1,'color',rand(1,3));
hold all;
end

h1= plot(mean(1,:),mean(2,:),'-','LineWidth',3,'color','r');
hold on;
h2=plot(mode1(1,:),mode1(2,:),'-','LineWidth',3,'color','y');
hold on;
h3=plot(mode2(1,:),mode2(2,:),'-','LineWidth',3,'color','k');
legend([h1,h2 ,h3 ],'Mean','Mean+2SD','Mean-2SD');
title('2 modes of variation and aligned dataset');
saveas(fig,['../results/Modes of variation and aligned dataset Hand','.jpg'],'jpg');
%% 


load('../data/bone3D.mat');
[D,N,M]=size(shapesTotal);

fig = figure;set(gcf, 'Position', get(0,'Screensize'));
view(3)
for k=1:M
plot3(shapesTotal(1,:,k),shapesTotal(2,:,k),shapesTotal(3,:,k),'--','LineWidth',0.1,'color',rand(1,3));
hold all
end
title('Input Pointsets');
saveas(fig,['../results/Input Pointsets Bone','.jpg'],'jpg');




[mean,xalligned]=compute_mean(shapesTotal);

fig = figure;set(gcf, 'Position', get(0,'Screensize'));
view(3)
for k=1:M
   
    plot3(xalligned(1,:,k),xalligned(2,:,k),xalligned(3,:,k),'--','LineWidth',0.1,'color',rand(1,3));
    hold all
end
patch('Vertices',mean','Faces',TriangleIndex,'FaceVertexCData',hsv(500),'FaceColor','flat')
title('The Aligned Pointsets and mean shape');
saveas(fig,['../results/Alligned pointsets Bone and mean shape','.jpg'],'jpg');

% covariance matrix which is stored below
cov_mat = zeros(D*N,N*D);
Vec_Mean=reshape(mean,[D*N,1]);
for k=1:M

% Computing variance over shapes
cov_mat(:,:) = squeeze(cov_mat(:,:)) + (reshape(xalligned(:,:,k),[D*N,1]) - Vec_Mean)*(reshape(xalligned(:,:,k),[D*N,1]) - Vec_Mean)';

end

% Sample variance so dividing by n-1;
cov_mat = cov_mat./(M - 1);

% Performing PCA over covariance matrix to get principal mode of variation

[V, Diag] = eig(squeeze(cov_mat(:,:)));

V=fliplr(V);% Precisely because eigen values were in ascending order


lambda = fliplr((diag(Diag))');% Precisely because eigen values were in ascending order
                
                
fig = figure;set(gcf, 'Position', get(0,'Screensize'));
plot(lambda,'b');
title('Eigenvalues')
saveas(fig,['../results/Eigenvalues Bone','.jpg'],'jpg');


% Computing modes of variation by adding scaled eigenvectors
mode1=Vec_Mean+2*(lambda(1)^0.5)*V(:,1);
mode2=Vec_Mean-2*(lambda(1)^0.5)*V(:,1);


mode1=reshape(mode1, [D,N]);
mode2=reshape(mode2, [D,N]);

for k=1:D
    disp(k)
mode1(k,:) = mode1(k,:) - sum(mode1(k,:))/N;
mode2(k,:) = mode2(k,:) - sum(mode2(k,:))/N;
end
mode1 = mode1./norm(mode1,'fro');
mode2 = mode2./norm(mode2,'fro');

fig = figure;set(gcf, 'Position', get(0,'Screensize'));
for k =1:M
plot(xalligned(1,:,k),xalligned(2,:,k),'*','LineWidth',0.1,'color',rand(1,3));
hold all;
end

h1= plot(mean(1,:),mean(2,:),'-','LineWidth',3,'color','r');
hold on;
h2=plot(mode1(1,:),mode1(2,:),'-','LineWidth',3,'color','y');
hold on;
h3=plot(mode2(1,:),mode2(2,:),'-','LineWidth',3,'color','k');
legend([h1,h2 ,h3 ],'Mean','Mean+2SD','Mean-2SD');
title('2 modes of variation and aligned dataset');
saveas(fig,['../results/Modes of variation and aligned dataset Bone','.jpg'],'jpg');