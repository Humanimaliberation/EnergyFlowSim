function caltime(t)
  % ======================================================================
  % Syntax: caltime(t) 
  % Description: displays measured timeintervals during compilation process
  %
  % IN: t: {6x1}(1x6) struct with 6 6-element datevectors [year month day hour minute seconds]
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

  printf('Total loading time: %f s \n',etime(t{end},t{1}));
  printf('Initalisation time: %f s \n',etime(t{2},t{1}));
  printf('Read 1h data: %f s \n',etime(t{3},t{2}));
  printf('Read 24h data: %f s \n',etime(t{4},t{3}));
  printf('Analysing time data 24h: %f \n',etime(t{5},t{4}));
  printf('Writing time data 1h: %f \n\n',etime(t{6},t{5}));
endfunction