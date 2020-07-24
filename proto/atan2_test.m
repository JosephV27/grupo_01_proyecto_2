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
clc
clear

% Declare space for arrays
idx_array   = zeros(1,73);
cos_array   = zeros(1,73);
sin_array   = zeros(1,73);
theta_array = zeros(1,73);

    #archivo = fopen('Angulos.txt', 'w');
    
    for idx = 1 : 1 : 73
      idx_array(idx) = (idx-1) * 5 * pi / 180;
      cos_array(idx) = floor(cos(idx_array(idx)) * 4096);
      sin_array(idx) = floor(sin(idx_array(idx)) * 4096);
    
      theta_array(idx) = ac_atan2(cos_array(idx), sin_array(idx));
      
 
      #fprintf(archivo, "Angulo: %d theta: %d\n" , (idx-1) * 5, theta_array(idx));
      printf("Angulo: %d theta: %d\n" , (idx-1) * 5, theta_array(idx));
     
end

#fclose(archivo);

