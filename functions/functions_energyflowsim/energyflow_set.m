function cps = energyflow_set(cpsin) 
  % ======================================================================
  % Syntax:  cps = energyflow(cpsin) 
  % Description: sets energy .w according to planned power .p and efficiency .eta in cps struct-array and resets planned power to zero
  %
  % IN: cpsin: structure array of variable length with elements of structure cps
  % OUT: cps: structure array of variable length with elements of structure cps (edited form of input array if applicable else identical to input array)
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

  cps = cpsin;
  for i = 1:length(cps) % set .w for elements of cps
    cps{i}.w = cps{i}.eta(3)*cps{i}.w;  % unregulated discharge to environment
    if sum(cps{i}.p) > 0
      cps{i}.w = cps{i}.w + sum(cps{i}.p)*cps{i}.eta(1); % if p>0
    elseif sum(cps{i}.p) < 0
      cps{i}.w = cps{i}.w + sum(cps{i}.p)/cps{i}.eta(2); % w if p<0
    endif
  endfor
endfunction