function plot_bars(data, leg, plotcfg) 
  % ======================================================================
  % Syntax: plot_bars(data, n, leg, plotcfg) 
  % Description: Shows figure of data with n rows and variable columns
  %
  % IN: data = numeric matrix (nx?)  
  % IN: n = number of datarows
  % IN: leg = string array with names of single datarows
  % IN: plotcfg = e.g. 'stacked'
  % OUT: figure
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

  plotbar = bar(data,plotcfg) % Plot PV-generation grouped bar chart
  colormap(summer( length(data(:,1)) ));
  grid on;
  legend(plotbar,leg);
endfunction