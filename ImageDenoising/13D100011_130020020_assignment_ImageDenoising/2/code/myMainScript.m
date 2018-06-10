load('../data/assignmentImageDenoisingBrainNoisy.mat');

%% estimating noise
%(x1,y1) to (x2,y2) will determine the background window
x1 = 1; y1=1; x2 = 50; y2 = 50;
noise_real = sqrt(var(real(temp(:))));
noise_imag = sqrt(var(imag(temp(:))));
noise = noise_real + i*noise_imag

%% quadratic
alpha_optimal=0.47;
s = 0.1;
i =1;
x = imageNoisy;
y =imageNoisy ;
alpha = alpha_optimal;
gamma = 1;
objective_array=[];
prior_type = 'quadratic';
prev_check = 10e9;

while (~converged )
[prior,prior_penalty] = prior_calculator(x,prior_type,gamma);
curr = x - 2*s*((1-alpha)*(x-y)+(alpha)*prior);
%note: x-y is the likelihood term
new_check = (1-alpha)*(sum(sum(abs(curr-y).^2)))+(alpha)*(sum(sum(abs(prior_penalty))));
if(new_check < prev_check)
prev_check=new_check;
x = curr;
s = s + 0.1*s;
objective=new_check;
objective_array(i) = objective;
i=i+1;
else
s = s/2;
end

if(s<1e-10)
converged = true;
end
end

%fig=figure;set(gcf, 'Position', get(0,'Screensize'));
%imshow(mat2gray(abs(Current_Iterative_Image))); title(['Optimal Image of Denoised Brain for ' ,prior_type,' prior']);
%saveas(fig,['../results/Optimal_Denoised_Image for Brain ','.jpg'],'jpg');
%close(fig);

%% huber
alpha=0.75;
gamma=0.06;
s = 0.1;
i =1;
x = imageNoisy;
objective_array=[];
prior_type = 'huber';
prev_check = 10e9;
converged = false;

while (~converged )
[prior,prior_penalty] = prior_calculator(x,prior_type,gamma);
curr = x - 2*s*((1-alpha)*(x-y)+(alpha)*prior);
%note: x-y is the likelihood term
new_check = (1-alpha)*(sum(sum(abs(curr-y).^2)))+(alpha)*(sum(sum(abs(prior_penalty))));
if(new_check < prev_check)
prev_check=new_check;
x = curr;
s = s + 0.1*s;
objective=new_check;
objective_array(i) = objective;
i=i+1;
else
s = s/2;
end

if(s<1e-10)
converged = true;
end
end



%% disc_adapt_function
alpha=0.75;
gamma=0.08;
s = 0.1;
i =1;
objective_array=[];
x = imageNoisy;
prior_type = 'disc_adapt_function';
prev_check = 10e9;
converged = false;

while (~converged )
[prior,prior_penalty] = prior_calculator(x,prior_type,gamma);
curr = x - 2*s*((1-alpha)*(x-y)+(alpha)*prior);
%note: x-y is the likelihood term
new_check = (1-alpha)*(sum(sum(abs(curr-y).^2)))+(alpha)*(sum(sum(abs(prior_penalty))));
if(new_check < prev_check)
prev_check=new_check;
x = curr;
s = s + 0.1*s;
objective=new_check;
objective_array(i) = objective;
i=i+1;
else
s = s/2;
end

if(s<1e-10)
converged = true;
end
end

fig=figure;set(gcf, 'Position', get(0,'Screensize'));
imshow(mat2gray(abs(Current_Iterative_Image))); title(['Optimal Image of Denoised Brain for ' ,prior_type,' prior']);
saveas(fig,['../results/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);
