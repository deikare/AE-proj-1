function fig = optimPointsPlotter(X, Y, Z, density, dotSize, X_optim, plottitle)
%% poziomicowy plotter funkcji celu wraz z punktami generowanymi przez
%% optymalizator
    fig = figure;
    
    contour(X, Y, Z, density);
    colormap default;
    hold on
    
    for i = 1 : size(X_optim, 1) - 1
        x = X_optim(i, 1);
        y = X_optim(i, 2);
        u = X_optim(i + 1, 1) - X_optim(i, 1);
        v = X_optim(i + 1, 2) - X_optim(i, 2);
        quiver(x, y, u, v, 0, 'black', 'filled');
        scatter(X_optim(i, 1), X_optim(i, 2), dotSize, 'red', 'filled');
    end
    scatter(X_optim(1, 1), X_optim(1, 2), dotSize + 20, 'green', 'filled');
%     scatter(X_optim(i, 1), X_optim(i, 2), dotSize + 20, 'black', 'filled');
    scatter(X_optim(end, 1), X_optim(end, 2), dotSize + 20, 'black', 'filled');

    
    xlabel('x');
    ylabel('y');
    title(plottitle);
    hold off
end

