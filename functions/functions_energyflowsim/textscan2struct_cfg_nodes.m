function node = textscan2struct_cfg_nodes (cfg_nodes) 
  % ======================================================================
  % Syntax: node = textscan2struct_cfg_nodes (cfg_nodes)
  % Description: Converts the configs cfg_nodes from a .csv textscan to the struct-array node
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

  for n = [1:length(cfg_nodes{1}(:,1))]                        % n = [1:amount of nodes]
    node{n}      = prototype_nodestruct();
    node{n}.id   = cfg_nodes{1}(n,1){1};         
    node{n}.link = cfg_nodes{1}(n,2){1};          
    node{n}.pmax = [cfg_nodes{2}(n,1:3)];  
    node{n}.qmax = [cfg_nodes{2}(n,4:6)]; 
  endfor
endfunction