% Matlab function m-file: fibonacciNumber.m
%
% input: positive integer n
% output: the n^th number of the Fibonacci sequence

function number = fibonacciNumber(n)

u = sqrt(5);
number = (1/u)*( ((1+u)/2)^(n+1) - ((1-u)/2)^(n+1) ); 
