function cps = setcpsprio (cps, idxcps, cpsuse, priolist, t)
  % ======================================================================
  % Syntax: cps = setcpsprio (cps, idxcps, cpsuse, priolist, t)
  % Description: sets field-value prio for indexed (idxcps) elements of structarray cps according to cpsuse, priolist and timestep
  %
  % IN: priolist: structarray e.g. as example below
  %
  % example priolist:
  % priolist={};
  % priolist{1}.mode = 'PB';
  % priolist{1}.prio = 1;
  % priolist{2}.mode = 'FlexL';
  % priolist{2}.prio = 2;
  % priolist{3}.mode = 'KontL';
  % priolist{3}.prio = 3;
  % priolist{4}.mode = 'SofoL';
  % priolist{4}.prio = 3;
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
  
  % set priority for every CPS-unit
  for m = idxcps                                    
    cps{m}.prio = 0;                                        % reset priority to zero  
    
    % indices to cpsuse configs related to current CPS-unit
    idxcpsuse = findidxstructarray(cpsuse,'id',cps{m}.id);  % indices of cpcuse with .id equal to current cps .id
    
    for n = idxcpsuse                                       
      t0 = cpsuse{n}.t0/100 +1;                             % first active timeinterval
      tT = cpsuse{n}.tT/100;                                % last active timeinterval
    
      % cpsuse config active at current time?    
      if (t0 <= t && t <= tT)        
        % indices to priolist configs related to current cpsuse config
        idxpriolist = findidxstructarray(priolist,'mode',cpsuse{n}.mode);
        
        % set priorities according to mode and priolist
        for p = idxpriolist                      
          cps{m}.prio = priolist{p}.prio;                   % set .prio 
        endfor                                                                          
      
      endif
    
    endfor                                                         
  endfor
endfunction