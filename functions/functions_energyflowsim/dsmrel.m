function cps = dsmrel(cpsin, idxcps, pdsm) 
  % ======================================================================
  % Syntax: cps = dsmrel(cpsin, idxcps, pdsm)
  % Description: adjust planned power for indexed CPS-units symetrical on each 
  % connected phase equally relativ to their potential power regulation according 
  % to power demand pdsm
  %
  % IN: cpsin: struct array of variable length with field definitions like prototype cpsstruct
  % IN: idxcps: array of variable length with indices for cps
  % IN: pdsm: numeric array (3x1) with active power demand on each phase 
  % OUT: cps: identical to cpsin with partly overwritten fieldvalues .p of array elements
  %
  % Note: power on each phase is equal to eachother or zero (symetrical load on all connected phases)
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
      
  % INITALISATION FOR ALL CPS-UNITS
  cps = cpsin;
  ppotpos_sum = [0,0,0];        % pos. potential power regulation of indexed CPS-units
  ppotneg_sum = [0,0,0];        % neg. potential power regulation of indexed CPS-units
  
  % GET POS. AND NEG. POTENTIAL POWER REGULATION FOR INDEXED CPS-UNITS
  for i = idxcps
    
    % mask for connected phases of CPS-unit
    for phase = [1:3]
      mask{i}(phase) = (cps{i}.pmax(phase) - cps{i}.pmin(phase)) != 0; % connected?     
    endfor

    % maximal power to fully charge buffer (100 % SoC)
    psum_max_w{i} = 0;
    pmax_w{i} = [0,0,0];
    
    if cps{i}.eta(1) > 0
      psum_max_w{i} = (cps{i}.wmax - cps{i}.w) / cps{i}.eta(1); % max. power sum (100% SoC)
      
      % max. power (100 % SoC) on each phase
      for phase = [1:3]
        pmax_w{i}(phase) = mask{i}(phase)*psum_max_w{i}/sum(mask{i});
      endfor      
    endif
    
    % minimal power to fully discharge buffer (0 % SoC)
    psum_min_w{i} = 0;
    pmin_w{i} = [0,0,0];
    
    if cps{i}.eta(2) > 0
      psum_min_w{i} = (0 - cps{i}.w) * cps{i}.eta(2);     % min. power sum (0 % SoC)      
      
      % min. power (0 % SoC) on each phase 
      for phase = [1:3]
        pmin_w{i}(phase) = mask{i}(phase)*psum_min_w{i}/sum(mask{i});
      endfor
    endif    
  
    % potential power regulation (positive and negative) by power limits
    ppotpos_p{i} = cps{i}.pmax - cps{i}.p; 
    ppotneg_p{i} = cps{i}.pmin - cps{i}.p;   
    
    % potential power regulation (positive and negative) by energy limits
    ppotpos_w{i} = pmax_w{i} - cps{i}.p;
    ppotneg_w{i} = pmin_w{i} - cps{i}.p;

    % resulting pos. and neg. potential power regulations by power and energy limits 
    ppotpos{i} = min(ppotpos_p{i}, ppotpos_w{i});
    ppotneg{i} = max(ppotneg_p{i}, ppotneg_w{i}); 

    % sum of pos. and neg. potential power regulation of indexed CPS-units  
    ppotpos_sum = ppotpos_sum + ppotpos{i};
    ppotneg_sum = ppotneg_sum + ppotneg{i};
  endfor

  % ADJUST POWER DEMAND FOR INDEXED CPS-UNITS TO MANAGEBLAE POWER RREGULATION
  for phase = [1:3]
    if pdsm(phase) > ppotpos_sum(phase)
      pdsm = ppotpos_sum;
    elseif pdsm(phase) < ppotneg_sum(phase)
      pdsm = ppotneg_sum;
    endif 
  endfor
  
  % GET ASYMETRIC AND SYMETRIC CORRECTIVE SUMMAND AND APPLY FOR INDEXED CPS-UNITS
  for i = idxcps
    % initialize asymetric corrective summand for power correction on each phase
    C_asym_neg{i} = [0,0,0];    % asymetric corrective summand for negative powerdemand
    C_asym_pos{i} = [0,0,0];    % asymetric corrective summand for positive powerdemand
    C_asym_min{i} = 0;          % min. asym. neg. corr. summ. 
    C_asym_max{i} = 0;          % max. asym. pos. corr. summ.
    C_sym_neg{i} = 0;           % negative symetric corrective summand
    C_sym_pos{i} = 0;           % positive symetric corrective summand
    
    % get asymetric corrective summand for power correction on each phase
    for phase = [1:3]                                
      % asymetric corrective summand for negative powerdemand
      if ppotneg_sum(phase) != 0
        C_asym_neg{i}(phase) = pdsm(phase)*ppotneg{i}(phase)/ppotneg_sum(phase); 
      endif
      
      % asymetric corrective summand for positive powerdemand
      if ppotpos_sum(phase) != 0
        C_asym_pos{i}(phase) = pdsm(phase)*ppotpos{i}(phase)/ppotpos_sum(phase); 
      endif
      
      C_asym_min{i} = min(C_asym_min{i}, C_asym_neg{i}(phase));      % min. asym. neg. corr. summ.  
      C_asym_max{i} = max(C_asym_max{i}, C_asym_pos{i}(phase));      % max. asym. pos. corr. summ.
    endfor
         
    % get symetric corrective summand for power correction on each phase
    for phase = [1:3]
      C_sym_pos{i}(phase)  = mask{i}(phase)*C_asym_max{i};         % pos. sym. corrective summand
      C_sym_neg{i}(phase)  = mask{i}(phase)*C_asym_min{i};         % neg. sym. corrective summand           
    endfor
 
    % apply symetric corrective summand for power correction on each phase
    if sum(pdsm) >= 0
      cps{i}.p = cps{i}.p + C_sym_pos{i};                          % apply corrective summand
    elseif sum(pdsm) < 0
      cps{i}.p = cps{i}.p + C_sym_neg{i};                          % apply corrective summand
    endif   
      
  endfor
  
endfunction      