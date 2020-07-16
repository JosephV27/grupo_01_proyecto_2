% Instituto Tecnol�gico de Costa Rica
% Centro Acad�mico Alajuela
% Esuela de Ingenier�a en Computaci�n
% IC-3101 Arquitectura de Computadores
% I Semestre 2020
% Prof.-Ing. Daniel Kohkemper, M.Sc.
%
% atan2 implementation file
% File:   ac_atan2.m
% Brief:  Implementation of atan2 function
% Input:  x coordinate, y coordinate of complex number
% Output: theta: angle of vector
%
% Grupo 01
%Joseph Valenciano
% Erick Blanco
% Emmanuel Murillo
%

function ac_atan2(x, y)
division = y / x;

if x<0 && y>0
    theta = atan(division) + pi;
elseif x<0 && y<0
    theta = atan(division) - pi;
else
    theta = atan(division);
endif
printf("%d", theta);
endfunction

ac_atan2(-3,6);
