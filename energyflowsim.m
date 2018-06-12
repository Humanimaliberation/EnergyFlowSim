%==============================================================================%
%  LICENCE DISCLAIMER    
% 
%  This file is part of EnergyFlowSim.
% 
%  EnergyFlowSim is free software: you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published by
%  the Free Software Foundation, either version 3 of the License, or
%  (at your option) any later version.
% 
%  EnergyFlowSim is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
% 
%  You should have received a copy of the GNU General Public License
%  along with EnergyFlowSim.  If not, see <http://www.gnu.org/licenses/>.
%==============================================================================%
%  DESCRIPTION
% 
%  energyflow() simulates the energyflows of a partly autark charging infrastructure for electric 
%  vehicles (EV). Including:
%  - simulated physical components 
%  - - charging points (LP)
%  - - battery buffer (PB)
%  - - photovoltaic modules (PV),
%  - - conductors (link) 
%  - - nodes (node)
%  - energymanagement algorithm to:
%  - - maximize self-sufficiency level with battery buffer
%  - - configure charging sequences for charging points (LP)
%  - - apply demand side management (DSM) keeping loads within power transmission limits 
%==============================================================================%
%  GENERAL DECLERATIONS
%
%  CPS-Units (passive sign convention, dt. Verbraucherpfeilsystem)
%  p < 0 : produces energy
%  p > 0 : consumes energy
%==============================================================================%
%  INSTRUCTIONS
%
%  Settings for this simulations can be edited in the config files 'cfg_<name>.csv' 
%  in the subfolder 'data' of the current folder of this file
%
%  Configurations include configurations for:
%  - consumer-producer-storage-units (CPS-units) 
%  - usecases for CPS-units
%  - nodes
%  - priolist
%  Code, Information and Contact via https://github.com/Humanimaliberation/ 
%   
%  use the command help <name> for further information about a file or function with 
%  <name> = <filename> or with <name> = <functionname>
%  e.g. 'help energyflowsim' or 'help textscan_cfg'
% 
%  list all files in directory with the command dir <path to directory> 
%  e.g. 'dir current_directory' for directory of this file
%  e.g. 'dir .' for current path or 'dir ..' for path to parent directory
%==============================================================================%

clear;

%==============================================================================%
%                     INITIALISATION AND CONFIGURATIONS
%==============================================================================%

% user info: current state of program (starting)
printf('====================================== \n');
printf('starting Program... \n');   

% add loadpath to parentfolder of this executing file to allow function calls
current_directory = fileparts(mfilename('fullpath'));
addpath(genpath(current_directory)); 

% user info: display added loadpath
printf('This file is currently in directory: \n \n %s \n \n',fileparts(mfilename('fullpath')));    
printf('added path to parentfolder of this file and subfolders to Matlab Load Path...  for function calls \n'); 
% display help instructions for function usage
printf('====================================== \n');
printf('PROGARMMERS INSTRUCTIONS FOR HELP \n');                                      
printf('For information about the listed functions, use the command "help <functionname>" \n \n');
printf('files in folder functions: \n');
dir(fullfile(fileparts(mfilename('fullpath')),'functions'));
printf('\n files in subfolders functons_energyflowsim: \n');
dir(fullfile(fileparts(mfilename('fullpath')),'functions','functions_energyflowsim'));
printf('\n navigate to other folders with command "cd <relative path>" \n');
printf ('showing files in that folder with "dir <optional relative path>" \n');
printf('END USER INSTRUCTIONS FOR HELP \n');
printf('====================================== \n');

%------------------------------------------------------------------------------%
%                           Simulation arguments
%------------------------------------------------------------------------------%

% Choose load case
% user prompt charging confingurations
printf('\n');
usrprmpt = input('Choose case for charging configurations and PV-generation data: wc/nc/bc/tc [tc] ','s'); 
% default user prompt
if (isempty(usrprmpt))
  usrprmpt = 'tc';      % default userprompt, other options: 'wc','nc','bc'
end

