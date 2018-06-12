  function log_cps = log_cps_set(cps,t,log_cpsin)
    % ======================================================================
    % Syntax: [psum_log,w_log,prio_log] = log_cps(cps,t,psum_log,w_log,prio_log) 
    % Description: logs planned power sum, energy and priority of cps elements
    % 
    % IN: 
    % OUT: 
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

    log_cps = log_cpsin;
    for i = [1:length(cps)]
      log_cps.psum(t,i) = sum(cps{i}.p);
      log_cps.w(t,i) = cps{i}.w;
      log_cps.prio(t,i) = cps{i}.prio;
    endfor
  endfunction
  
 



