function cospsi = getcospsi(G0, pv_angle,geo_b,geo_l, alpha, beta, delta, t) 
  % ======================================================================
  % !!! NOT YET IMPLEMENTED !!!
  % Syntax: cospsi = getcospsi(G0, pv_angle,geo_b,geo_l, alpha, beta, delta, t) 
  % Description:  converts global radiation vertical to earth surface to global radiation vertical on sloped surface
  % IN: G0:       Global radiation vertical on earth surface
  % IN: alpha:    Neigungswinkel gegen Horizontale in degree
  % IN: Phi:      geographische Breite in degree
  % IN: beta:     Azimutwinkel (Ost-West-Orientierung) (Empfangsfläche) in degree
  % IN: delta:    Deklination in degree
  % IN: t:        Stundenwinkel (Sonnenstand) in degree
  % OUT: Gg:      Global radiation vertical on sloped surface
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

  Phi = geo_b; 
  
% cospsi = (cos(alpha)*sin(beta)-sin(alpha)*cos(Phi)*cos(beta))*sin(delta)+((cos(alpha)*cos(Phi)+sin(alpha)*sin(Phi)*cos(beta))*cos(delta)*cos(t)+sin(alpha)*sin(beta)*cos(delta)*sin(t);
endfunction