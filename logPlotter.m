function fig = logPlotter(F, plottitle)
%% funkcja drukujaca logarytmiczny wykres wartosci funkcji celu
    fig = figure;
    semilogy(F);
    
    hold on
    xlabel('iteracje');
    ylabel('funkcja celu');
    title(plottitle);
end

