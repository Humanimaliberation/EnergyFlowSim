function [pathdir] = change_savedir()
  % ======================================================================
  % Syntax: [pathdir] = change_savedir()   
  % Description: changes current directory (pwd) through user response, probably buggy when loading data afterwards without changing the current folder again
  %
  % OUT: pathdir: string
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

  disp('The current path to write datafiles is: ');
  disp(pwd);
  usrprmpt = input('Would you like to change the current directory? Y/N [N]: ','s');
  if (isempty(usrprmpt))
      usrprmpt = 'N';
  end
  if (usrprmpt == 'Y')
    pathdir = input('Please give a new absolute path: ','s');
  else
    pathdir = pwd;  
  endif  
endfunction