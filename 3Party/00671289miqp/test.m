%===============================================================================
% Title:       test.m                                                 
%                                                                       
% Project:     Hybrid Systems; development of a Mixed Integer Quadratic Program 
%              (MIQP) solver for Matlab 
%                                                                       
% Sub-Project: Development of a MIQP solver for Matlab                  
%                                                                       
% Purpose:     Test Problem						
%                                                                       
% Authors:     Alberto Bemporad   
%              Domenico Mignone  
%                                                                       
% History:     date         subject                                       
%                                                                       
%              2000.10.02   Initial Version                               
%
% Contact:     Alberto Bemporad
%              Automatic Control Laboratory
%              ETH Zentrum
%              Zurich, Switzerland
%              bemporad@aut.ee.ethz.ch
%
%              Domenico Mignone
%              Automatic Control Laboratory
%              ETH Zentrum
%              Zurich, Switzerland
%              mignone@aut.ee.ethz.ch
%
%              Comments and bug reports are highly appreciated
%                                    
%===============================================================================


Q	= eye(4,4);	    % MIQP
b	= [ 2, -3, -2, -3]';
C	= [-1  -1  -1  -1;
    10	5   3	4;
    -1	0   0	0];
d	= [-2  10   0]';
vlb  = [-1e10 0 0 0];
vub  = [ 1e10 1 1 1];
ivar = [ 2 3 4];
x0	= zeros(size(Q,1),1);

options = [];
options.integtol = 1e-6;
options.solver   = 'quadprog';


[xsol,fsol,flag,ef]=miqp(Q, b, C, d, [], [], ivar, vlb, vub, x0, options)
