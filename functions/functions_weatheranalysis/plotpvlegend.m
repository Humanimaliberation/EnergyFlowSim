function plotpvlegend(data_1h,idx,names) 
  % ======================================================================
  % NOTE WIP, n = 1 not yet scalable
  % Syntax: plotpvlegend(data_1h, idx, names)
  % Description: plots 24h pv generation in 1h steps of indexed day in argument data_1h starting with 01:00 am
  % 
  % In: names: (1xn) string array with variable length n
  % In: idx: (1xn) numeric array with variable length n
  % In: data_1h: (mx2) matrix with variable length m like [datenum, scalar]
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

  unit = 'kWh/h'; 
  n = length(idx);
  data = cell{n,2};
  for n = 1:n
    data{n,1} = names{n};
    data{n,2} = data_1h(idx:idx+23,2)';
  endfor
  plotbar = bar(data{1,2}) % Plot PV-generation grouped bar chart
  colormap(summer(1));
  grid on;
  legend(plotbar,{names});
endfunction