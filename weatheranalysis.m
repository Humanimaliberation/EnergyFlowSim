% ======================================================================
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
% ======================================================================
%  USER INSTRUCTION: STEP BY STEP
%  1) Download global radiation data with 1h-timebase and 24h-timebase from link 
%     below into the subdirectory 'data' of the current working directory 
%     DWD weather data in the climate data center (cdc) accessable through ftp
%     ftp://ftp-cdc.dwd.de/pub/CDC/observations_germany/climate/
%  2) Configure parameters
%     2)a) filenames 'filename_1h' and 'filename_24h' in Initalisation-Part of this script
%     2)b) times 'time_start_str' and 'time_end_str' for the timeinterval which should be used
%     2)c) P_stc
%     2)d) pv_angle [NOT YET IMPLEMENTED!]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTES: FORMAT DATA SOURCE DWD CDC GLOBAL RADIATION
  % 1h Dataset: 
  % STATIONS_ID;MESS_DATUM;   QN_592; ATMO_LBERG; FD_LBERG;FG_LBERG;SD_LBERG;ZENIT;   MESS_DATUM_WOZ;eor
  % 5906;       1979010100:28;    1;   -999;      0.0;      0.0;      0;      152.90; 1979010101:00;eor
  % global radiation (FG_LBERG) in J/cm^2
  %
  % 24h Dataset: 
  % STATIONS_ID;MESS_DATUM;QN_592;ATMO_STRAHL;FD_STRAHL;FG_STRAHL;SD_STRAHL;eor
  % 5906;       19790101;    1;     -999;     -999;     373.00;    2.7;eor
  % global radiation (FG_STRAHL) in J/cm^2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PROGRAMMSTART
% Add path to function folder to matlab search path
clear;

% add loadpath to parentfolder of this executing file to allow function calls
current_directory = fileparts(mfilename('fullpath'));
addpath(genpath(current_directory)); 

t0 = clock(); % to estimate the calculation time
printf("Programstart: Let us begin! \n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FUNCTIONS in extra file
% function description callable with command "help function_name" where function_name is the name of the function
% In/Out: argument/output name: datatype and if applicable physical unit
% e.g. In: time: datestring in format 'yyyymmdd'
% e.g. Out: matrixOut: (4x2) [datenum, scalar value in Wh; ...] 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INITIALISATION (manual configuration of parameters)
filename_1h = 'Testdaten_1h.txt';  				 % 1h-timebase data shortened dataset 
filename_24h = 'Testdaten_2h.txt';    				 % 24h-timebase data shortened dataset
%filename_1h = 'produkt_st_stunde_19790101_20180330_05906.txt';  % 1h-timebase data  original full dataset
%filename_24h = 'produkt_st_tag_19790101_20180330_05906.txt';    % 24h-timebase data original full dataset

frmt_1h = ['%d %s %d %d %f %f %f %f %s']; % Datatypes: Integer(%d), String)(%s), Float(%f) NOTE: Theoretisch reichen Int16 (%d16)
frmt_24h = ['%d %s %d %d %f %f %f'];      % Datatypes: Integer(%d), String)(%s), Float(%f) NOTE: Theoretisch reichen Int16 (%d16)
frmt_1htime = 'yyyymmddHH:MM';            % Timestamp format after conversion
frmt_24htime = 'yyyymmdd';                % Timestamp format

% filepaths
pwd = change_savedir();                   % prompt to change directory to save data

% timeinterval start/end for observations_germany 
time_start_str = '19910101';              % start of timeinterval in format 'yyyymmdd'
time_end_str   = '20111231';              % end   of timeinterval in format 'yyyymmdd'
% timeinterval length of observation as datenum difference
time_diff = datenum(time_end_str,frmt_24htime) - datenum(time_start_str,frmt_24htime); 

% PV plant specifications
P_stc = 20.145;                           % PV peak power in kWp
%pv_angle = 0;                            % NOT INTEGRATED YET, module angle to horizontal line in degree 

% Geodata (necessary if the module angle is not zero)
% geo_b = 49.4875;                        % geographical width in degree, Mannheim
% geo_l = 8.4661;                         % geographical length in degree, Mannheim

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Debug Mode? (Partial reinitalisation)
usrprmpt = input('Start in debug mode with shorter loading time? Y/N [Y]: ','s');
if (isempty(usrprmpt))
  usrprmpt = 'Y';
