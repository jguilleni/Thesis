% This package contains an implementation of the Anisotropic Diffusion
% algorithm for real ultrasound images

%%%%% The main function is "diffusion_DICOM". It returns the resultant greyscale diffused image, after using the proposed algorithm. 
%%%%% I=dfussion_DICOM(A,vert) --> Fully automated version of the method 
%%%%% I=diffusion_DICOM(A,vert,Temp,Niter)  --> Parameterized version of the method


% Input 'A' is the greyscale noisy image.
% Input 'vert' is the interest area.
% Optional Input 'Temp' sets the template to be used, Set '1' for the 12-N template or '2' for the 4-N template. Default is '1'.
% Optional Input 'Niter' sets the number of iterations to be performed.


% Output 'I' is the filtered image

clear all
% Load the original image
filename = 'D7I91HAO';  %Name of the image in DICOM format
I = dicomread (filename);
I=I(:,:,:,:);
[a,b,c,d]=size(I);
I2=zeros(a,b,d);



figure,
for i=1:d,
    I1=I(:,:,:,i);
    % Convert to gray scale
    I1 = rgb2gray(I1);
    % Convert to double
    I1=im2double(I1);
    I2(:,:,i) = I1;
    % Normalization
    I2(:,:,i)=Normalization(I2(:,:,i));
    imagesc(I1(:,:,:)),axis image, colormap gray;
end

% Selection of the area of interest
title('Dar click en la región de interés')
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
[I_f,SNR,PSNR,q]= diffusion_DICOM(I2, vert);
figure,
for i=1:d
subplot(1,2,1); imagesc(I2(:,:,i)),axis image, colormap gray; title('Original image');
subplot(1,2,2); imagesc(I_f(:,:,i)),axis image, colormap gray; title('Filtered image');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%   EXAMPLE 2   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The function requires at least inputs 'A' (noisy image) and 'vert' to operate.
%%% In this case,the template size is 4-N and the stopping criterion is
%%% apply
% Example: 
[I_f1,SNR1,PSNR1,q1]= diffusion_DICOM(I2, vert,1,[]);
figure,
for i=1:d
subplot(1,2,1); imagesc(I2(:,:,i)),axis image, colormap gray; title('Original image');
subplot(1,2,2); imagesc(I_f1(:,:,i)),axis image, colormap gray; title('Filtered image');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%   EXAMPLE 3   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The function requires at least inputs 'A' (noisy image) and 'vert' to operate.
%%% In this case,the template size is 12-N and the iterations number is
%%% chosen
% Example: 
[I_f2,SNR2,PSNR2,q2]= diffusion_DICOM(I2, vert,[],15);
figure,
for i=1:d
subplot(1,2,1); imagesc(I2(:,:,i)),axis image, colormap gray; title('Original image');
subplot(1,2,2); imagesc(I_f2(:,:,i)),axis image, colormap gray; title('Filtered image');
end