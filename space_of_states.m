%% Correr directamente todo el código
% se obtendrá la matriz G y la función de transferencia al multiplicar G
% por un step
%% clear
clear; clc
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
    M\K , M\Bb];

B = [zeros(size(H)) ; M\H];

%C=[0 0 0 0 1 0 0 0 ; 0 0 0 0 1 0 b 0]; 
C = [0 0 0 0 1 0 0 0];
D = 0;

S = ss(A,B,C,D); %space state 
Gt = tf(S); %transfer function 

s = tf([1 0],1);  
G1 = Gt(1,:);
G2 = Gt(2);
% G2r = Gt(2)*exp(-0.1*s);

ZZ=G1+G2;
ZZ=zpk(ZZ)

[y,t]=step(ZZ,2); 

y=y*0.1;
T=[t;t+t(end)];
Y=[y;0.1-y];

%plot(T,Y)
%grid on


s=tf('s')
s=s

ZA=s^2*ZZ

[x,t]=step(ZA,2); 

x=x*0.1;
T=[t;t+t(end)];
X=[x;0.1-y];

figure
subplot(121) ; plot(t,x(:,1)) ; xlabel('t seg') ; 
subplot(122) ; plot(t,x(:,2)) ; xlabel('t seg') ; 

grid on