casename = usrprmpt;                      % name of case which defines 
T = 24;                                   % simulated timeinterval in hours
precision = 2;                            % precicision to round floats

%------------------------------------------------------------------------------%
%              READ CONFIG FILES AND ADD TO STRUCTURE ARRAYS
%------------------------------------------------------------------------------%

% SET CONFIGURATIONS TO READ CONFIG FILES
sbdr_cfg = 'data';                        % name of subdirectory with configfiles
dlmtr = ';';                              % delimiter
headerlines_cfg = 3;                      % headerlines

%cfg.fname.cps = 'cfg_cps_eta1.csv';      % filename configfile cps
cfg.fname.cps = 'cfg_cps.csv';            % filename configfile cps
cfg.frmt.cps = '%s%s %f%f%f %f%f%f %f%f%f %f%f%f %f %f%f%f';  % format configfile cps:
                                          % name, node, pmin(1:3), pmax(1:3), 
                                          % qmin(1:3), qmax(1:3), wmax, etap, etan, etaw

cfg.fname.pv = ['pv_gen_',casename,'.csv'];% filename pv generation data
cfg.frmt.pv = '%f%f';                     % format pv generation data: time, kWh
                                          
cfg.fname.cpsuse = ['cfg_cpsuse_',casename,'.csv'];  % filename config cpsuse
cfg.frmt.cpsuse = '%s%s%s %f%f %f%f' ;    % format configfile cpsuse:
                                          % comment, cps.id, Mode, W, Wmax, t0, tT
                                          
cfg.fname.node = 'cfg_nodes.csv';         % filename configfile nodes
cfg.frmt.node = '%s%s %f%f%f %f%f%f ';    % format configfile nodes:
                                          % name, link, pmax(1:3), qmax(1:3)                                          

cfg.fname.priolist = 'cfg_priolist.csv';  % filename configfile cps
cfg.frmt.priolist = '%s %f';              % format configfile cps: mode, priority

% READ CONFIG FILES
% load cps configurations to struct array
printf('\n read configfile for cps-units... \n '); % unser info
cfg_cps = textscan_cfg(cfg.fname.cps, sbdr_cfg, cfg.frmt.cps, dlmtr, headerlines_cfg);
cps = textscan2struct_cfg_cps (cfg_cps); 
% cps = cps_ini_prio(cps);                       % iniitalize dynamic fieldvalues of cps

% load PV generation data
printf('\n read pv generation data... \n ');     % unser info
pv_textscan = textscan_cfg(cfg.fname.pv, sbdr_cfg, cfg.frmt.priolist, dlmtr, 0);

% transform PV generation data to better readable matrix
for t = [1:length(pv_textscan{1,2}(:))]            
     pv_profile(t,1) = -pv_textscan{1,2}(t);     % PV generation data
endfor

% load cpsuse configurations to struct array
printf('\n read configfile for cpsuse sequences... ');                                            % unser info
cfg_cpsuse = textscan_cfg(cfg.fname.cpsuse, sbdr_cfg, cfg.frmt.cpsuse, dlmtr, headerlines_cfg); % configs cpsuse
cpsuse = textscan2struct_cfg_cpsuse (cfg_cpsuse); 

% load node configurations to struct array
printf('\n read configfile for nodes... \n ');   % unser info
cfg_nodes = textscan_cfg(cfg.fname.node, sbdr_cfg, cfg.frmt.node, dlmtr, headerlines_cfg);
node = textscan2struct_cfg_nodes (cfg_nodes);

% indices to PV plant and buffer battery
idx_cps_pv = findidxstructarray(cps,'id','PV');  % index for PV plant
idx_cps_pb = findidxstructarray(cps,'id','PB');  % index for battery buffer
idx_cps_n1 = findidxstructarray(cps,'node',node{1}.id); % indices to cps on node
idx_cpsuse_pb = findidxstructarray(cpsuse,'mode','PB'); % index for battery buffer

