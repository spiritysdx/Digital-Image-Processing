function [y]=Gray_map(x,K)
temp = 0;
if x == 0
    y=temp;
else
    for i=1:(x-1)
    temp=temp+JND(i);
    end
    y=K*temp;
    if y > 255
        y=255;
    end
end
end