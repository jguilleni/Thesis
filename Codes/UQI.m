    function [ q ] = UQI( A,B )

[J,I]=size(A);

% Original image
x_bar=mean(A(:));
sigma_x=std(A(:));

% Filtered image
y_bar=mean(B(:));
sigma_y=std(B(:));

sigma_xy=sum(sum(((A-x_bar).*(B-y_bar))))/((J*I)-1);

%Universal quality index
t1=sigma_xy/(sigma_x*sigma_y);
t2=(2*x_bar*y_bar)/((x_bar)^2+(y_bar)^2);
t3=(2*sigma_x*sigma_y)/((sigma_x)^2+(sigma_y)^2);


q=t1*t2*t3;
end