% load priolist configurations to struct array
printf('\n read configfile for priolist... \n ');   % unser info
%cfg_priolist = textscan_cfg(cfg.fname.priolist, sbdr_cfg, cfg.frmt.priolist, dlmtr, 1);
%priolist = textscan2struct_cfg_priolist(cfg_priolist); % not yet implemented

% load priolist alternatively, because textscan2struct_cfg_priolist is not yet implemented
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

%==============================================================================%
%                      MAIN ROUTINE: SIMULATION LOOP
%==============================================================================%

% log.cps = log_cps_ini(T,length(cps)); % Initialize log variables with []

% indices to PV plant and buffer battery
idx_cps_pv = findidxstructarray(cps,'id','PV');   % index for PV plant
idx_cps_pb = findidxstructarray(cps,'id','PB');   % index for battery buffer

printf('\n starting main routine... \n');         % user info

for t = [1:T]
  printf('Current interation...  t = %d \n',t);   % user info
%------------------------------------------------------------------------------%
% (re)sets energy and power of cps according to usecase
%------------------------------------------------------------------------------%
  cps = energyplugset(cps, cpsuse, t);            % (re)set energy if plugged in/out 
  cps = nominalpowerset(cps, cpsuse, t);          % set nominal power for charging points 
  cps{idx_cps_pv}.p = [1,1,1]/3*pv_profile(t)*(cps{12}.eta(2)); % set power of PV plant           
  cps = nominalpowerset_buffer(cps,cpsuse);       % set power of puffer battery PB

  % log sum of nominal planned power of each phase for each cps and for the node
  log.node.pn{t}    = [0,0,0];                    % initialize node power on each phase
  log.node.pnsum(t) = 0;                          % initialize node sum of phase powers
  
  for i = [1:length(cps)]
    log.cps.pn{t,i} = round(cps{i}.p*10^(precision))/(10^(precision)); % log cps nominal power on each phase 
    log.cps.pnsum(t,i) = round(sum(cps{i}.p)*10^(precision))/(10^(precision)); % log cps sum of phase powers
    
    if strcmp(cps{i}.node,'n1')
      log.node.pn{t} = log.node.pn{t} + cps{i}.p; % log node power on each phase
      log.node.pnsum(t) = log.node.pnsum(t) + sum(cps{i}.p); % log node sum of phase powers
    endif 
  endfor
  
%------------------------------------------------------------------------------%
%     DSM START if powerdemand on at least on phase of the first node
%------------------------------------------------------------------------------% 

  % active powerdemand pdsm on each phase on 1st node 
  pdsm = pdsm_get(cps, node, node{1}.id);         % get active power demand
    
  if find(pdsm != [0,0,0]) > 0 
    % set priorities
    for i = [1:length(cps)]
      cps{i}.prio = 0;                            % reset priorities
    endfor
    
    cps = setcpsprio(cps, idx_cps_n1, cpsuse, priolist, t); % set priorities
  
    % find highest priority
    priomax = 0;                    
    for p = [1:length(priolist)]
      priomax = max(priomax, priolist{p}.prio);   % number of different priorities
    endfor    
    
    % DSM regulating equally relativ CPS-units with same priority starting by lowest
    for prio = [1:priomax]                       
      idx_cps_prio = findidxstructarray(cps,'prio',prio); % indices to cps
      pdsm = pdsm_get(cps, node, node{1}.id);     % 
      cps = dsmrel(cps, idx_cps_prio, pdsm);      % adjust planned power .p
    endfor
  endif
  
  % Apply energyflows
  cps = energyflow_set(cps); % set .w of cps elements, does not reset .p yet
  
%------------------------------------------------------------------------------%
%                                   Log Data
%------------------------------------------------------------------------------%
  
  cpst{t} = cps;                                  % for debugging   
  log.node.pdsm{t} = pdsm;
  log.node.pdsmsum(t) = sum(pdsm);                % for debugging  
  log.node.psum(t) = 0;                           % initalize

  for i = [1:length(cps)]                         % logging loop
    log.cps.p{t,i} = cps{i}.p;
    log.cps.psum(t,i) = sum(cps{i}.p);    
    log.cps.w(t,i) = cps{i}.w;
