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

#constants
PI = 102944; #pi Q(15)
PI_MEDIOS = 51472; #pi/2 Q(15)
PI_CUARTOS = 25736; #pi/4 Q(15)
TRES_PI_CUARTOS = 77208; #(3*pi)/4 Q(15)


numerator = int32(x * y); #numerator operation

y_square = y * y;
x_square = x * x; 

op1 = int32(bitshift ((y_square), -2)); #Q >> 2
op2 = int32(bitshift ((y_square), -5)); #Q >> 5

op_denoI = int32((x_square) + op1 + op2); #op in denominator with I^2
op_denoQ = int32((y_square) + op1 + op2); #op in denominator with Q^2 

denominatorI = int32(bitshift (op_denoI, -15));
denominatorQ = int32(bitshift (op_denoQ, -15));

abs_x = abs(x); #Absolute value of x
abs_y = abs(y); #Absolute value of y


if x>0 && y == 0 #0 degrees
  theta = 0;
  octant = 0;
elseif  abs_x > abs_y && x > 0 && y > 0  #first octant
  theta = numerator / denominatorI;;
  octant = 1;
elseif  abs_x == abs_y && x > 0 && y > 0 #45 degrees
  theta = PI_CUARTOS;
  octant = 0;
elseif  abs_x < abs_y && x > 0 && y > 0 #second octant
  theta = PI_MEDIOS - (numerator / denominatorQ);
  octant = 2; 
elseif  x==0 && y>0 #90 degrees
  theta = PI_MEDIOS;
  octant = 0;
elseif  abs_x < abs_y && x<0 && y>0 #third octant  
  theta = PI_MEDIOS - (numerator / denominatorQ);
  octant = 3;
elseif  abs_x == abs_y && x<0 && y>0 #135 degrees
  theta = TRES_PI_CUARTOS;
  octant = 0;
elseif  abs_x > abs_y && x<0 && y>0 #fourth octant 
  theta = PI + (numerator / denominatorI);
  octant = 4;
elseif  abs_x > abs_y && x<0 && y<0 #fifth octant
  theta = (numerator / denominatorI) - PI;
  octant = 5;
elseif  abs_x == abs_y && x<0 && y<0 #-135 degrees
  theta = -TRES_PI_CUARTOS;
  octant = 0;
elseif  abs_x < abs_y && x<0 && y<0 #sixth octant
  theta = -PI_MEDIOS - (numerator / denominatorQ);
  octant = 6;
elseif  x==0 && y<0 #-90 degrees
  theta = -PI_MEDIOS;
  octant = 0;
elseif  abs_x < abs_y && x>0 && y<0 #seventh octant
  theta = -PI_MEDIOS - (numerator / denominatorQ);
  octant = 7;
elseif  abs_x == abs_y && x>0 && y<0 #-45 degrees
  theta = -PI_CUARTOS;
  octant = 0;
elseif  abs_x > abs_y && x>0 && y<0 #eighth octant
  theta = numerator / denominatorI;
  octant = 8;  
else
  theta = PI; #180 degrees
  octant = 0;
endif

return;

end



