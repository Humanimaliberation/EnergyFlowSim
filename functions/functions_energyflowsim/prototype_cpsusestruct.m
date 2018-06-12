function cpsusestruct = prototype_cpsusestruct()
  % ======================================================================
  % Syntax: cpsusestruct = prototype_cpsusestruct()
  %
  % Description: Defines a struct variable to describe a usecase for a CPS-unit. Each 
  % field contains default variables, some with different datatypes. The struct ist 
  % expandable with additional fields. Variable calls by methods from core fields are 
  % not affected.
  %
  % OUT: nodestruct: struct() containing the fields {'info','id','mode','w0','wmax',t0','tT'}
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
                                        
  % CPSUSE STRUCTURE
  cpsusestruct.info = '';     % string, additional information
  cpsusestruct.id   = '';     % string, name of CPS-units
  cpsusestruct.mode = '';     % string, type of usecase e.g. 'KontL' for continuously charging
  cpsusestruct.w0   = 0;      % scalar, initial energy at start time t0
  cpsusestruct.wmax = 0;      % scalar, maximal energy (SoC 100 %)
  cpsusestruct.t0   = 0;      % scalar, start time, 
  cpsusestruct.tT   = 0;      % scalar, end time
endfunction