%    value = cps{i}.p;
%    log.cps.p{t,i} = round(value*10^(precision))/(10^(precision));
%    log.cps.psum(t,i) = round(sum(value)*10^(precision))/(10^(precision));
%    value = cps{i}.w;
%    log.cps.w(t,i) = round(value*10^(precision))/(10^(precision));    
    log.cps.prio(t,i) = cps{i}.prio; 
    log.cps.id{i} = cps{i}.id;
    
    if strcmp(cps{i}.node,'n1')    
      log.node.psum(t) = log.node.psum(t) + sum(cps{i}.p);
    endif    
    
  endfor                                          % end logging loop

endfor                                            % end main routine 

% Reformat some logs
log.node.psum = log.node.psum';
log.node.pnsum = log.node.pnsum';
log.node.pdsmsum = log.node.pdsmsum';

%------------------------------------------------------------------------------%
%     Get statisticss (self sufficiency level and self consumption share)
%------------------------------------------------------------------------------%

W_con_t_LP   = zeros(T, 1);       % energy consumption (LP) in specific timeinterval
W_con_t      = zeros(T, 1);       % energy consumption (LP+PB) in specific timeinterval
W_gen_t      = zeros(T,1);        % energy generation in specific timeinterval
W_con_self_t = zeros(T,1);        % energy self consumption in specific timeinterval

