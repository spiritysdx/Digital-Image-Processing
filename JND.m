function [X]=JND(x)
if x > 47 && x <= 255
    X = 2.1298-0.01376*x+4.851*(10^(-5))*x^2;
else
    X = 22.9818*exp(-0.0571*x);
end
end

