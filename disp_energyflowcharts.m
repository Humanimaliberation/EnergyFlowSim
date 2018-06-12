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
%==============================================================================%
%  USER INSTRUCTIONS 
%
%==============================================================================%

clear;

% add loadpath to parentfolder of this executing file to allow function calls
addpath(genpath(fileparts(mfilename('fullpath')))); 

% SET CONFIGURATIONS TO READ CONFIG FILES
cfg.subdir = 'results';                         % name of subdirectory with configfiles
cfg.dlmtr = ';';                                % delimiter
cfg.frmt = '%f';                                % 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% READ ENERGY CONSUMPTION DATA
% worst case: configs to read energy consumption data
casename = 'wc';
cfg.fname.wc = ['W_con_',casename,'0.csv'];           % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.wc),'rt');  % file identifier
txtscan.wc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

% normal case: configs to read energy consumption data
casename = 'nc';
cfg.fname.nc = ['W_con_',casename,'0.csv'];           % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.nc),'rt');  % file identifier
txtscan.nc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

% best case: configs to read energy consumption data
casename = 'bc';
cfg.fname.bc = ['W_con_',casename,'0.csv'];           % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.bc),'rt');  % file identifier
txtscan.bc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

W_con_all = [txtscan.wc{1},txtscan.nc{1},txtscan.bc{1}];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% READ ENERGY SELF CONSUMPTION DATA
% worst case: configs to read energy consumption data
casename = 'wc';
cfg.fname.wc = ['W_con_self_',casename,'0.csv'];      % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.wc),'rt');  % file identifier
txtscan.wc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

% normal case: configs to read energy consumption data
casename = 'nc';
cfg.fname.nc = ['W_con_self_',casename,'0.csv'];      % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.nc),'rt');  % file identifier
txtscan.nc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

% best case: configs to read energy consumption data
casename = 'bc';
cfg.fname.bc = ['W_con_self_',casename,'0.csv'];      % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.bc),'rt');  % file identifier
txtscan.bc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

W_con_self_all = [txtscan.wc{1},txtscan.nc{1},txtscan.bc{1}];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% READ GRID ENERGYFLOW DATA
% worst case: configs to read grid energy flow data
casename = 'wc';
cfg.fname.wc = ['W_grid_',casename,'0.csv'];            % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.wc),'rt');    % file identifier
txtscan.w_grid.wc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

% normal case: configs to read grid energy flow data
casename = 'nc';
cfg.fname.nc = ['W_grid_',casename,'0.csv'];            % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.nc),'rt');    % file identifier
txtscan.w_grid.nc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

% best case: configs to read grid energy flow data
casename = 'bc';
cfg.fname.bc = ['W_grid_',casename,'0.csv'];            % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.bc),'rt');    % file identifier
txtscan.w_grid.bc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

W_grid_all = [txtscan.w_grid.wc{1},txtscan.w_grid.nc{1},txtscan.w_grid.bc{1}];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% READ PV DATA
cfg.subdir = 'data';                                    % name of subdirectory with configfiles
cfg.frmt = '%f%f';                                      % 

% worst case: configs to read PV data
casename = 'wc';
cfg.fname.wc = ['pv_gen_',casename,'.csv'];             % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.wc),'rt');    % file identifier
txtscan.pv_gen.wc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

% normal case: configs to read PV data
casename = 'nc';
cfg.fname.nc = ['pv_gen_',casename,'.csv'];             % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.nc),'rt');    % file identifier
txtscan.pv_gen.nc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

% best case: configs to read PV data
casename = 'bc';
cfg.fname.bc = ['pv_gen_',casename,'.csv'];             % filename

fid = fopen(fullfile(cfg.subdir,cfg.fname.bc),'rt');    % file identifier
txtscan.pv_gen.bc = textscan(fid, cfg.frmt, 'Delimiter',cfg.dlmtr, 'CollectOutput',true); % cell-array with all data from file
fclose(fid);

W_pv_gen = [txtscan.pv_gen.wc{1}(:,2),txtscan.pv_gen.nc{1}(:,2),txtscan.pv_gen.bc{1}(:,2)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DISPLAY DATA
input('Display Energy consumption all cases');          % Passive sign convention (Verbraucherpfeilssystem)
data_plot = W_con_all;
leg = {'Worst case: W_{consumption} / kWh'; 'Normal case: W_{consumption} / kWh'; 'Best case: W_{consumption} / kWh'};
plotbar = bar(data_plot);                               % Plot grouped bar chart
colormap(summer( length(data_plot(1,:)) ));
axis([0 25 0 40]);
grid on;
legend(plotbar,leg);


input('Display Energy self consumption all cases');     % Passive sign convention (Verbraucherpfeilssystem)
data_plot = W_con_self_all;
leg = {'Worst case: W_{self-consumption} / kWh'; 'Normal case: W_{self-consumption} / kWh'; 'Best case: W_{self-consumption} / kWh'};
plotbar = bar(data_plot);                               % Plot grouped bar chart
colormap(summer( length(data_plot(1,:)) ));
axis([0 25 0 7]);
grid on;
legend(plotbar,leg);
      
input('Display Energy supply grid all cases');          % Active sign convention (Erzeugerpfeilsystem)
data_plot = W_grid_all;
leg = {'Worst case: W_{grid} / kWh'; 'Normal case: W_{grid} / kWh'; 'Best case: W_{grid} / kWh'};
plotbar = bar(data_plot);                               % Plot grouped bar chart
colormap(summer( length(data_plot(1,:)) ));
axis([0 25 -20 40]);
grid on;
legend(plotbar,leg);
      
input('Display PV Generation all cases');               % Active sign convention (Erzeugerpfeilsystem)
data_plot = W_pv_gen;
leg = {'Worst case: W_{PV,generation} / kWh'; 'Normal case: W_{PV,generation} / kWh'; 'Best case: W_{PV,generation} / kWh'};
plotbar = bar(data_plot,'stacked');                     % Plot grouped bar chart
colormap(summer( length(data_plot(1,:)) ));
grid on;
legend(plotbar,leg);
      