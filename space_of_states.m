%% INSTRUCCIONES DE USO
% 1. Correr el programa, se cargarán todos los datos al workspace
% 2. Escriba ZZ(1) en la ventana de comandos para visualizar las funciones de
%       transferencia para el conductor tras un step
% 3. Escriba ZZ(2) en la ventana de comandos para visualizar las funciones
% de transferencia para el baúl tras un step
% 4. Escriba ZA(1) para visualizar la VELOCIDAD del conductor tras un step
% 5. Escriba ZB(2) para visualizar la VELOCIDAD del baúl tras un step
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

KA = [Car.K1 , Car.K2];
KB = [Car.KB1 , Car.KB2];
mcar = Car.m;
m = [Car.m1, Car.m2];
bA = [Car.b1 , Car.b2];
a = Car.a;
b = Car.b;
Ix = Car.Ix;
Iy = Car.Iy;
W = Car.W;

%% Matrices de coeficientes (términos simplificados)


 k1= KA(1)*0.1; % Kgf/m
 k2= KA(2)*0.1 ; % Kgf/m
 kB1= KB(1)*0.1 ; % Kgf/m
 kB2= KB(2)*0.1; % Kgf/m
 b1= bA(1)*0.1 ; % Kgf*s/m
 b2= bA(2)*0.1 ; % Kgf*s/m
 ms= mcar + 70 ; % kg masa suspendida + masa persona
 mu= m(1); % kg

M = [ms 0 0 0 ; 0 Ix 0 0 ; 0 0 mu 0 ; 0 0 0 mu];

K = [k1+k2 , -k1*a + k2*b , -k1 , -k2; ...
    -a*k1 + b*k2 , a^2 * k1 + b^2 *k2 , a*k1 , b*k2 ; ...
    -k1 , a*k1 , k1 + kB1 , 0; ...
    -k2 , b*k2 , 0 , k2 + kB2];
 


Bb = [b1+b2 , -b1*a + b2*b , -b1 , -b2; ...
    -a*b1 + b*b2 , a^2 * b1 + b^2 *b2 , a*b1 , b*b2 ; ...
    -b1 , a*b1 , b1 , 0; ...
    -b2 , b*b2 , 0 , k2];

H = [0 , 0 ; 0 , 0 ; -kB1 , 0 ; 0 ,-kB2];

%% Función de transferencia

A = [zeros(size(K)) , eye(size(Bb)); ...
    -M\K , -M\Bb];

B = [zeros(size(H)) ; -M\H];

C=[0 0 0 0 1 0 0 0 ; 0 0 0 0 1 b 0 0]; 
%C = [0 0 0 0 1 0 0 0];
d_dim = [size(B);size(C)];
D = zeros(d_dim(2,1),d_dim(1,2));

S = ss(A,B,C,D); %space state 
Gt = tf(S); %transfer function 

s = tf([1 0],1); %h = tf([1 0],1) specifies the pure derivative h(s) = s 
G1 = Gt(1,:);
G2 = Gt(2,:);
% G2r = Gt(1,:)*exp(-0.1*s);

ZZ=G1+G2; %Transfer function as a sum of every input variable
ZZ=zpk(ZZ); %Zero/pole/gain model

Tfinal = 2;
[y,t]=step(ZZ,Tfinal); 


y=y*0.1;
y_cond = y(:,:,1); % Driver output
y_trunk = y(:,:,2); % Trunk output
Ty=[t;t+t(end)];
Y_cond=[y_cond;0.1-y_cond];
Y_trunk=[y_trunk;0.1-y_trunk];


ZA=s^2*ZZ; %Derivada

[w,tw]=step(ZA,Tfinal); 

w=w*0.1;
w_cond = w(:,:,1); % Driver output
w_trunk = w(:,:,2); % Trunk output
Tw=[tw;tw+tw(end)];
W_cond=[w_cond;0.1-w_cond];
W_trunk=[w_trunk;0.1-w_trunk];


grid on

%% Representación

subplot(221) ; plot(Ty,Y_cond) ; title('Posición del conductor'); xlabel('t seg') ; ylabel('z m'); grid on
subplot(222) ; plot(Ty,Y_trunk) ; title('Posición del baul'); xlabel('t seg') ; ylabel('z m'); grid on
subplot(223) ; plot(Tw,W_cond) ; title('Velocidad del conductor'); xlabel('t seg') ; ylabel('w m/s'); grid on
subplot(224) ; plot(Tw,W_trunk) ; title('Velocidad del baul'); xlabel('t seg') ; ylabel('w m/s'); grid on