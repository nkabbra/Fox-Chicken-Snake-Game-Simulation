function [update] = saturate(dist,direction,threshold)
min = threshold(1);
max = threshold(2);

update = direction;

if dist==0
    update=zeros(1,dim);
end

if dist>max 
    update = max.*(direction)./dist;
end

if dist<min 
    update = min.*(direction)./dist;
end

end

