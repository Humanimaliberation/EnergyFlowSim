function cps = energyplugset (cpsin, cpsuse, t)
  % ======================================================================
  % Syntax: cps = energyplugset (cpsin, cpsuse, t)
  % Description: Sets energy .w of cps structure to zero if CPS is unplugged or sets .w to initial energy if plugged in both cases according to cpsuse
  %
  % IN: cpsin: structure array of variable length with elements of structure cps
  % IN: cpsuse: structure array of variable length with elements of structure cpsuse
  % IN: t: current time in h of a day
  % OUT: cps: structure array of variable length with elements of structure cps (edited form of input array if applicable else identical to input array)
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

  cps = cpsin;
  M = length(cps);                          % Amount of CPS-units

  % set energy according to cpsuse if CPS is plugged in
  for m = [1:M] 
    % set default value
    if !isfield(cps{m},'w')
      cps{m}.w    = 0;                      % set energy of unused CPS to zero
      cps{m}.wmax = 0;                    
    endif
    
    idx_cpsuse = findidxstructarray(cpsuse, 'id', cps{m}.id); % Amount of configured usage sequences for cps{m}  
    
    % check if plugged out
    for n = [idx_cpsuse]
      if cpsuse{n}.tT/100 +1 == t           % tT is the endtime ('HHMM'), t is the end of the current timeinterval of 1h length
        cps{m}.w    = 0;                    % reset energy to zero if CPS is unplugged
        cps{m}.wmax = 0;
      endif
      
    endfor 
    
    % check if plugged in
    for n = [idx_cpsuse] 
      if cpsuse{n}.t0/100 + 1 == t          % t0 is the starttime ('HHMM'), t is the end of the current timeinterval of 1h length
        cps{m}.w = cpsuse{n}.w0;            % set energy to initial value
        cps{m}.wmax = cpsuse{n}.wmax;
      endif
      
    endfor   
    
  endfor
  
endfunction