% Description: This is a Testfile for the function named in this filename after 'test_'
clear;
cs = 7; % case 

switch cs
case 1 % works
  % initialize starting conditions
  pdsm =        [-12,-9,-8];
  cps{1}.p =    [24,24,24];
  cps{2}.p =    [12,12,12];
  cps{1}.pmin = [0,0,0];
  cps{2}.pmin = [6,6,6];
  cps{1}.pmax = [24,24,24];
  cps{2}.pmax = [12,12,12];
  cps{1}.w    = 100;
  cps{2}.w    = 100;
  cps{2}.wmax = 200;
  cps{1}.wmax = 200;
  cps{1}.eta  = [1,1,1];
  cps{2}.eta  = [1,1,1];  
  
  cpsnew = dsmrel(cps, [1:2], pdsm);

case 2 % works
  % initialize starting conditions
  pdsm =        [-12,-9,-8];
  cps{1}.p =    [24,24,24]; % [-24,-24,-24] potential regulation
  cps{2}.p =    [12,0,0]; % [ -6, -6, -6] potential regulation
  cps{1}.pmin = [0,0,0];
  cps{2}.pmin = [6,0,0];
  cps{1}.pmax = [24,24,24];
  cps{2}.pmax = [12,0,0];
  cps{1}.w    = 100;
  cps{2}.w    = 100;
  cps{2}.wmax = 200;
  cps{1}.wmax = 200;
  cps{1}.eta  = [1,1,1];
  cps{2}.eta  = [1,1,1];  

  cpsnew = dsmrel(cps, [1:2], pdsm);

% not enough power regulation -> max. regulation
case 3 % works
  % initialize starting conditions
  pdsm =        [-24,-18,-12];
  cps{1}.p =    [0,0,0];
  cps{2}.p =    [12,12,12];
  cps{1}.pmin = [-6,-6,-6];
  cps{2}.pmin = [0,0,0];
  cps{1}.pmax = [6,6,6];
  cps{2}.pmax = [12,12,12];
  cps{1}.w    = 100;
  cps{2}.w    = 100;
  cps{2}.wmax = 200;
  cps{1}.wmax = 200;
  cps{1}.eta  = [1,1,1];
  cps{2}.eta  = [1,1,1];  

  cpsnew = dsmrel(cps, [1:2], pdsm);

% not enough power regulation -> max. regulation 
case 4 % works
  % initialize starting conditions
  pdsm =        [-100,-100,-100];
  cps{1}.p =    [24,24,24];
  cps{2}.p =    [12,12,12];
  cps{1}.pmin = [0,0,0];
  cps{2}.pmin = [0,0,0];
  cps{1}.pmax = [24,24,24];
  cps{2}.pmax = [12,12,12];
  cps{1}.w    = 100;
  cps{2}.w    = 100;
  cps{2}.wmax = 200;
  cps{1}.wmax = 200;
  cps{1}.eta  = [1,1,1];
  cps{2}.eta  = [1,1,1];  

  cpsnew = dsmrel(cps, [1:2], pdsm);  

case 5  
  % initialize starting conditions
  pdsm =        [-2,-0,-0];
  cps{1}.p =    [24,24,24];
  cps{2}.p =    [2,0,0];
  cps{1}.pmin = [0,0,0];
  cps{2}.pmin = [0,0,0];
  cps{1}.pmax = [24,24,24];
  cps{2}.pmax = [12,12,12];
  cps{1}.w    = 100;
  cps{2}.w    = 100;
  cps{2}.wmax = 200;
  cps{1}.wmax = 200;
  cps{1}.eta  = [1,1,1];
  cps{2}.eta  = [1,1,1];  

  cpsnew = dsmrel(cps, [1:2], pdsm);  

case 6  
  % initialize starting conditions
  pdsm =        [-6,-6,-6];
  cps{1}.p =    [24,24,24];
  cps{2}.p =    [0,0,0];
  cps{1}.pmin = [0,0,0];
  cps{2}.pmin = [-6,-6,-6];
  cps{1}.pmax = [24,24,24];
  cps{2}.pmax = [6,6,6];
  cps{1}.w    = 100;
  cps{2}.w    = 100;
  cps{2}.wmax = 200;
  cps{1}.wmax = 200;
  cps{1}.eta  = [1,1,1];
  cps{2}.eta  = [1,1,1];  

  cpsnew = dsmrel(cps, [2], pdsm);  
  
 case 7  
  % initialize starting conditions
  pdsm        = [0.1,0.1,0.1];
  cps{1}.p    = [0,0,0];
  cps{1}.pmin = [-5,-5,-5];
  cps{1}.pmax = [5,5,5];
  cps{1}.w    = 10;
  cps{1}.wmax = 20;
  cps{1}.eta  = [0.9,0.9,1];

  idxcps = 1;
  cpsnew = dsmrel(cps, idxcps, pdsm);  
  
endswitch

disp('show results with the command:');
disp('structarrfield2cellarr (cpsnew,"p")');
