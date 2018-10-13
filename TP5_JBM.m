clear; 
clc; 
clf; 

 kA= 75000 ; % N/m
 kB= 32000 ; % N/m
 kN1= 20000 ; % N/m
 kN2= 200000; % N/m
 bA= 875 ; % Ns/m
 bB= 875 ; % Ns/m
 a= 1.524 ; % m
 b= 1.156 ; % m
 W= 1.450/2 ; %m
 ms= 2160 + 100 ; % kg masa suspendida + masa persona
 mu= 78; % kg
 Ix= 946; % kg*m2 
 Iy= 4140 ; % kg*m2

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

C=[1 W 0 0 0 0 0 0]; 

D=0; 

S=ss(A,B,C,D); %space state 
Gt = tf(S); %transfer function 

s = tf([1 0],1);  
G1 = Gt(1);
G2 = Gt(2);
% G2r = Gt(2)*exp(-0.1*s);

ZZ=G1+G2
ZZ=minreal(ZZ)

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

plot(T,X)
grid on


