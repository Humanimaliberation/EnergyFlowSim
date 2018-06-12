function nodestruct = prototype_nodestruct()
  % ======================================================================
  % Syntax: nodestruct = prototype_nodestruct()
  %
  % Description: Defines a struct variable to describe a node. Each field contains 
  % default variables, some with different datatypes. The struct ist expandable with 
  % additional fields. Variable calls by methods from core fields are not affected.
  %
  % OUT: nodestruct: struct() containing the fields 
  % {'id','link','pmax','qmax','p','q'}
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
  
  % NODE STRUCTURE
  % static fields
  nodestruct.id = {''};               % string, name of node
  nodestruct.link = {''};             % string array, name(s) of connected node(s)
  nodestruct.pmax = {[0,0,0]};        % numeric (3x1), max. sum of active power [kW]
                                      % on each phase of every connected CPS-unit
  nodestruct.qmax = {[0,0,0]};        % numeric (3x1), max. sum of raective power [kvar] 
                                      % on each phase of every connected CPS-unit

  % dynamic fields
  nodestruct.p = {[0,0,0]};           % numeric (3x1), sum of active power [kW]
                                      % on each phase of every connected CPS-unit
  nodestruct.q = {[0,0,0]};           % numeric (3x1), sum of reactive power [kW]
                                      % on each phase of every connected CPS-unit

endfunction