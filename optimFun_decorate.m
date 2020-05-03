function [iterations, x, fval, output] = optimFun_decorate(options, fun_celu_holder, optimFun_handler, x0)
%% dekorator do wywoływania optymalizacji
    iterations.X = [];
    iterations.F = [];
    
    options.OutputFcn = @output_fun;
    
    [x, fval, ~, output] = optimFun_handler(fun_celu_holder, x0, options);
    
    %% wlasna funkcja output optymalizacji
    function stop = output_fun(x, optimValues, state)
        stop = false;

        switch state
            case 'iter'
                iterations.X = [iterations.X, x];
                iterations.F = [iterations.F, optimValues.fval];
            case 'interrupt'
                %nothing
            case 'init'
                %nothing
            case 'done'
                %nothing
            otherwise
        end
    end
end

