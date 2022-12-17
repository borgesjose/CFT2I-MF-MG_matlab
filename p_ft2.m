function [fig1,fig2,fig3,fig4] = p_ft2(ts,h,ref,u,tempo,Kp,Kd,Ki,Am)
        
        fig1 = figure;
        plot(ts,h,'-r','LineWidth', 3,'DisplayName','height'); hold on
        plot(ts,ref,'k:','LineWidth', 3,'DisplayName','reference'); hold off
        ylabel('Tank Height (m)');
        xlabel('Time (s)');
        title('FT2I-PID-FG: Resposta Tanque ')
        %saveas(fig1,['./figures/','FT1-PID-FG: Resposta Tanque','.png'])
        
        fig2 = figure;
        plot(ts,u,'k:','LineWidth', 3,'DisplayName','input'); hold off
        ylabel('Sinal de entrada m³/s');
        xlabel('Time (s)');
        legend();
        title('FT2I-PID-FG: Sinal de Controle')
        %saveas(fig2,['./figures/','FT1-PID-FG: Sinal de Controle','.png'])
        
        fig3 = figure;
        grid;
        plot(tempo,Kp,'g-');
        hold on;
        plot(tempo,Kd);
        hold on;
        plot(tempo,Ki);
        title('FT2I-PID-FG: Kp,Ki,Kd')
        legend('Kc','Kd','Ki')
        %saveas(fig3,['./figures/','FT1-PID-FG: Kp,Ki,Kd','.png'])

        fig4 = figure;
        grid;
        plot(tempo,Am,'g-');
        title('FT2I-PID-FG: Am')
        %saveas(fig4,['./figures/','FT1-PID-FG: Am','.png'])



end