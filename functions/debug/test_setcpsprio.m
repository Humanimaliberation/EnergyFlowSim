% Initialisation
clear;
addpath(genpath('/home/humanimaliberation/Dropbox/Bachelorarbeit_Energieverbundinsel/Testumgebung/m_code_energyflowsim/'));  

%for i = 1:4
%  cps{i} = prototype_cpsstruct();
%endfor  
cps{1}.id = 'LP1';
cps{1}.prio = 0;
cps{2}.id = 'LP2';
cps{2}.prio = 0;
cps{3}.id = 'LP3';
cps{3}.prio = 0;
cps{4}.id = 'LP4';
cps{4}.prio = 0;
cps{5}.id = 'PB';
cps{5}.prio = 0;

idxcps = [1:length(cps)];

%t = 5;
T = 10;

%cpsuse{1} = prototype_cpsusestruct();
cpsuse{1}.id = 'LP1';
cpsuse{1}.mode = 'SofoL';
cpsuse{1}.t0 = 100; %start time 01:00 am
cpsuse{1}.tT = 300; %end time 03:00 am

%cpsuse{2} = prototype_cpsusestruct();
cpsuse{2}.id = 'LP1';
cpsuse{2}.mode = 'KontL';
cpsuse{2}.t0 = 300; %start time 03:00 am
cpsuse{2}.tT = 500; %end time 05:00 am

%cpsuse{3} = prototype_cpsusestruct();
cpsuse{3}.id = 'LP2';
cpsuse{3}.mode = 'SofoL';
cpsuse{3}.t0 = 400; %start time 00:00 am
cpsuse{3}.tT = 800; %end time 03:00 am

%cpsuse{4} = prototype_cpsusestruct();
cpsuse{4}.id = 'LP3';
cpsuse{4}.mode = 'FlexL';
cpsuse{4}.t0 = 500; %start time 05:00 am
cpsuse{4}.tT = 800; %end time 08:00 am

%cpsuse{5} = prototype_cpsusestruct();
cpsuse{5}.id = 'LP4';
cpsuse{5}.mode = 'FlexL';
cpsuse{5}.t0 = 00; %start time 00:00 am
cpsuse{5}.tT = 600; %end time 06:00 am

%cpsuse{6} = prototype_cpsusestruct();
cpsuse{6}.id = 'PB';
cpsuse{6}.mode = 'PB';
cpsuse{6}.t0 = 00; %start time 00:00 am
cpsuse{6}.tT = 600; %end time 06:00 am

% priolist = {1, 'PB'; 2, 'FlexL'; 3, 'KontL'; 3, 'SofoL'}; % {priority, mode; ...} whereas CPS with a higher priority are less likely to be regulated

for i = 1:5
  priolist{i} = prototype_prioliststruct();
endfor

priolist{1}.mode = 'PB';
priolist{1}.prio = 1;
priolist{2}.mode = 'FlexL';
priolist{2}.prio = 2;
priolist{3}.mode = 'KontL';
priolist{3}.prio = 3;
priolist{4}.mode = 'SofoL';
priolist{4}.prio = 3;
priolist{5}.mode = 'inactive';
priolist{5}.prio = 0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Testing
for t = [1:T]
  % set priorites
  cpsnew = setcpsprio (cps, idxcps, cpsuse, priolist, t);
  
  % log priorites
  for m = [1:length(cps)]
    log.cps.prio(t,m) = cpsnew{m}.prio;
  endfor

endfor
  
% Display results
usrprmpt = input('Display Data:');
disp('Initial values:\n');
disp(cps);
disp('Priolist:\n');
disp(priolist);
disp('Values after applying setcpsprio.m');
disp(structarrfield2cellarr (cps,'id'));
disp(log.cps.prio);

