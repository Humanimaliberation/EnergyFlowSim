function [idxneg, idxnegall, avg, avgpos, avgall, avgposall] = average_more (dataarray,idxstart,idxend)
  % ======================================================================
  % syntax: [idxneg, idxnegall, avg, avgpos, avgall, avgposall] = average_more (dataarray,idxstart,idxend) 
  % Description: berechnet den Durschnitt eines Datenarrays mit oder ohne negativen Werten über das gesamte Datenarray oder ein bestimmtes Interval
  %
  % IN: dataarray: skalares Array variabler Länge
  % IN: idxstart: Startindex des zu untersuchenden Intervals (inklusive diesem beginnend)
  % IN: idxend: Endindex des zu untersuchenden Intervals (inklusive diesem aufhörend)
  % OUT: idxneg: 
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

% Indizes:
  idxnegall = find(dataarray(:) < 0)+0; % Index negativer Werte in dataarray
  idxnegall = idxnegall';               % changing format from vertical to horizontal array
  idxneg = find(dataarray(idxstart:idxend) < 0)+idxstart-1; % Index negativer Werte im Interval bezogen auf dataarray
% idxall = :
  idx = (idxstart:idxend);  
% Anzahl an Werten
  n_negall = length(idxnegall);      % Anzahl negativer Werte in dataarray
  n_neg = length(idxneg);            % Anzahl negativer werte in dataarray in spezifischem Interval
  nall = length(dataarray);          % Anzahl aller Werte in dataarray
  n = length(idx);                   % Anzahl Werte in dataarray in speziefischem Interval
% Summen  
  summposall = sum(dataarray(:)) - sum(dataarray(idxnegall));         % Summe aller positiver Werte
  summpos = sum(dataarray(idxstart:idxend)) - sum(dataarray(idxneg)); % Summe positiver Werte in spez. Interval
  summall = sum(dataarray(:));                                        % Summe aller Werte
  summ = sum(dataarray(idxstart:idxend));                             % Summe Werte in spez. Interval
% Durchschnittswerte  
  avgposall = summposall/(nall - n_negall) % Durschnitt aller positiver Werte
  avgall = summall/(nall); % Durchschnitt aller Werte
  avgpos = summpos/(n - n_neg); % Durchschnitt aller positiver Werte in spez. Interval
  avg = summ/n; % Durchschnitt aller Werte in spez. Interval 
endfunction 