function grad = expGradient(param_exp, x, y)
%y is fixed
Dim=length(x);
grad = zeros(1,Dim);
K = param_exp(1);
alpha = param_exp(2);
if x~=y
    grad = grad + -K*alpha*(x-y)*exp(-alpha*norm(x-y))/norm(x-y);
    grad = grad + -(x-y)*(norm(x-y)^(-3));
end
end