function [f, gradient, hessian] = fun_celu(x, a, b)
    f = (x(1) - 1 - a) ^ 2 + 100 * ((x(1) - a) ^ 2 - x(2) + b) ^ 2;
    
    gradient = [2 * (x(1) - 1 - a) + 400 * (x(1) - a) * ((x(1) - a) ^ 2 - x(2) + b); -200 * ((x(1) - a) ^ 2 - x(2) + b)];
    
    hessian(1,1) = 2 + 400 * (3 * (x(1) - a) ^ 2 - x(2) + b);
    hessian(1, 2) = -400 * (x(1) - a);
    hessian(2, 1) = hessian(1, 2);
    hessian(2, 2) = 200;
end


