function txtscn = textscan_cfg(filename, subdir, format, delimiter, headerlines)
  % ======================================================================
  % Syntax: txtscn = textscan_cfg(filename, subdir, format, delimiter, headerlines)
  % Description: open file and reads content with command textscan
  % 
  % IN: filename : name of configfile with file extension
  % IN: subdir : name of subdirectory with configfile
  % IN: format: string with datatype format of columns e.g. '%s%s %f%f%f %f%f%f'
  % IN: delimiter: string e.g. ';' as delimiter
  % IN: headerlines: scalar as number of HeaderLines
  % OUT: txtscn: textscan of inputfile
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

  fid = fopen(fullfile(subdir,filename),'rt'); % file identifier
  txtscn = textscan(fid, format, 'Delimiter',delimiter, 'CollectOutput',true, 'HeaderLines',headerlines); % cell-array with all data from file
  fclose(fid);
endfunction