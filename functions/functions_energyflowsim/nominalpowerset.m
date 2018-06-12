function [cps]  = nominalpowerset(cps_in, cpsuse, t)
  % ======================================================================
  % Syntax: pn = nominalpowerset(cps, cpsuse, t)
  % Description: Set planned power .p of cps structure to zero and if applicable set .p to nominal voltage according to cpsuse
  %
  % IN: cps: structure array of variable length with elements of structure cps
  % IN: cpsuse: structure array of variable length with elements of structure cpsuse
  % IN: t: current time in h of a day
  % OUT: cpspn: structure array of variable length with elements of structure cps (edited form of input array if applicable else identical to input array)
  % OUT: log_psum: scalar sum of 
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
  
  cps = cps_in; 
  
  % set nominal power for every CPS-unit
  for m = [1:length(cps)]                                      
    cps{m}.p = [0,0,0];                                        % initialize planned power by zero
    idx_cpsuse_id = findidxstructarray(cpsuse,'id',cps{m}.id); % indices to cpsuse elements with usecase configuration for current CPS-unit
    
    % set nominal power for charging point if usecase applies
    for n = idx_cpsuse_id     
      if cpsuse{n}.t0/100+1 <= t && t <= cpsuse{n}.tT/100      % if current cpsuse element for current cps element is at current time t active
        cps{m}.p = nominalpowerget(cps{m},cpsuse{n},t);        % true: set planned power to nominal power
      endif
      
    endfor
    
  endfor
  
endfunction

