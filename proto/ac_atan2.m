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

function theta = ac_atan2(x, y)
# convertir pi a Q(15) y tambien pi / 2
# que el programa verifique en que octante esta
# hacerlo todo en una funcion
#manejar en 32 bits

numerador = int32(x * y);
op1 = int32(bitshift ((y * y), -2));
op2 = int32(bitshift ((y * y), -5));
op_deno = int32((x * x) + op1 + op2);
denominador = int32(bitshift (op_deno, -15));
resultado = int32(numerador / denominador);

pi_entero = int32(round(pi * 32768));
pi_medios = int32(round((pi/2) * 32768));
pi_cuartos = int32(round((pi/4) * 32768));
tres_pi_cuartos = round(((3*pi)/4) * 32768);

  if x == 0 && y == 0 #angulo 0
    theta = 0;
  elseif x<0 y==0 #Angulo 180
    theta = pi_entero;
  elseif  x==0 && y>0 #angulo 90
    theta = pi_medios;  
  elseif  x==0 && y<0 #angulo -90
    theta = -pi_medios;
  elseif  abs(x) > abs(y) && x > 0 && y > 0  #primer octante 
    theta = resultado;
  elseif  abs(x) < abs(y) && x > 0 && y > 0 #segundo octante
    theta = -resultado; 
  elseif  abs(x) == abs(y) && x > 0 && y > 0 #angulo de 45
    theta = pi_cuartos; 
  elseif  x<0 && y>0 #tercer y cuarto octante  
    theta = -resultado + pi_entero;
  elseif  abs(x) == abs(y) && x<0 && y>0 #angulo de 135
    theta = tres_pi_cuartos;  
  elseif  x<0 && y<0 #quinto y sexto octante
    theta = -resultado - pi_entero;
  elseif  abs(x) == abs(y) && x<0 && y<0 #angulo de 225
    theta = -tres_pi_cuartos;
  elseif  abs(x) < abs(y) && x>0 && y<0 #setimo octante
    theta = -resultado;
  elseif  abs(x) > abs(y) && x>0 && y<0 #octavo octante
    theta = resultado;  
  elseif  abs(x) == abs(y) && x>0 && y<0 #angulo de 315
    theta = -pi_cuartos;
  else
    theta = 0;
  endif 
  
return;
end



