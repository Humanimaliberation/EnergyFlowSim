function cpsuse = textscan2struct_cfg_cpsuse (cfg_cpsuse)
  % ======================================================================
  % Syntax: cpsuse = textscan2struct_cfg_cpsuse (cfg_cpsuse)
  % Description: Converts the configs cfg_cpsuse from a .csv textscan to the struct-array cpsuse
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

  for n = [1:length(cfg_cpsuse{1}(:,1))]                        % n = [1:amount of usage timeintervals]
    cpsuse{n}       = prototype_cpsusestruct();
    cpsuse{n}.info  = cfg_cpsuse{1}(n,1){1}; 
    cpsuse{n}.id    = cfg_cpsuse{1}(n,2){1};
    cpsuse{n}.mode  = cfg_cpsuse{1}(n,3){1};
    cpsuse{n}.w0    = cfg_cpsuse{2}(n,1);
    cpsuse{n}.wmax  = cfg_cpsuse{2}(n,2);
    cpsuse{n}.t0    = cfg_cpsuse{2}(n,3);
    cpsuse{n}.tT    = cfg_cpsuse{2}(n,4);
  endfor
endfunction
