function priolist = textscan2struct_cfg_priolist (cfg_priolist) 
  % ======================================================================
  % Syntax: priolist = textscan2struct_cfg_priolist (cfg_priolist)
  % Description: Converts the configs cfg_priolist from a .csv textscan to the struct-array priolist
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

  for n = [1:length(cfg_priolist{1}(:,1))]                        % n = [1:amount of priolists]
    priolist{n}      = prototype_prioliststruct();
    priolist{n}.mode   = cfg_priolist{1}(n){1};         
    priolist{n}.prio = cfg_priolist{2}(n);          
  endfor
endfunction