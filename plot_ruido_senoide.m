function f = plot_ruido_senoide(ts)

        s = sinusoidal_dist(ts);
        f = figure;
        plot(ts,s,'k:','LineWidth', 3,'DisplayName','reference'); hold off
   
        ylabel('Ruido');
        xlabel('Time (s)');
        %title('Sinusoidal Disturbance Signal')
        


end