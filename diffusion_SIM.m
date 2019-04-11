%%% Inputs: The noisy image A, the interest area (vert), the size of the
%%%         template (optional) and the number of iterations (optional). 
%%%         At least A and vert are required.
%%%         
%%% 
%%% Ouputs: The filtered image
%%% This filter is based in the algorithm proposed by Loizou and Pattichis
%%% (Despeckle filtering algorithms and software for ultrasound imaging (Algorithm 2.1), 2008).
% Credits:
% Javier E. Guillen I
% Universidad Tecnológica de Bolívar
% 2019

function [I,SNR,PSNR,q]=diffusion_SIM(A,vert,Temp,Niter)

[a,b]=size(A);
M=a;
N=b;

if nargin<1 || nargin>4
    error('Wrong number of arguments')
end

stop_c=false;

if nargin ==2 
   stop_c=true;
   Temp=1;
else
    if isempty(Niter)==1 
        stop_c=true;
    end
    if isempty(Temp)==1 
        Temp=1;
    end
end



iter=0;
stop=false;
SC=0.2;


while stop==false
    iter=iter+1;
        I=A(:,:);
        
        %Directions
        iN=[1,1:M-1]; %North
        iS=[2:M,M];   %South
        jW=[1,1:N-1]; %West
        jE=[2:N,N];   %East
        
        iN2=[1,1,1:M-2]; %North-North
        iS2=[3:M,M,M];   %South-South
        jW2=[1,1,1:N-2]; %West-West
        jE2=[3:N,N,N];   %East-East
    for j=1:iter 
        Iuniform = I(vert(1):vert(2),vert(3):vert(4)); %Speckle region in the image
        Ka=(std(Iuniform(:))/mean(Iuniform(:)))^2; %Noise estimator (1/SNR)^2
        
        if Temp == 1
            %Rate of diffusion
            lambda=1/12;
            %Directional gradients
            %First group
            dN=I(iN,:)-I;
            dS=I(iS,:)-I;
            dW=I(:,jW)-I;
            dE=I(:,jE)-I;

            %Second group
            dNE=(I(iN,jE)-I)/sqrt(2);
            dSW=(I(iS,jW)-I)/sqrt(2);
            dNW=(I(iN,jW)-I)/sqrt(2);
            dSE=(I(iS,jE)-I)/sqrt(2);

            %Third group
            dN2=(I(iN2,:)-I)/2;
            dS2=(I(iS2,:)-I)/2;
            dW2=(I(:,jW2)-I)/2;
            dE2=(I(:,jE2)-I)/2;

            % Use the scaled Perona-Malik conductance function
            cN=1./(1+(abs(dN)/Ka).^2);
            cS=1./(1+(abs(dS)/Ka).^2);
            cW=1./(1+(abs(dW)/Ka).^2);
            cE=1./(1+(abs(dE)/Ka).^2);

            cNE=1./(1+(abs(dNE)/Ka).^2);
            cSW=1./(1+(abs(dSW)/Ka).^2);
            cNW=1./(1+(abs(dNW)/Ka).^2);
            cSE=1./(1+(abs(dSE)/Ka).^2);

            cN2=1./(1+(abs(dN2)/Ka).^2);
            cS2=1./(1+(abs(dS2)/Ka).^2);
            cW2=1./(1+(abs(dW2)/Ka).^2);
            cE2=1./(1+(abs(dE2)/Ka).^2);
            
            delta1=(cN.*dN+cS.*dS+cW.*dW+cE.*dE);
            delta2=(cNE.*dNE+cSW.*dSW+cNW.*dNW+cSE.*dSE);
            delta3=(cN2.*dN2+cS2.*dS2+cW2.*dW2+cE2.*dE2);
        else
            %Rate of diffusion
            lambda=1/4;
            %Directional gradients
            %First group
            dN=I(iN,:)-I;
            dS=I(iS,:)-I;
            dW=I(:,jW)-I;
            dE=I(:,jE)-I;

            % Use the scaled Perona-Malik conductance function
            cN=1./(1+(abs(dN)/Ka).^2);
            cS=1./(1+(abs(dS)/Ka).^2);
            cW=1./(1+(abs(dW)/Ka).^2);
            cE=1./(1+(abs(dE)/Ka).^2);
            
            delta1=(cN.*dN+cS.*dS+cW.*dW+cE.*dE);
            delta2=0;
            delta3=0;
        end

delta=delta1+delta2+delta3;
I=I+lambda*delta;

% Relative variance
r(j)=var(I(vert(1):vert(2),vert(3):vert(4)))/var(A(vert(1):vert(2),vert(3):vert(4)));
% Metrics
[SNR(j),PSNR(j),q(j)] = Metrics(A,I,vert);
    end
      
% Stopping criteria - Relative variance
   
if stop_c==true
    if r(iter)<=SC
        stop=true;
        stime=iter;
    end
else
 if iter==Niter
     stop=true;
     stime=Niter;
 end
    
end

end

fprintf('%g Iterations performed.\n', stime)

end