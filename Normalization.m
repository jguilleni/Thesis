function [ A ] = Normalization( x )
%   Input: Image
%   Output: Image normalized

mx=max(x(:));
mn=min(x(:));
A=(x-mn)/(mx-mn);  
end

