function idx24h = dtstr2idx24h (dtstr, frmt_dtstr, dtnumarray) 
  % ======================================================================
  % Syntax: idx24h = dtstr2idx24h (dtstr, frmt_dtstr, dtnumarray) 
  % Description: compares datestring input argument with elements of datenum-array with 24h steps input argument and outputs the index to the element of datenum-array which is equivalent to datestring argument input
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

idx_24h = 1 + datenum(dtstr,frmt_dtstr,) - dtnumarray(1);
endfunction