classdef Car
    % Car data
    % Parámetros másicos y coeficientes
    properties (Constant)

        KA1 = 14900; %Rigidez suspensión delantera izquierda N/m
        KA2 = 14900; %Rigidez suspensión delantera derecha N/m
        KA3 = 14900; %Rigidez suspensión trasera izquierda N/m
        KA4 = 14900; %Rigidez suspensión traesra derecha N/m
        KB1 = 150000; %Rigidez de la cubierta delantera izquierda N/m
        KB2 = 150000; %Rigidez de la cubierta delantera derecha N/m
        KB3 = 150000; %Rigidez de la cubierta trasera izquierda N/m
        KB4 = 150000; %Rigidez de la cubierta trasera derecha N/m
        m = 2100 ; %Masa suspendida del vehículo N
        m1 = 2; %Masa de la rueda delantera izquierda N
        m2 = 2; %Masa de la rueda delantera derecha N
        m3 = 2; %Masa de la rueda trasera izquierda N
        m4 = 2; %Masa de la rueda trasera derecha N
        bA1 = 475 ; %Amortiguación suspensión delantera izquierda N*s/m
        bA2 = 475; %Amortiguación suspensión delantera derecha N*s/m
        bA3 = 475; %Amortiguación suspensión trasera izquierda N*s/m
        bA4 = 475; %Amortiguación suspensión trasera derecha N*s/m
        a = 1.2 ; %Distancia CG al tren delantero m
        b = 2 ; %Distancia CG al tren trasero m
        Ix = 614 ; %Momento de inercia respecto a eje x Kg*m²
        Iy = 2760 ; %Momento de inercia respecto a eje y Kg*m²
        W = 1.6 ; %Distancia entre ejes m
    end
end