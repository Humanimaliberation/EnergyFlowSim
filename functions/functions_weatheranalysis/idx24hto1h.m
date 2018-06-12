function idx1h = idx24hto1h(idx24h,dtnum_24hstrt,dtnum_1hstrt,frmt_time)
  % ======================================================================
  % Syntax: idx1h = idx24hto1h(idx24h,dtnum_24hstrt,dtnum_1hstrt,frmt_24htime) 
  % Description: converts an index to a day in a 24h dataset to an index to the first hour of the same day in a 1h dataset
  % 
  % In: idx24h:        scalar index in 24h dataset
  % In: dtnum_24hstrt: datenum of start date in 24h dataset
  % In: dtnum_1hstrt:  datenum of start date in 1h dataset
  % In: frmt_time:     string with time format of dataset with lower resolution
  % Out: idx1h:        scalar index in 1h dataset
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

  dtnum_1hstrt = datenum(datestr(dtnum_1hstrt,frmt_time),frmt_time); % cut out hours
  dtnum_24hstrt = datenum(datestr(dtnum_24hstrt,frmt_time),frmt_time); % cut out hours
  idx1h = (dtnum_24hstrt + idx24h - dtnum_1hstrt)*24-23; % dtnum_1hstrt + idx1h = dtnum_24hstrt + (idx24h / 24)
endfunction