
% INITALISATION
clear;
cs = 3;                           % case 1, 2, 3 or 4 (s. below)
phases = 3;                       % connectes phases, 1, 2 or 3
T = 5;                            % timeintervals 

% initialisation cps_element
cps_element         = prototype_cpsstruct();
cps_element.pmax    = [22/3, 22/3, 22/3];
%cps_element.pmax    = [22/2, 22/2, 0];
%cps_element.pmax    = [22,0,0];

% initialisation cpsuse_element
cpsuse_element      = prototype_cpsusestruct();
cpsuse_element.wmax = cps_element.wmax =  40;           % max. energy  
cps_element.eta     = [0.9,1,1];

switch cs

    
  % continous mode, enough time
  case 1
    cps_element.w       = 10;       % initial energy
    cpsuse_element.mode = 'KontL';  % max. charging
    cpsuse_element.t0   = 100;        % starting with first timeinterval 1 = t0/100 + 1 
    cpsuse_element.tT   = 400;      % ending with third timeinterval 3 = tT/100      
   % continous mode, not enough time
    
  % continous mode, not enough time
  case 2
    cps_element.w       = 10;       % initial energy
    cpsuse_element.mode = 'KontL';  % max. charging
    cpsuse_element.t0   = 100;        % starting with first timeinterval 1 = t0/100 + 1 
    cpsuse_element.tT   = 200;      % ending with third timeinterval 3 = tT/100      
   % continous mode, not enough time
    
  % sofort (maximal) mode, enough time
  case 3
    cps_element.w       = 10;       % initial energy
    cpsuse_element.mode = 'SofoL';  % max. charging
    cpsuse_element.t0   = 100;        % starting with first timeinterval 1 = t0/100 + 1 
    cpsuse_element.tT   = 400;      % ending with third timeinterval 3 = tT/100      
   % continous mode, not enough time

  % sofort (maximal) mode, not enough time
  case 4
    cps_element.w       = 10;       % initial energy
    cpsuse_element.mode = 'SofoL';  % max. charging
    cpsuse_element.t0   = 100;        % starting with first timeinterval 1 = t0/100 + 1 
    cpsuse_element.tT   = 200;      % ending with third timeinterval 3 = tT/100      
   % continous mode, not enough time
       
endswitch


% TESTING
for t = 1:T
  pn{t} = nominalpowerget(cps_element,cpsuse_element,t) % nominal charging power
  pnsum{t} = sum(pn{t});
  cps_element.w         = cps_element.w + cps_element.eta(1)*sum(pn{t}); % charge battery
  w{t} = cps_element.w;
endfor  

