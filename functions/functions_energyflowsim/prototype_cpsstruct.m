function cpsstruct = prototype_cpsstruct()
  % ======================================================================
  % Syntax: cpsstruct = prototype_cpsstruct()
  %
  % Description: Defines a struct variable to describe a CPS-unit. Each field contains 
  % default variables, some with different datatypes. The struct ist expandable with 
  % additional fields. Variable calls by methods from core fields are not affected.
  %
  % OUT: cpsstruct: struct() containing the fields 
  % {'id','node','pmin','pmax','qmin','qmax','wmax','eta','prio','p','q','w'}
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

  % CPS STRUCTURE (consumer-producer-storage)
  % static fields
  cpsstruct.id   = '';            % string, name of CPS-units
  cpsstruct.node = '';            % string, name of connected node
  cpsstruct.pmin = [0,0,0];       % numeric (3x1), min. active power on phases [kW]
  cpsstruct.pmax = [0,0,0];       % numeric (3x1), max. active power on phases [kW]
  cpsstruct.qmin = [0,0,0];       % numeric (3x1), min. reactive power on phases [kvar]
  cpsstruct.qmax = [0,0,0];       % numeric (3x1), max. raective power on phases [kvar]
  cpsstruct.wmax = 0;             % numeric, netto battery capacity [kWh]
  cpsstruct.eta  = [0,0,0];       % numeric (3x1), power efficiencies eta(1), eta(2) 
  % and rate of energy degradation per hour eta(3) 
  % .w(t+1) = .eta(3)*.w(t) + .eta(1)*.p(t) with .p(t) > 0
  % .w(t+1) = .eta(3)*.w(t) + .eta(2)*.p(t) with .p(t) < 0 
  % efficiencies eta(1) for positive power, eta(2) for negative power
  % eta(3) as relative energydegradation per timeinterval
  
  % dynamic fields
  cpsstruct.prio = 0;           % scalar, priority
  cpsstruct.p = [0,0,0];        % numeric (3x1), sum of active power [kW]
                                % on each phase of every connected CPS-unit
  cpsstruct.q = [0,0,0];        % numeric (3x1), sum of reactive power [kW]
                                % on each phase of every connected CPS-unit
  cpsstruct.w = 0;              % scalar, netto capacity [kWh]
  
endfunction 