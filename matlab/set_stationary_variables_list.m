function [ivar,vartan] = set_stationary_variables_list()
% This function builds a vector of indices targeting to the stationary
% variables in varlist.
% 
% INPUTS 
%   None.
%  
% OUTPUTS 
%   o ivar       [integer]  nvar*1 vector of indices (nvar is the number
%                           of stationary variables).
%   o vartan     [char]     array of characters (with nvar rows).
%
% ALGORITHM 
%   None.       
%
% SPECIAL REQUIREMENTS
%   None.

% Copyright (C) 2007 Dynare Team
%
% This file is part of Dynare.
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <http://www.gnu.org/licenses/>.

global options_ M_    
varlist = options_.varlist;
if isempty(varlist)
    varlist = options_.varobs;
    options_.varlist = varlist;
end
nvar = rows(varlist);
if ~isempty(options_.unit_root_vars)
    vartan = [];
    for i=1:nvar
        if isempty(strmatch(deblank(varlist(i,:)),options_.unit_root_vars,'exact'))       
            vartan = strvcat(vartan,varlist(i,:));
        end
    end
else
    vartan = varlist;
end
nvar = size(vartan,1);
ivar = zeros(nvar,1);
for i = 1:nvar
    ivar(i) = strmatch(deblank(vartan(i,:)),M_.endo_names,'exact');
end