function [ SNR,PSNR,q ] = Metrics( O_image,E_image,vert)
% This function Metrics calculates various quality metrics

% INPUTS: O_Image = Original Image.
%         E_Image = Estimation of the original image obtained from a
%         noisy image after filtering it at n iteration.
%         vert = Area of interest of the original image.
% OUTPUT:
%         metrics = 
%                 Signal-to-Noise Ratio (SNR)
%                 Peak Signal-to-Noise Ratio (PSNR)
%                 Univeral quality index (Q)
%
%Credits:
% Javier E. Guillen I
% Universidad Tecnológica de Bolívar
% 2019


A=O_image(vert(1):vert(2),vert(3):vert(4));
B=E_image(vert(1):vert(2),vert(3):vert(4));
error(:,:)=A(:,:)-B(:,:);



[M,N]=size(O_image);
MX=max(A(:))^2;



% Metrics
% MSE
MSE=sum(sum(error(:,:).*error(:,:)))/(M*N);
% SNR
SNR=mean(B)/std(B);
% PSNR
PSNR=(-10)*log10(MSE/MX);
% Universal quality index
vert2 = [vert(1)-40,vert(2)+40,vert(3)-40,vert(4)+40];
C=O_image(vert2(1):vert2(2),vert2(3):vert2(4));
D=E_image(vert2(1):vert2(2),vert2(3):vert2(4));
q=UQI(C,D);
end

