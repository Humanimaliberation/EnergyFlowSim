function cps = textscan2struct_cfg_cps (cfg_cps) 
  % ======================================================================
  % Syntax: cps = textscan2struct_cfg_cps (cfg_cps)
  % Description: Converts the configs cfg_cps from a .csv textscan to the struct-array cps
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

  for n = [1:length(cfg_cps{1}(:,1))]                        % n = [1:amount of cps units]
    cps{n}      = prototype_cpsstruct();
    cps{n}.id   = cfg_cps{1}(n,1){1};         
    cps{n}.node  = cfg_cps{1}(n,2){1};          
    cps{n}.pmin = [cfg_cps{2}(n,1:3)];   
    cps{n}.pmax = [cfg_cps{2}(n,4:6)];  
    cps{n}.qmin = [cfg_cps{2}(n,7:9)];   
    cps{n}.qmax = [cfg_cps{2}(n,10:12)]; 
    cps{n}.wmax = cfg_cps{2}(n,13);
    cps{n}.eta  = [cfg_cps{2}(n,14:16)];      
  endfor
endfunction