end
if (usrprmpt == 'Y')
  time_start_str = '19790101';            % start of timeinterval in format 'yyyymmdd'
  time_end_str =  '19791231';             % end   of timeinterval in format 'yyyymmdd'
  time_diff = datenum(time_end_str,frmt_24htime) - datenum(time_start_str,frmt_24htime); % length of observed timeinterval
  filename_1h = 'Testdaten_1h.txt';       % 1h-timebase data 
  filename_24h = 'Testdaten_24h.txt';     % 24h-timebase data

  printf('1h database: %s \n 24h database: %s \n time start observation: %s \n time end observation: %s \n',filename_1h,filename_24h,time_start_str, time_end_str);
elseif
  printf('1h database: %s \n 24h database: %s \n time start observation: %s \n time end observation: %s \n \n',filename_1h,filename_24h,time_start_str, time_end_str);  
endif  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% READING AND RE-FORMATTING DATA WITH 1H-TIMEBASE
t00 = clock(); % timestamp for caltime(t) function
printf('1h-database is loading... this could take some minutes. Ignore fopen-warning. \n'); % user info
% read original weather data 1h-timebase:
fid_1h = fopen(fullfile('data',filename_1h),'rt');    % file identifier
raw1h = textscan(fid_1h, frmt_1h, 'Delimiter',';', 'CollectOutput',true, 'HeaderLines',1, 'CommentStyle','eor'); % cell-array with all data from file
fclose(fid_1h);

dt_woz = datenum(raw1h{5}, frmt_1htime);              % convert datestring to datenum
dt_utc = datenum(raw1h{2}, frmt_1htime);              % convert datestring to datenum

% filter raw data:
data_1h_cell = [num2cell([dt_woz raw1h{4}(:,2)])]     % timestamps (1h steps) and radiation
data_1h = cell2mat (data_1h_cell);                    % convert data in cell to matrix

% Calculate PV energyoutput [kWh] out of vertical global radiation [J/cm^2] 
data_1h(:,2) = pv_power(data_1h(:,2),P_stc,1);        % timestamps (24h steps), PV energy

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% READING AND RE-FORMATTING DATA WITH 24H-TIMEBASE
t01 = clock();                                        % timestamp for caltime(t)
disp('24h-database is loading... this could take some minutes. Ignore fopen-warning.'); % user info
% read original weather data 24h-timebase:
fid_24h = fopen(fullfile('data',filename_24h),'rt');  % File Identifier
raw24h = textscan(fid_24h, frmt_24h, 'Delimiter',';', 'CollectOutput',true, 'HeaderLines',1, 'CommentStyle','eor'); % cell-array with all data from file
fclose(fid_24h);

dt_24h = datenum(raw24h{2}, frmt_24htime);            % convert datestring to datenum

% filter raw data:
data_24h_cell = [num2cell([dt_24h raw24h{4}(:,2)])]   % timestamps (24h steps) and radiation
data_24h = cell2mat (data_24h_cell);                  % convert data in cell to matrix

% Calculate PV energyoutput [kWh] out of vertical global radiation [J/cm^2] 
data_24h(:,2) = pv_power(data_24h(:,2),P_stc,1);      % timestamps (24h steps), PV energy


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ANALYSING DATA WITH 24H-TIMEBASE AND SAVE DATA WITH 1H-TIMEBASE TO .CSV
t02 = clock(); % timestamp for caltime(t) function
% find indices 24h-timebase, convert to 1h-timebase
[idx_min,idx_max,idx_avg,idx_miss] = daychooser(data_24h,time_start_str,time_end_str,frmt_24htime); % index for day with min/max/avg global radiation
idx_min1h = idx24hto1h(idx_min,data_24h(1,1),data_1h(1,1),frmt_24htime); % Convert Index 24h dataset to 1h dataset
idx_avg1h = idx24hto1h(idx_avg,data_24h(1,1),data_1h(1,1),frmt_24htime); % Convert Index 24h dataset to 1h dataset
idx_max1h = idx24hto1h(idx_max,data_24h(1,1),data_1h(1,1),frmt_24htime); % Convert Index 24h dataset to 1h dataset

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SAVING DATA WITH 1H-TIMEBASE TO .CSV
% path and filename = case_date_datestart_to_dateend.csv 
filename_wd = strcat('wd_',datestr(data_24h(idx_min,1),'yyyymmdd'),'_',time_start_str(1:4),'_to_',time_end_str(1:4),'.csv'); % filename for worst day global radiation data
filename_ad = strcat('ad_',datestr(data_24h(idx_avg,1),'yyyymmdd'),'_',time_start_str(1:4),'_to_',time_end_str(1:4),'.csv'); % filename for average day global radiation data
filename_bd = strcat('bd_',datestr(data_24h(idx_max,1),'yyyymmdd'),'_',time_start_str(1:4),'_to_',time_end_str(1:4),'.csv'); % filename for best day global radiation data

