%% Correr directamente todo el código
% se obtendrá la matriz G y la función de transferencia al multiplicar G
% por un step
%% clear
clear
%% Parámetros
global KA
global KB
global mcar
global m
global bA
global a
global b
global Ix
global Iy
global W

KA = [Car.KA1 , Car.KA2 , Car.KA3 , Car.KA4];
KB = [Car.KB1 , Car.KB2 , Car.KB3 , Car.KB4];
mcar = Car.m;
m = [Car.m1, Car.m2, Car.m3 , Car.m4];
bA = [Car.bA1 , Car.bA2 , Car.bA3 , Car.bA4];
a = Car.a;
b = Car.b;
Ix = Car.Ix;
Iy = Car.Iy;
W = Car.W;

%% Matrices de coeficientes

M = [mcar Ix Iy m(1) m(2) m(3) m(4)].*eye(7); %Matriz masa

B11 = -(bA(1)+bA(2)+bA(3)+bA(4));
B12 = 2*W*(bA(2)-bA(1)+bA(4)-bA(3));
B13 = 2*(bA(1)+bA(2)-bA(3)-bA(4))*(a+b);
B14 = bA(1);
B15 = bA(2);
B16 = bA(3);
B17 = bA(4);
B21 = B12;
B22 = 2*W^2*(bA(4)-bA(3)-bA(2)+bA(1));
B23 = (bA(4)-bA(3)-bA(2)+bA(1))*(a+b);
B24 = bA(1);
B25 = -bA(2);
B26 = bA(3);
B27 = bA(4);
B31 = B13;
B32 = B23;
B33 = -a*(a+b)*(bA(1)+bA(2))+b*(a+b)*(bA(4)+bA(3));
B34 = -a*bA(1);
B35 = a*bA(2);
B36 = -b*bA(3);
B37 = -b*bA(4);
B41 = B14;
B42 = 2*W*B24;
B43 = (a+b)*B34;
B44 = -bA(1);

B51 = B15;
B52 = 2*W*B25;
B53 = (a+b)*B35;

B55 = -bA(2);

B61 = B16;
B62 = 2*W*B26;
B63 = (a+b)*B36;

B66 = -bA(3);

B71 = B17;
B72 = 2*W*B27;
B73 = (a+b)*B37;

B77 = -bA(4);








 B_ = [...
    B11 , B12 , B13 , B14 , B15 , B16 , B17 ; ...
    B21 , B22 , B23 , B24 , B25 , B26 , B27; ...
 	B31 , B32 , B33 , B34 , B35 , B36 , B37; ...
 	B41 , B42 , B43 , B44 , 0 , 0 , 0; ...
 	B51 , B52 , B53 , 0 , B55 , 0 , 0; ...
 	B61 , B62 , B63 , 0 , 0 , B66 , 0; ...
    B71 , B72 , B73 , 0 , 0 , 0 , B77];

K11 = -(KA(1)+KA(2)+KA(3)+KA(4));
K12 = 2*W*(KA(2)-KA(1)+KA(4)-KA(3));
K13 = 2*(KA(1)+KA(2)-KA(3)-KA(4))*(a+b);
K14 = KA(1);
K15 = KA(2);
K16 = KA(3);
K17 = KA(4);
K21 = K12;
K22 = 2*W^2*(KA(4)-KA(3)-KA(2)+KA(1));
K23 = (KA(4)-KA(3)-KA(2)+KA(1))*(a+b);
K24 = KA(1);
K25 = -KA(2);
K26 = KA(3);
K27 = KA(4);
K31 = K13;
K32 = K23;
K33 = -a*(a+b)*(KA(1)+KA(2))+b*(a+b)*(KA(4)+KA(3));
K34 = -a*KA(1);
K35 = a*KA(2);
K36 = -b*KA(3);
K37 = -b*KA(4);
K41 = K14;
K42 = 2*W*K24;
K43 = (a+b)*K34;
K44 = -KA(1);

K51 = K15;
K52 = 2*W*K25;
K53 = (a+b)*K35;

K55 = -KA(2);

K61 = K16;
K62 = 2*W*K26;
K63 = (a+b)*K36;

K66 = -KA(3);

K71 = K17;
K72 = 2*W*K27;
K73 = (a+b)*K37;

K77 = -KA(4);

K = [...
    K11 , K12 , K13 , K14 , K15 , K16 , K17 ; ...
    K21 , K22 , K23 , K24 , K25 , K26 , K27; ...
 	K31 , K32 , K33 , K34 , K35 , K36 , K37; ...
 	K41 , K42 , K43 , K44 , 0 , 0 , 0; ...
 	K51 , K52 , K53 , 0 , K55 , 0 , 0; ...
 	K61 , K62 , K63 , 0 , 0 , K66 , 0; ...
    K71 , K72 , K73 , 0 , 0 , 0 , K77];

H = [-KB.*eye(4); zeros(3,4)];

%% Función de entrada

A = [zeros(7), eye(7);M\K, M\B_];
B = [zeros(7,4); M\H];

%% Funcion de salida
C = [zeros(1,7), 1, W/4, 0, 0, 0, 0, 0 ; zeros(1,7), 1, 0, b, 0, 0, 0, 0]; %Salida del conductor/baúl

D = 0;

%% Creacion de espacio de estados y función de transferencia
syscond = ss(A,B,C,D); %Lectura: Conductor
G = tf(syscond);
% s = tf([1 0], 1);
% ZZ1 = minreal(G(1,1) + G(1,2) + G(1,3) + G(1,4)); %Conductor
% ZZ2 = minreal(G(2,1) + G(2,2) + G(2,3) + G(2,4)); %Baul
% 
% [y,t]=step(ZZ1,2); 
% 
% y=y*0.1;
% T=[t;t+t(end)];
% Y=[y;0.1-y];
% ZA=s^2*ZZ1
% 
% [x,t]=step(ZA,2); 
% 
% x=x*0.1;
% T=[t;t+t(end)];
% X=[x;0.1-y];
% 
% plot(T,X)
% grid on

zpk(G)
stepplot(G)
