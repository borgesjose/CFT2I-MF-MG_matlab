function dh_dt = tank_conical(t,y,Qin,tank)
    % calculate derivative of the Level
    
    g  = 9.81;
    H  = tank.H; % Altura
    R1 = tank.R1; % Raio em metros
    R2 = tank.R2; % Raio da base do cilindro
    Cd = tank.Cd;
    A  = tank.A;
    
    b = A*Cd*sqrt(2*g);

    dh_dt = (Qin - b*y^(1/2))/(R2 + ((R1-R2)/H)*y)^(2);
end