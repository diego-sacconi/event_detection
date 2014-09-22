%===============================================================================
% Title:       qphess.m                                                 
%                                                                       
% Project:     Hybrid Systems; development of a Mixed Integer Quadratic Program 
%              (MIQP) solver for Matlab 
%                                                                       
% Sub-Project: Development of a MIQP solver for Matlab                  
%                                                                       
% Purpose:     Auxiliary routine for the utilization of NAG Library     
%	       routines							
%                                                                       
% Authors:     Alberto Bemporad   
%              Domenico Mignone  
%                                                                       
% History:     date       subject                                       
%                                                                       
%              98.05.06   Initial Version                               
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

function [hx] = qphess(n,nrowh,ncolh,jthcol,hess,x)

   hx=hess*x;

