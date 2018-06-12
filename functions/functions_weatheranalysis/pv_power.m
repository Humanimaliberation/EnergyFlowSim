function [Wpv] = pv_power(G0,Pstc,cos_psi) 
  % ======================================================================
  % Syntax: [Wpv] = pv_power(G0,Pstc,cos_psi) 
  % Description: converts global radiation in Js/cm^2 vertical on ground surface 
  % to PV energy in kWh according to PV plant peak power and radiation angle psi
  %
  % IN: G0:     numeric global radiation energy in Wh/m^2, radiated verticular on ground surface
  % In: Pstc:   scalar in Wp
  % In: cos_psi: scalar in degree
  % OUT: Wpw:  numeric PV energy gain in kWh
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
  
  % Umrechnung von Geokoordinaten, WOZ, GZ, Tag in Neigungswinkel 
  G0 = G0*(100/60)^2;         % 1 J/cm^2 = (100/60)^2 Wh/m^2
  Gg = G0*cos_psi; 
  Gstc = 1000;                % 1000 W/m^2 global radiation under standard testic conditions (STC) 
  Wpv = Pstc*Gg/(Gstc);       % zugehörige Einheiten: Wh = W * (Wh/m^2) / (W/m^2)
endfunction