for t = [1:T]
  W_con_t_LP(t)   = sum(log.cps.psum(t,1:(idx_cps_pb-1))'); % total energy consumption of charging points
  W_con_t(t)      = sum(log.cps.psum(t,1:idx_cps_pb)'); % total energy consumption of charging infrastructure incl. PB
%  W_con_t_PB0(t)  = sum(log.cps.psum(t,1:idx_cps_pb-1)'); % total energy consumption without PB
  W_gen_t(t)      = log.cps.psum(t,idx_cps_pv);
  W_con_self_t_LP(t) = min(W_con_t_LP(t),-W_gen_t(t));
  W_con_self_t(t) = min(W_con_t(t),-W_gen_t(t));
%  W_con_self_t_PB0(t) = min(W_con_t_PB0(t),-W_gen_t(t));
endfor

% log buffer battery statistics
idx_cps_pb_pos = find(log.cps.psum(:,idx_cps_pb) > 0);    % indices for time with PB discharging
idx_cps_pb_neg = find(log.cps.psum(:,idx_cps_pb) < 0);    % indices for time with PB charging
log.stat.PB_P_pos = sum(log.cps.psum(idx_cps_pb_pos,idx_cps_pb)); % battery energy consumption
log.stat.PB_P_neg = sum(log.cps.psum(idx_cps_pb_neg,idx_cps_pb)); % battery energy generation
log.stat.PB_W_delta = log.stat.PB_P_pos * cps{idx_cps_pb}.eta(1) + log.stat.PB_P_neg / cps{idx_cps_pb}.eta(2);
log.stat.PB_P_pos_deltaSoC0 = log.stat.PB_P_pos - (log.stat.PB_W_delta < 0)*log.stat.PB_W_delta / cps{idx_cps_pb}.eta(1); % theoretical battery energy consumption to gain initial SoC
log.stat.PB_P_neg_deltaSoC0 = log.stat.PB_P_neg - log.stat.PB_W_delta*(log.stat.PB_W_delta > 0) * cps{idx_cps_pb}.eta(2); % theoretical battery energy generation to gain initial SoC

% log absolute statistics in kWh
log.stat.W_con_LP      = W_con_LP = sum(W_con_t_LP);      % total energy consumption
log.stat.W_con      = W_con = sum(W_con_t);               % total energy consumption
log.stat.W_con_deltaSoC0 = W_con - log.stat.PB_P_pos - log.stat.PB_P_neg + log.stat.PB_P_pos_deltaSoC0 + log.stat.PB_P_neg_deltaSoC0; % total energy consumption with battery (dis)charged to initial SoC
%log.stat.W_con_PB0  = sum(W_con_t_PB0);                   % total energy consumption without PB
log.stat.W_gen      = W_gen = sum(W_gen_t);               % total energy generation
log.stat.W_con_self_LP = W_con_self_LP = sum(W_con_self_t_LP);     % total energy self consumption 
log.stat.W_con_self = W_con_self = sum(W_con_self_t);     % total energy self consumption 
%log.stat.W_con_self_PB0  = sum(W_con_self_t_PB0);         % total energy self consumption without PB

% log relative statistics
log.stat.gen_con_ratio        = sum(W_gen) / sum(W_con);                          % generation consumption ratio
%log.stat.gen_con_ratio_PB0    = sum(W_gen) / sum(log.stat.W_con_PB0);             % generation consumption ratio without PB
log.stat.self_con_share       = sum(W_con_self) / -sum(W_gen);                     % self consumption share
%log.stat.self_con_share_PB0   = sum(log.stat.W_con_self_PB0) / sum(W_gen);        % self consumption share without PB
log.stat.self_suff_level      = min(1,sum(W_con_self) / sum(log.stat.W_con_deltaSoC0));  % self sufficiency level
%log.stat.self_suff_level_PB0  = sum(log.stat.W_con_self_PB0) / sum(log.stat.W_con_PB0); % self sufficiency level without PB

%==============================================================================%
%                      DISPLAY AND SAVE DATA, USER INFO
%==============================================================================%

%------------------------------------------------------------------------------%
%                                Display Data
%------------------------------------------------------------------------------%

t0 = 1;                                                  % start time to plot
W_grid_t(1:length(W_con_t(:))) = W_con_t(:) + W_gen_t(:);
data_plot_p = [W_grid_t(:)'; W_con_t(:)'; W_gen_t(:)']';
leg = {'W_{grid} / kWh';'W_{node} / kWh';'W_{PV} / kWh'};
plotbar = bar(data_plot_p); % Plot PV-generation grouped bar chart
axis([t0-1 T+1 -15 35]);
colormap(summer( length(data_plot_p(:,1)) ));
grid on;
legend(plotbar,leg);
      
% write cps timetable to .csv
header.psum    = header.w    = {};
header.psum{1} = header.w{1} = 'time';

%
for i = [1:length(cps)]
  header.psum{i+1}     = [cps{i}.id, ': P/kW'];
  header.w{i+1}        = [cps{i}.id, ': W/kWh'];
  fname_log.p{i}     = ['log_',cps{i}.id,'_p'];
  fname_log.psum{i}  = ['log_',cps{i}.id,'_psum'];
  fname_log.w{i}     = ['log_',cps{i}.id,'_w'];
endfor   

%header = {'time','p1','p2','p3'};
%for n = [1:N]
%  filename = ['cps',num2str(n),'.csv'];
%  fid = fopen(filename, 'w');
%  fprintf(fid, repmat('%s',1,4),header{:});
%  %fprintf(fid, repmat('%s',1,22), header2{:});
%  fclose(fid);
%  dlmwrite(fullfile(pwd, 'cps3.csv'),[x{3}.t, x{3}.p, x{3}.pmin, x{3}.pmax],'delimiter',';','newline','pc'); % write 24h .csv worst day
%endfor

%------------------------------------------------------------------------------%
%                                   Save Data
%------------------------------------------------------------------------------%
% adjust save directory filepaths
pwd = change_savedir();                     % prompt to change directory to save data

% save energyflow data
dlmwrite(fullfile(pwd, ['W_grid_',casename,'0.csv']),W_grid_t(:),'delimiter',';','newline','pc'); % 
dlmwrite(fullfile(pwd, ['W_con_',casename,'0.csv']),W_con_t(:),'delimiter',';','newline','pc'); % 
dlmwrite(fullfile(pwd, ['W_con_self_',casename,'0.csv']),W_con_self_t(:),'delimiter',';','newline','pc'); % 

printf('\n finished simuluation. Call logs with variable "log" e.g. "log.cps" \n ');