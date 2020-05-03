%% AE - projekt nr 1
%% Bartosz Goławski
%% nr albumu 293452
%% 14.04.2020

clear;
close all

const;

%% drukowanie wykresu funkcji f

fig = figure;
syms x y
fsurf(f_holder, [x_min, x_max, y_min, y_max], 'ShowContours', 'on');
hold on
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('wykres funkcji f');
hold off
saveas(fig, 'data/fun_celu.png');

options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'SpecifyObjectiveGradient', false);
optimFun_handler = @(fun_celu_holder, x0, options) fminunc(fun_celu_holder, x0, options);

%% bfgs no grad
i = 1;
for x0 = X_start'
    [iterations, x, fval, output] = optimFun_decorate(options, fun_celu_holder, optimFun_handler, x0);
    
    bfgs_no_grad(i).x0 = x0;
    bfgs_no_grad(i).x = x;
    bfgs_no_grad(i).fval = fval;
    bfgs_no_grad(i).error = error_holder(x, x_best);
    bfgs_no_grad(i).fCount = output.funcCount;
    bfgs_no_grad(i).iterCount = output.iterations;
    bfgs_no_grad(i).output = output;    
    bfgs_no_grad(i).iterations = iterations;
    
    plottitle = ['QN, bez gradientu, bfgs, x0 = [', num2str(x0(1)), ' ', num2str(x0(2)), ']'];
    name = ['bez_grad_bfgs_i=', num2str(i), '.png'];
    
    fig = logPlotter(iterations.F, plottitle);
    saveas(fig, ['data/log_', name]);
    fig = optimPointsPlotter(X, Y, Z, density, dotSize, (iterations.X)', plottitle);
    saveas(fig, ['data/2D_', name]);
    i = i + 1;
end

close all

%% bfgs grad

options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'SpecifyObjectiveGradient', true);
optimFun_handler = @(fun_celu_holder, x0, options) fminunc(fun_celu_holder, x0, options);

