function plot_pv(data_1h, idx_min1h, idx_avg1h, idx_max1h) 
  % ======================================================================
  % Note: plotting single datasets BROKEN !
  % Syntax: plot_pv(data_1h, idx_min1h, idx_avg1h, idx_max1h)
  % Description: plottet die 3 Datensätze der PV-Ertragsdaten bzw. Globalstrahlungsdaten ohne Einheiten Angabe in einem gestapelten Balkendiagramm ÜBER 24h  
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

  usrprmpt = input('Erzeugungsprofile anzeigen? all/min/avg/max/no [all]','s');
  if (isempty(usrprmpt))
    usrprmpt = 'all';
  endif
  switch usrprmpt
    case 'all'
      min = data_1h(idx_min1h:idx_min1h+23,2)';
      avg = data_1h(idx_avg1h:idx_avg1h+23,2)';
      max = data_1h(idx_max1h:idx_max1h+23,2)';
      dataplotall = [min; avg; max];
      leg = {'Min';'Avg';'Max'};
      plot_bars(dataplotall',leg,'stacked');    
    case 'min'
      dataplotmin = data_1h(idx_min1h:idx_min1h+23,2)';
      plot_bars(dataplotmin',{'min'},'');     
    case 'avg'
      dataplotavg = data_1h(idx_avg1h:idx_avg1h+23,2)';
      plot_bars(dataplotavg,1,{'avg'},'');        
    case 'max'
      dataplotmax = data_1h(idx_max1h:idx_max1h+23,2)';
      plot_bars(dataplotmax,1,{'max'},''); 
    case 'no'
     disp('Plots lassen sich mit der Funktion "plot_pv(data_1h,idx_min1h, idx_avg1h, idx_max1h)" anzeigen');
  endswitch

endfunction