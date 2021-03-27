function grad = basicGradient(p,x,y)
%y is fixed
Dim=length(x);
len = length(p);
degree = floor((len+1)/2);
grad = zeros(1,Dim);
if x~=y
    for i = 1:len
       grad=grad + p(i)*(i-degree)*(norm(x-y)^(i-degree-2))*(x-y);
    end
end
end