i = 1;
for x0 = X_start'
    [iterations, x, fval, output] = optimFun_decorate(options, fun_celu_holder, optimFun_handler, x0);
    
    bfgs_grad(i).x0 = x0;
    bfgs_grad(i).x = x;
    bfgs_grad(i).fval = fval;
    bfgs_grad(i).error = error_holder(x, x_best);
    bfgs_grad(i).fCount = output.funcCount;
    bfgs_grad(i).iterCount = output.iterations;
    bfgs_grad(i).output = output;    
    bfgs_grad(i).iterations = iterations;
    
    plottitle = ['QN, z gradientem, bfgs, x0 = [', num2str(x0(1)), ' ', num2str(x0(2)), ']'];
    name = ['z_grad_bfgs_i=', num2str(i), '.png'];
    
    fig = logPlotter(iterations.F, plottitle);
    saveas(fig, ['data/log_', name]);
    fig = optimPointsPlotter(X, Y, Z, density, dotSize, (iterations.X)', plottitle);
    saveas(fig, ['data/2D_', name]);
    i = i + 1;
end

close all


%% dfp no grad
options = optimoptions('fminunc', 'MaxFunctionEvaluations', 2000, 'MaxIterations', 2000, 'Algorithm', 'quasi-newton', 'SpecifyObjectiveGradient', false, 'HessUpdate', 'dfp');

i = 1;
for x0 = X_start'
    [iterations, x, fval, output] = optimFun_decorate(options, fun_celu_holder, optimFun_handler, x0);
    
    dfp_no_grad(i).x0 = x0;
    dfp_no_grad(i).x = x;
    dfp_no_grad(i).fval = fval;
    dfp_no_grad(i).error = error_holder(x, x_best);
    dfp_no_grad(i).fCount = output.funcCount;
    dfp_no_grad(i).iterCount = output.iterations;
    dfp_no_grad(i).output = output; 
    dfp_no_grad(i).iterations = iterations;

    
    plottitle = ['QN, bez gradientu, dfp, x0 = [', num2str(x0(1)), ' ', num2str(x0(2)), ']'];
    name = ['bez_grad_dfp_i=', num2str(i), '.png'];
    
    fig = logPlotter(iterations.F, plottitle);
    saveas(fig, ['data/log_', name]);
    fig = optimPointsPlotter(X, Y, Z, density, dotSize, (iterations.X)', plottitle);
    saveas(fig, ['data/2D_', name]);
    i = i + 1;
end

close all


%% dfp grad
options = optimoptions('fminunc', 'MaxFunctionEvaluations', 2000, 'MaxIterations', 2000, 'Algorithm', 'quasi-newton', 'SpecifyObjectiveGradient', true, 'HessUpdate', 'dfp');
optimFun_handler = @(fun_celu_holder, x0, options) fminunc(fun_celu_holder, x0, options);

i = 1;
for x0 = X_start'
    [iterations, x, fval, output] = optimFun_decorate(options, fun_celu_holder, optimFun_handler, x0);
    
    dfp_grad(i).x0 = x0;
    dfp_grad(i).x = x;
    dfp_grad(i).fval = fval;
    dfp_grad(i).error = error_holder(x, x_best);
    dfp_grad(i).fCount = output.funcCount;
    dfp_grad(i).iterCount = output.iterations;
    dfp_grad(i).output = output;  
    dfp_grad(i).iterations = iterations;
    
    
    plottitle = ['QN, z gradientem, dfp, x0 = [', num2str(x0(1)), ' ', num2str(x0(2)), ']'];
    name = ['z_grad_dfp_i=', num2str(i), '.png'];
    
    fig = logPlotter(iterations.F, plottitle);
    saveas(fig, ['data/log_', name]);
    fig = optimPointsPlotter(X, Y, Z, density, dotSize, (iterations.X)', plottitle);
    saveas(fig, ['data/2D_', name]);
    i = i + 1;
end

close all


%% steepdesc no grad
options = optimoptions('fminunc', 'MaxFunctionEvaluations', 2000, 'MaxIterations', 2000, 'Algorithm', 'quasi-newton', 'SpecifyObjectiveGradient', false, 'HessUpdate', 'steepdesc');

i = 1;
for x0 = X_start'
    [iterations, x, fval, output] = optimFun_decorate(options, fun_celu_holder, optimFun_handler, x0);
    
    steepdesc_no_grad(i).x0 = x0;
    steepdesc_no_grad(i).x = x;
    steepdesc_no_grad(i).fval = fval;
    steepdesc_no_grad(i).error = error_holder(x, x_best);
    steepdesc_no_grad(i).fCount = output.funcCount;
    steepdesc_no_grad(i).iterCount = output.iterations;
    steepdesc_no_grad(i).output = output;    
    steepdesc_no_grad(i).iterations = iterations;
    
    
    plottitle = ['QN, bez gradientu, steepdesc, x0 = [', num2str(x0(1)), ' ', num2str(x0(2)), ']'];
    name = ['bez_grad_steepdesc_i=', num2str(i), '.png'];
    
    fig = logPlotter(iterations.F, plottitle);
    saveas(fig, ['data/log_', name]);
    fig = optimPointsPlotter(X, Y, Z, density, dotSize, (iterations.X)', plottitle);
    saveas(fig, ['data/2D_', name]);
    i = i + 1;
end

close all


%% steepdesc grad
options = optimoptions('fminunc', 'MaxFunctionEvaluations', 2000, 'MaxIterations', 2000, 'Algorithm', 'quasi-newton', 'SpecifyObjectiveGradient', true, 'HessUpdate', 'steepdesc');
optimFun_handler = @(fun_celu_holder, x0, options) fminunc(fun_celu_holder, x0, options);

i = 1;
for x0 = X_start'
    [iterations, x, fval, output] = optimFun_decorate(options, fun_celu_holder, optimFun_handler, x0);
    
    steepdesc_grad(i).x0 = x0;
    steepdesc_grad(i).x = x;
    steepdesc_grad(i).fval = fval;
    steepdesc_grad(i).error = error_holder(x, x_best);
    steepdesc_grad(i).fCount = output.funcCount;
    steepdesc_grad(i).iterCount = output.iterations;
    steepdesc_grad(i).output = output;   
    steepdesc_grad(i).iterations = iterations;
    
    
    plottitle = ['QN, z gradientem, steepdesc, x0 = [', num2str(x0(1)), ' ', num2str(x0(2)), ']'];
    name = ['z_grad_steepdesc_i=', num2str(i), '.png'];
    
    fig = logPlotter(iterations.F, plottitle);
    saveas(fig, ['data/log_', name]);
    fig = optimPointsPlotter(X, Y, Z, density, dotSize, (iterations.X)', plottitle);
    saveas(fig, ['data/2D_', name]);
    i = i + 1;
end

close all


%% zwiekszenie zasiegu, by pokazać TR
y_max = 2.5;

Y = y_min : 0.01: y_max;

Z = zeros(length(Y), length(X));

for i = 1 : length(X)
    for j = 1 : length(Y)
        Z(j, i) = fun_celu_holder([Y(j), X(i)]);
    end
end

%% trust-region no hess
options = optimoptions('fminunc', 'Algorithm', 'trust-region', 'SpecifyObjectiveGradient', true);
optimFun_handler = @(fun_celu_holder, x0, options) fminunc(fun_celu_holder, x0, options);

i = 1;
for x0 = X_start'
    [iterations, x, fval, output] = optimFun_decorate(options, fun_celu_holder, optimFun_handler, x0);
    
    trust_no_hess(i).x0 = x0;
    trust_no_hess(i).x = x;
    trust_no_hess(i).fval = fval;
    trust_no_hess(i).error = error_holder(x, x_best);
    trust_no_hess(i).fCount = output.funcCount;
    trust_no_hess(i).iterCount = output.iterations;
    trust_no_hess(i).output = output;    
    trust_no_hess(i).iterations = iterations;
    
    plottitle = ['trust-region, bez hesjanu, x0 = [', num2str(x0(1)), ' ', num2str(x0(2)), ']'];
    name = ['TR_bez_hesjanu_i=', num2str(i), '.png'];
    
    fig = logPlotter(iterations.F, plottitle);
    saveas(fig, ['data/log_', name]);
    fig = optimPointsPlotter(X, Y, Z, density, dotSize, (iterations.X)', plottitle);
    saveas(fig, ['data/2D_', name]);
    i = i + 1;
end

close all

%% trust-region with hess
options = optimoptions('fminunc', 'Algorithm', 'trust-region', 'SpecifyObjectiveGradient', true, 'HessianFcn', 'objective');
optimFun_handler = @(fun_celu_holder, x0, options) fminunc(fun_celu_holder, x0, options);

i = 1;
for x0 = X_start'
    [iterations, x, fval, output] = optimFun_decorate(options, fun_celu_holder, optimFun_handler, x0);
    
    trust_hess(i).x0 = x0;
    trust_hess(i).x = x;
    trust_hess(i).fval = fval;
    trust_hess(i).error = error_holder(x, x_best);
    trust_hess(i).fCount = output.funcCount;
    trust_hess(i).iterCount = output.iterations;
    trust_hess(i).output = output;    
    trust_hess(i).iterations = iterations;
    
    plottitle = ['trust-region, z hesjanem, x0 = [', num2str(x0(1)), ' ', num2str(x0(2)), ']'];
    name = ['TR_z_hesjanem_i=', num2str(i), '.png'];
    
    fig = logPlotter(iterations.F, plottitle);
    saveas(fig, ['data/log_', name]);
    fig = optimPointsPlotter(X, Y, Z, density, dotSize, (iterations.X)', plottitle);
    saveas(fig, ['data/2D_', name]);
    i = i + 1;
end

close all


