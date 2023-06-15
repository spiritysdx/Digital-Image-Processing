function [IMG]=normalise(img)
IMG=(img-mean(mean(img)))/std2(img);
end

