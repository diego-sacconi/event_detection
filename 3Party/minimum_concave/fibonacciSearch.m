% Matlab function m-file: fibinacciSearch.m
%
% Performs Fibonacci line search for minimising a
% unimodal function of one variable on the interval [a,b] to within
% a given tolerance 
%
% Created 25/2/2004, for use in 620-361: Operations Research and Algorithms
% Modify as you wish !
% 
% Input:  
%
% functionToMinimise     This should be a string which is the same as the
%                        name of the function m-file corresponding
%                        to the function that we wish to minimise.
%                        In particular, functionToMinimise should take a scalar input
%                        and return a scalar output.
%
% a, b                  Lower and upper limits of the initial search interval.
%                       Note:functionToMinimise should be unimodal on the interval [a,b]
%
% tolerance              Any positive number (typically ``small", eg: 0.01).
%                        The final interval produced by the Fibonacci search algorithm
%                        will have length 2*tolerance or less.  
%
%
% Output:
%
% xminEstimate         the midpoint of the final interval containing
%                      xmin produced by the Fibonacci search algorithm
%                           
% fminEstimate         the value of functionToMinimise at xminEstimate
%
% Input syntax example:
%
%   fibonacciSearch('f',0,1,0.01)
% 
% or alternatively
%
% fibonacciSearch(@f,0,1,0.01)
%
% where a function m-file called 
%
%    f.m      
%
% has been written (by you) and saved to the local working directory.



function [xminEstimate, fminEstimate] = fibonacciSearch(functionToMinimise, a, b, tolerance)

% Check that the correct number of input arguments have been passed to the
% function (this is not essential, but it helps to detect user error)

if (nargin ~= 4)     % in Matlab the operator ~= means "not equal to"
    error('four input arguments are required')
end

% Check that input parameters have appropriate values

    if(b <= a)
        error('b must be strictly greater than a')    
    end
    
    if(tolerance <= 0)
        error('tolerance must be strictly positive')
    end
    

% Step 1: Find smallest value of n such that (b-a)/fibonacciNumber(n) <= 2*tolerance,
% where fibonacciNumber(n) is the n^th number of the famous Fibonacci sequence

n = 0;
    
    while ( (b-a)/fibonacciNumber(n) >= 2*tolerance )
        n = n+1;
    end
    
% display the value of n which will be used for the search
%sprintf('using the first %d numbers of the fibonacci sequence',n) 

% Step 2: initialize coordinates p and q, then
% evaluate the function to minimise at p and q

p = b - (fibonacciNumber(n-1)/fibonacciNumber(n))*(b-a);
q = a + (fibonacciNumber(n-1)/fibonacciNumber(n))*(b-a);

fp = feval(functionToMinimise, p);
fq = feval(functionToMinimise, q);
f_calculations = 2;

% Step 3: perform repeated reductions of search interval using k as an
% iteration index

%[a,p,q,b]
%[fp, fq]
for k = n-1:-1:3
    
   f_calculations = f_calculations + 1;
   
    if (fp <= fq)
        
        b = q;
        q = p;
        fq = fp;    % given that we set q = p, we also need to set fq = fp
                    % this is one of the reasons why the Fibonacci search is ``efficient": 
                    % it re-uses the result of an f-calculation from the
                    % previous iteration.
                    
        p = b - (fibonacciNumber(k-1)/fibonacciNumber(k))*(b-a);  
        fp = feval(functionToMinimise, p);
        
        
    else    
        
        a = p;
        p = q;
        fp = fq;    % given that we set p = q, we also need to set fp = fq
        
        q = a + (fibonacciNumber(k-1)/fibonacciNumber(k))*(b-a);
        fq = feval(functionToMinimise, q);
        
    end
 %[a,p,q,b]
 %[fp, fq]
end

% At this stage, the current search interval has p and q dividing 
% the interval into equal thirds.  

% Step 4: in this step, the Fibonacci search algorithm reduces the search
% interval so that the inherited coordinate p or q
% is the midpoint, and the new coordinate lies a small distance to 
% one side of the midpoint

f_calculations = f_calculations + 1;

if (fp <= fq)
        
        b = q;
        q = p;
        fq = fp;
        
        p = b - 2*tolerance;
        fp = feval(functionToMinimise, p);
        
    else    % it must be true that fp > fq 
        
        a = p;
        p = q;
        fp = fq;
        
        q = a + 2*tolerance;
        fq = feval(functionToMinimise, q);
    end
   
% Step 5: In this final step, the Fibonacci search algorithm reduces the
% interval to length to either 
%       a) exactly 2*tolerance 
%       b) less than 2*tolerance - specifically, (original interval length)/F_n 


    if (fp <= fq)
        b = q;
    else
        a = p;
    end
   

% assign the output values of this function (as declared on line 30)

xminEstimate = (a+b)/2;                             % the midpoint of the final interval
fminEstimate = feval(functionToMinimise,xminEstimate);  

% Print out the endpoints of the final interval and the output values of
% the function (can be commented out)

%sprintf(' The minimum lies in the interval [%f, %f] \n xminEstimate = midpoint = %f \n fminEstimate %f',a,b,xminEstimate,fminEstimate)

%f_calculations;


