from Car import *
import numpy as np

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

KA = (K1,K2);
KB = (KB1,KB2);
mcar = m;
mt = (m1,m2);
bA = (b1,b2);

## Simplificación de términos

k1= KA[0]*0.1; # Kgf/m
k2= KA[1]*0.1; # Kgf/m
kB1= KB[0]*0.1;# Kgf/m
kB2= KB[1]*0.1;# Kgf/m
b1= bA[0]*0.1; # Kgf*s/m
b2= bA[1]*0.1; # Kgf*s/m
ms= mcar + 70; # kg masa suspendida + masa persona
mu= mt[0];     # kg

## Matrices de coeficientes (términos simplificados)

M = np.matrix([[ms,0,0,0],[0,Ix,0,0],[0,0,mu,0],[0,0,0,mu]]) #Matriz masa
print("M =")
print(M)

K = np.matrix([[k1+k2,-k1*a+k2*b,-k1,-k2],[-a*k1+b*k2,a**2*k1+b**2*k2,a*k1,b*k2],[-k1,a*k1,k1+kB1,0],[-k2,b*k2,0,k2+kB2]])
print("K =")
print(K)


Bb = np.matrix([[b1+b2 , -b1*a + b2*b , -b1 , -b2],
    [-a*b1 + b*b2 , a**2 * b1 + b**2 * b2 , a*b1 , b*b2],
    [-b1 , a*b1 , b1 , 0],
    [-b2,b*b2,0,k2]])
print("Bb =")
print(Bb)

H = np.matrix([[0 , 0],[0 , 0],[-kB1 , 0],[0 ,-kB2]])
print("H =")
print(H)

## Función de transferencia Conductor C1, Baul C2

print("transfer function/n A = ")
#AUN FALTA TRADUCIR LA MATRIZ A = np.matrix([[np.zeros(shape=K.shape) , np.eye(Bb.shape[0],Bb.shape[1])],[-M\K , -M\Bb]])

#B = [zeros(size(H)) ; -M\H];

#C1=[0 0 0 0 1 0 0 0]; 
#C2 = [0 0 0 0 1 b 0 0];

#D_dim = [size(B);size(C1)];
#D = zeros(D_dim(2,1),D_dim(1,2));
