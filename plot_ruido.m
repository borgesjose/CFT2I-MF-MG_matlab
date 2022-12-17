function f = plot_ruido(ts,ruido)

        s = ruido(1:size(ts,2));
        f = figure;
        plot(ts,s,'k:','LineWidth', 3,'DisplayName','reference'); hold off
   
        ylabel('Ruido');
        xlabel('Time (s)');
        title('Sinusoidal Disturbance Signal')
        
end