function cellarr = structarrfield2cellarr(structarray,field)
  % ======================================================================
  % Syntax: cellarr = structarrfield2cellarr(structarray,field)
  % Description: transfors the field values of all elements of structarray to a cell array
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

  cellarr = {};
  for i = [1:length(structarray)];
    cellarr = [cellarr, getfield(structarray{i},field)];
  endfor
endfunction