% write data of certain days to new .csv
t03 = clock(); % timestamp for caltime(t) function
dlmwrite(fullfile(pwd, filename_wd),data_1h(idx_min1h:idx_min1h+23,:),'delimiter',';','newline','pc'); % write 24h .csv worst day
dlmwrite(fullfile(pwd, filename_ad),data_1h(idx_avg1h:idx_avg1h+23,:),'delimiter',';','newline','pc'); % write 24h .csv average day
dlmwrite(fullfile(pwd, filename_bd),data_1h(idx_max1h:idx_max1h+23,:),'delimiter',';','newline','pc'); % write 24h .csv best day

printf('%s is written to directory %s \n',filename_wd,pwd); % user info
printf('%s is written to directory %s \n',filename_ad,pwd); % user info
printf('%s is written to directory %s \n',filename_bd,pwd); % user info

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DISPLAY RESULTS FOR USER
t1 = clock();
t = {t0,t00,t01,t02,t03,t1};
usrprmpt = input('Zeiten und Ergebnisse anzeigen? Y/N [Y] \n','s');
if (isempty(usrprmpt))
  usrprmpt = 'Y';
end
if usrprmpt == 'Y'
  caltime(t);
  printf('Timeinterval total: \n %s to %s \n',datestr(data_24h(1,1),'dd.mm.yyyy'), datestr(data_24h(end,1),'dd.mm.yyyy'));
  printf('Timeinterval analysed: \n %s to %s \n\n',datestr(datenum(time_start_str,'yyyymmdd'),'dd.mm.yyyy'), datestr(datenum(time_end_str,'yyyymmdd'),'dd.mm.yyyy'));

  info.date.min = datestr(data_24h(idx_min,1),'dd.mm.yyyy');
  info.date.avg = datestr(data_24h(idx_avg,1),'dd.mm.yyyy');
  info.date.max = datestr(data_24h(idx_max,1),'dd.mm.yyyy');
  info.rad.min.j = raw24h{4}(idx_min,2);              % J/cm^2
  info.rad.avg.j = raw24h{4}(idx_avg,2);              % J/cm^2
  info.rad.max.j = raw24h{4}(idx_max,2);              % J/cm^2
  info.rad.min.kwh = raw24h{4}(idx_min,2)*(100/60)^2; % Wh/m^2
  info.rad.avg.kwh = raw24h{4}(idx_avg,2)*(100/60)^2; % Wh/m^2
  info.rad.max.kwh = raw24h{4}(idx_max,2)*(100/60)^2; % Wh/m^2
  info.pv.min = data_24h(idx_min,2);                  % kWh
  info.pv.avg = data_24h(idx_avg,2);                  % kWh
  info.pv.max = data_24h(idx_max,2);                  % kWh

  % user info: Minimum
  printf('Minimal radiation on %s: \n %.2f J/(d*cm^2) = %.2f Wh/(d*m^2) \n', info.date.min, info.rad.min.j,info.rad.min.kwh);
  printf('PV-Power on %s: \n %.2f kWh/d with %.2f kWp \n \n', info.date.min, info.pv.min, P_stc/1000);
  
  % user info: Average 
  printf('Average radiation on %s: \n %.2f J/(d*cm^2) = %.2f Wh/(d*m^2) \n', info.date.avg, info.rad.avg.j,info.rad.avg.kwh);
  printf('PV-Power on %s: \n %.2f kWh/d with %.2f kWp \n \n', info.date.avg, info.pv.avg, P_stc/1000);  
  
  %user info: Maximum
  printf('Maximal radiation on %s: \n %.2f J/(d*cm^2) = %.2f Wh/(d*m^2) \n', info.date.max, info.rad.max.j,info.rad.max.kwh);
  printf('PV-Power on %s: \n %.2f kWh/d with %.2f kWp \n \n', info.date.max, info.pv.max, P_stc/1000);
   
endif  

plot_pv(data_1h,idx_min1h, idx_avg1h, idx_max1h);
printf('%d day(s) with inplausible datarows between %s and %s an the following indices: \n ',length(idx_miss),time_start_str,time_end_str);
disp(idx_miss);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Only for debugging and further analysing
idx_start = 1 + datenum(time_start_str,frmt_24htime) - data_24h(1,1);  % set index to skip first part in dataset
a = datenum(time_start_str,frmt_24htime);
o = datenum(time_end_str,frmt_24htime);               % to be checked ... (o-a)==dt   ???
idx_end = idx_start + (o-a);                          % index for dataset to datestr_end
[idxneg, idxnegall, avg, avgpos, avgall, avgposall] = average_more (data_24h(:,2),idx_start,idx_end);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

