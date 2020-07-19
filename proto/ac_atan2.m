% Instituto Tecnol�gico de Costa Rica
% Centro Acad�mico Alajuela
% Esuela de Ingenier�a en Computaci�n
% IC-3101 Arquitectura de Computadores
% I Semestre 2020
% Prof.-Ing. Daniel Kohkemper, M.Sc.
%
% arctan2 implementation file
% File:   ac_arctan2.m
% Brief:  Implementation of arctan2 function
% Input:  x coordinate, y coordinate of complex number
% Output: theta: angle of vector
%
% Grupo 01
%Joseph Valenciano
% Erick Blanco
% Emmanuel Murillo
%Josue Chaves 

function ac_arctan2(x, y)

  if x<0 && y>=0
    theta = arctan(x, y) + pi;
  elseif x<0 && y<0
    theta = arctan(x, y) - pi;
  elseif y>0 && x == 0
    theta = pi / 2;
  elseif y<0 && x == 0
    theta = -pi / 2;
  elseif x == 0 && y == 0
    theta = 0;
  else
    theta = arctan(x, y);
  endif
printf("%d", theta);
endfunction


function resultado = arctan(x, y)

  numerador = x * y;
  x_cuadrado = x * x;
  op1 = bitshift (x_cuadrado, -2);
  op2 = bitshift (x_cuadrado, -5);
  denominador = (y * y) + op1 + op2;
  resultado = numerador / denominador;
  return;
endfunction

ac_arctan2(3, 6);
