function pn = nominalpowerget(cps_element, cpsuse_element, t)
  % ======================================================================
  % Syntax: pn = nominalpowerget(cpsuse_element, cps_element, t)
  % Description: Determine nominal power load for charging electric vehicle (cps_element) according to a usecasese (cpsuse_element) current time (t)
  %
  % IN: cps_element: struct as in prototype_cpsstruct()
  % IN: cpsuse_element: struct as in prototype_cpsusestruct()
  % IN: t: current time in h of a day  
  % OUT: pn: (1x3) numeric matrix with nominal power in the same unit as Pmax or Pmin or W*dt for every phase
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
  
  % short names for input variables and abstracted variables from input variables
  dt = cpsuse_element.tT/100 - t +1;        % estimated usetime in hours
  Pmax = cps_element.pmax;                  % maximal brutto charging power
  Pmin = cps_element.pmin;                  % unused, not yet implemented
  phasenmask = Pmax > [0,0,0];
  Wrest = cps_element.wmax - cps_element.w; % required energy for 100% SoC
  eta = cps_element.eta;                    % efficiency eta(1) for positive power, 
                                            % eta(2) for negative power and 
                                            % eta(3) for energy degradation
  
  % default planned power zero
  pn = [0,0,0];                             % initialize nominal power with zeros
  
  % set planned power pn
  if cpsuse_element.t0/100 < t && t <= cpsuse_element.tT/100
    
    for phase = [1:3]
      switch(cpsuse_element.mode)
          % maximal charging full
          case 'SofoL'
              % continous charging near 100 % SoC
              if sum(Pmax) > Wrest/eta(1)
                pn(phase) = phasenmask(phase)*Wrest/(eta(1)*sum(phasenmask)); 
                  
              % maximal charging        
              elseif sum(Pmax) < Wrest/eta(1)
                pn(phase) = Pmax(phase);                
              endif
        
          % continuous charging full
          case 'KontL' 
            % continous charging to 100 % SoC
            pn(phase) = phasenmask(phase)*Wrest/(dt*eta(1)*sum(phasenmask));  

            % maximal charging if continous charging would be outer limits          
            if pn(phase) > Pmax(phase)
              pn(phase) = phasenmask(phase)*Pmax(phase);  % maximal charging when not enough time for 100 percent SoC
            endif  

          % flexible charging full (identical to conintuous charging 'KontL')
          case 'FlexL'                                                   
            % continous charging to 100 % SoC
            pn(phase) = phasenmask(phase)*Wrest/(dt*eta(1)*sum(phasenmask));  

            % maximal charging if continous charging would be outer limits          
            if sum(pn) > sum(Pmax)
              pn(phase) = Pmax(phase);  % maximal charging when not enough time for 100 percent SoC
            endif  

          % puffer battery charging
          case 'PB'
            pn = [0,0,0];
            
      endswitch  
      
    endfor  

  endif  

endfunction