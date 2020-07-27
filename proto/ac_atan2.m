% Instituto Tecnológico de Costa Rica
% Centro Académico Alajuela
% Esuela de Ingeniería en Computación
% IC-3101 Arquitectura de Computadores
% I Semestre 2020
% Prof.-Ing. Daniel Kohkemper, M.Sc.
%
% atan2 test file
% File: atan2_test.m
% Brief: Tests implementation of atan2 function
%
% Grupo 01
% Joseph Valenciano
% Erick Blanco
% Emmanuel Murillo
%Josue Chaves

function [theta, octant] = ac_atan2(x, y)

numerador = int32(x * y); #numerator operation

op1 = int32(bitshift ((y * y), -2)); #Q >> 2
op2 = int32(bitshift ((y * y), -5)); #Q >> 5

op_denoI = int32((x * x) + op1 + op2); #op in denominator with I^2
op_denoQ = int32((y * y) + op1 + op2); #op in denominator with Q^2 

denominadorI = int32(bitshift (op_denoI, -15));
denominadorQ = int32(bitshift (op_denoQ, -15));

resultadoI = int32(numerador / denominadorI); #result with denominator with I^2
resultadoQ = int32(numerador / denominadorQ); #result with denominator with Q^2 

pi_entero = int32(round(pi * 32768)); #pi Q(15)
pi_medios = int32(round((pi/2) * 32768)); #pi/2 Q(15)
pi_cuartos = int32(round((pi/4) * 32768)); #pi/4 Q(15)
tres_pi_cuartos = int32(round(((3*pi)/4) * 32768)); #(3*pi)/4 Q(15)

if x == 8192 && y == 0 #0 degrees
  theta = 0;
  octant = 0;
elseif  abs(x) > abs(y) && x > 0 && y > 0  #first octant
  theta = resultadoI;
  octant = 1;
elseif  abs(x) == abs(y) && x > 0 && y > 0 #45 degrees
  theta = pi_cuartos;
  octant = 0;
elseif  abs(x) < abs(y) && x > 0 && y > 0 #second octant
  theta = pi_medios - resultadoQ;
  octant = 2; 
elseif  x==0 && y>0 #90 degrees
  theta = pi_medios;
  octant = 0;
elseif  abs(x) < abs(y) && x<0 && y>0 #third octant  
  theta = pi_medios - resultadoQ;
  octant = 3;
elseif  abs(x) == abs(y) && x<0 && y>0 #135 degrees
  theta = tres_pi_cuartos;
  octant = 0;
elseif  abs(x) > abs(y) && x<0 && y>0 #fourth octant 
  theta = pi_entero + resultadoI;
  octant = 4;
elseif  abs(x) > abs(y) && x<0 && y<0 #fifth octant
  theta = resultadoI - pi_entero;
  octant = 5;
elseif  abs(x) == abs(y) && x<0 && y<0 #-135 degrees
  theta = -tres_pi_cuartos;
  octant = 0;
elseif  abs(x) < abs(y) && x<0 && y<0 #sixth octant
  theta = -pi_medios - resultadoQ;
  octant = 6;
elseif  x==0 && y<0 #-90 degrees
  theta = -pi_medios;
  octant = 0;
elseif  abs(x) < abs(y) && x>0 && y<0 #seventh octant
  theta = -pi_medios - resultadoQ;
  octant = 7;
elseif  abs(x) == abs(y) && x>0 && y<0 #-45 degrees
  theta = -pi_cuartos;
  octant = 0;
elseif  abs(x) > abs(y) && x>0 && y<0 #eighth octant
  theta = resultadoI;
  octant = 8;  
else
  theta = pi_entero; #180 degrees
  octant = 0;
endif

return;

end



