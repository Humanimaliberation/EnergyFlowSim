function cps = nominalpowerset_buffer(cpsin,cpsuse)
  % NOTES: Does not include possibility of more then a single PV plant and buffer battery
  % Does not work without PV plant or without buffer battery 
  % Needs cps{}.id and related cpsuse{}.mode 'PV' for PV and 'PB' for buffer battery

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
  
  % indices for battery buffer PB (german "Puffer Batterie")
  idx_cpsuse_pb = findidxstructarray(cpsuse,'mode','PB');             % index cpsuse PB
  idx_cps_pb = findidxstructarray(cps,'id',cpsuse{idx_cpsuse_pb}.id); % index cps PB
    
  % power demand for maximal energy autarky
  pdsm = 0 - sumstructarray (cps,'p',[1:length(cps)]); 
  
  % manage batterybuffer in case of over or under supply? 
  if sum(pdsm) != 0
    % set planned power of battery buffer
    cps = dsmrel(cps, idx_cps_pb, pdsm);    
  endif
  
endfunction
  