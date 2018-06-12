function sums = sumstructarray(structarray, field, idxarray)
  % ======================================================================
  % Syntax: sums = sumstructarray(structarray, field, idxarray)
  % Description: sum of fieldvalues of elements of structarray with indices of idxarray
  %
  % IN: structarray: array of struct elements
  % IN: field: string with fieldname of struct
  % IN: idxarray:  
  % OUT: sums: numeric value with dimensions of field-values
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

  sums = [0,0,0]; 
  for m = idxarray
    sums = sums + getfield(structarray{m},field);
  endfor
endfunction

