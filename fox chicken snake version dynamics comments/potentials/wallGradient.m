function grad = wallGradient(p,x,envSize)
%wallGradient returns the gradient of the wall potential at point x with
%parameters p
dim=length(x);
len=length(p);
degree=floor((len+1)/2);
grad=zeros(1,dim);

for i=1:len
    for d=1:dim
        grad(d)=grad(d) - p(i)*(i-degree)*((x(d)-envSize(1,d))^(i-degree-1));
        grad(d)=grad(d) + p(i)*(i-degree)*((envSize(2,d)-x(d))^(i-degree-1));
    end
end
end

