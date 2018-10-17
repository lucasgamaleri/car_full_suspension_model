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

KA = [Car.KA1 , Car.KA2 , Car.KA3 , Car.KA4];
KB = [Car.KB1 , Car.KB2 , Car.KB3 , Car.KB4];
mcar = Car.m;
m = [Car.m1, Car.m2, Car.m3 , Car.m4];
bAA = [Car.bA1 , Car.bA2 , Car.bA3 , Car.bA4];
a = Car.a;
b = Car.b;
Ix = Car.Ix;
Iy = Car.Iy;
W = Car.W;

%% Matrices de coeficientes


 kA= KA(1) ; % N/m
 kB= KA(3) ; % N/m
 kN1= KB(1)*0.1 ; % N/m
 kN2= KB(3); % N/m
 bA= bAA(1) ; % Ns/m
 bB= bAA(2) ; % Ns/m
 ms= mcar ; % kg masa suspendida + masa persona
 mu= m(1); % kg


A= [0  0  0  0  1  0  0  0  
    0  0  0  0  0  1  0  0
    0  0  0  0  0  0  1  0
    0  0  0  0  0  0  0  1
    (-kA-kB)/ms kA/ms kB/ms (kA*a-kB*b)/ms (-bA-bB)/ms bA/ms bB/ms (bA*a-bB*b)/ms 
    kA/mu (-kA-kN1)/mu 0 (-kA*a)/mu bA/mu -bA/mu 0 -(a*bA)/mu 
    kB/mu 0 (-kB-kN2)/mu kB*b/mu bB/mu 0 -bB/mu (b*bB)/mu
    (a*kA-b*kB)/Iy -(a*kA)/Iy (b*kB)/Iy (-a^2*kA-b^2*kB)/Iy (a*bA-b*bB)/Iy -(a*bA)/Iy (b*bB)/Iy (-a^2*bA-b^2*bB)/Iy]; 
 


B= [0  0  0  0         
    0  0  0  0  
    0  0  0  0  
    0  0  0  0
    0  0  0  0 
    kN1  0  0  0
    0  kN2  0  0
    0  0  0  0]; 

%C=[1 W 0 0 1 0 0 0 ; 1 0 b 0 1 0 0 0]; 
C = [1 W 0 0 1 0 0 0];
D=0; 

S=ss(A,B,C,D); %space state 
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
subplot(221) ; plot(T,X(:,1)) ; xlabel('t seg') ; 
subplot(222) ; plot(T,X(:,2)) ; xlabel('t seg') ; 
subplot(223) ; plot(t,x(:,1)) ; xlabel('t seg') ; 
subplot(224) ; plot(t,x(:,2)) ; xlabel('t seg') ; 
grid on

