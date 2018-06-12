function idxstructarray = findidxstructarray(structarray, structfield, fieldvalue) 
  % ======================================================================
  % Syntax: idxstructarray = findidxstructarray(structarray, field, value)
  % Description: find indices for structarray to elements which field-value is equal to argument value
  %
  % IN: structarray: array with structure elements with variable length
  % IN: structfield: string with the name of the struct-field
  % IN: fieldvalue: either a string or a numeric (array)
  % OUT: idxstructarray: array with indices to structarray elements
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

  idxstructarray = [];
  N = length(structarray);  
  if isa(fieldvalue,'char')
    for n = [1:N]
      if strcmp(getfield(structarray{n}, structfield), fieldvalue)
        idxstructarray = [idxstructarray, n];
      endif
    endfor    
  else % if value is a numeric
    for n = [1:N]
      if getfield(structarray{n}, structfield) == fieldvalue
        idxstructarray = [idxstructarray, n];
      endif
    endfor    
  endif  
endfunction  