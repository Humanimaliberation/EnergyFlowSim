function [idx_min,idx_max,idx_avg,idx_miss] = daychooser(dataset, datestr_start, datestr_end, frmt_datestr)
  % ======================================================================
  % Syntax: [idx_min,idx_max,idx_avg] = daychooser(dataset, datestr_start, datestr_end, frmt_datestr) 
  % Description: outputs indices to row in dataset(:,1:2) with minimum, next to average and maximum value dataset(:,2) ignoring negative values as plausibility test
  %
  % In: dataset: (?x2) [datenum (24h-steps), scalar]
  % In: datestr_start and datestr_end: datestring in format frmt_datestr
  % In: frmt_datestr: string with time format e.g. 'yyyymmdd'
  % Out: [idx_in,idx_max,idx_avg,idx_miss]:(4x1) [scalar, scalar, scalar, array of zeros and ones]
  % ======================================================================

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

  idx_start = 1 + datenum(datestr_start,frmt_datestr) - dataset(1,1);  % set index to skip first part in dataset
  a = datenum(datestr_start,frmt_datestr);
  o = datenum(datestr_end,frmt_datestr);  % to be checked ... (o-a)==dt   ???
  idx_end = idx_start + (o-a);            % index for dataset to datestr_end
  dt = idx_end - idx_start + 1;           % delta t in days
  
  [idx_miss, unused02, unused03, avg_pos, unused05, unused06] = average_more (dataset(:,2),idx_start,idx_end); % overkill, nur avg_pos wird benötigt

  idx_min = idx_max = idx_avg = idx_start;                                      % set all indices to start
  for i = idx_start+1:idx_end                                                   % find idx_min, idx_avg and idx_max
    if dataset(i,2) < dataset(idx_min,2) && dataset(i,2) > 0                     % minimum? (plausi check: above zero)
      idx_min = i;                                                              % adjust index to minimum
    endif  
    if dataset(i,2) > dataset(idx_max,2)                                        % maximum?
      idx_max = i;                                                              % adjust index to max
    endif  
    if abs((dataset(i,2) - avg_pos)) < abs((dataset(idx_avg,2) - avg_pos));      % average? (avg_pos ist Durchschnitt positiver Werte zwischen idx_start und idx_end)
      idx_avg = i;                                                              % adjust index to average 
    endif  
  endfor
endfunction