% This package contains an implementation of the Anisotropic Diffusion
% algorithm for simulated images

%%%%% The main function is "diffusion_SIM". It returns the resultant greyscale diffused image, after using the proposed algorithm. 
%%%%% I=dfussion_SIM(A,vert) --> Fully automated version of the method 
%%%%% I=diffusion_SIM(A,vert,Temp,Niter)  --> Parameterized version of the method


% Input 'A' is the greyscale noisy image.
% Input 'vert' is the interest area.
% Optional Input 'Temp' sets the template to be used, Set '1' for the 12-N template or '2' for the 4-N template. Default is '1'.
% Optional Input 'Niter' sets the number of iterations to be performed.


% Output 'I' is the filtered image

clear all
% Load the original image
filename = 'imagen3.jpg';  %Name of the image
I = imread(filename);
% Convert to gray scale
I = rgb2gray(I);
% Convert to double
I=im2double(I);
% Normalitazation
I=Normalization(I);


I2=(I(50:350,90:490));

figure,
imagesc (I2),axis image, colormap gray;
% Selection of the area of interest
title('Click on the region of interest')
[x,y] = ginput(1);
x = round(x);
y = round(y);
close(figure(1))

% Area of interest
vert = [y-10,y+10,x-10,x+10]; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%   EXAMPLE 1   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The function requires at least inputs 'A' (noisy image) and 'vert' to operate.
%%% In this case,the template size is 12-N and the stopping criterion is
%%% apply
% Example: 
[I_f,SNR,PSNR,q]= diffusion_SIM(I2, vert);
figure,
subplot(1,2,1),imagesc(I2(:,:)),axis image, colormap gray, title('Original image');
subplot(1,2,2),imagesc(I_f(:,:)),axis image, colormap gray, title('Filtered image');


%%%%%%%%%%%%%%%%%%%%%%%%%%%   EXAMPLE 2   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The function requires at least inputs 'A' (noisy image) and 'vert' to operate.
%%% In this case,the template size is 4-N and the stopping criterion is
%%% apply
% Example: 
[I_f1,SNR1,PSNR1,q1]= diffusion_SIM(I2, vert,1,[]);
figure,
subplot(1,2,1),imagesc(I2(:,:)),axis image, colormap gray, title('Original image');
subplot(1,2,2),imagesc(I_f1(:,:)),axis image, colormap gray, title('Filtered image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%   EXAMPLE 3   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The function requires at least inputs 'A' (noisy image) and 'vert' to operate.
%%% In this case,the template size is 12-N and the iterations number is
%%% chosen
% Example: 
[I_f2,SNR2,PSNR2,q2]= diffusion_SIM(I2, vert,[],60);
figure,
subplot(1,2,1),imagesc(I2(:,:)),axis image, colormap gray, title('Original image');
subplot(1,2,2),imagesc(I_f2(:,:)),axis image, colormap gray, title('Filtered image');