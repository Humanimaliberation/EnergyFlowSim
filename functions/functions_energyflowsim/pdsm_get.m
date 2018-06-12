  function pdsm = pdsm_get (cps, node, nodestruct_id)
    % ======================================================================
    % Syntax: pdsm = pdsm_get (cps, node, nodestruct.id)
    % Description: calculates powerdemand pdsm (1x3) for every phase at specified node
    % to keep planned power within transmission limits between nodes
    % 
    % IN: cps: structure array of variable length with elements of structure cps
    % IN: node:structure array of variable length with elements of structure node
    % IN: nodestruct.id: string equivialent to fieldvalue .id of one structure array element of node
    % OUT: pdsm: scalar (1x3) active power demand for every phase
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


    idxcpsnode = findidxstructarray(cps,'node',nodestruct_id); % indices for cps at node n1
    psumnode = sumstructarray(cps, 'p', idxcpsnode); % (3x1) sum of planned power at node n1
    pdsm = [0,0,0];
    
    if or(node{1}.pmax(1) < psumnode(1), node{1}.pmax(2) < psumnode(2), node{1}.pmax(3) < psumnode(3))
      pdsm = node{1}.pmax - psumnode;   % pos. power demand pdsm at n1
      
    elseif or(-node{1}.pmax(1) > psumnode(1), -node{1}.pmax(2) > psumnode(2), -node{1}.pmax(3) > psumnode(3))
      pdsm = -node{1}.pmax - psumnode;  % neg. power demand pdsm at n1
      
    endif
  endfunction