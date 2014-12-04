%% Copyright (C) 2014 Colin B. Macdonald
%%
%% This file is part of OctSymPy.
%%
%% OctSymPy is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published
%% by the Free Software Foundation; either version 3 of the License,
%% or (at your option) any later version.
%%
%% This software is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty
%% of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
%% the GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public
%% License along with this software; see the file COPYING.
%% If not, see <http://www.gnu.org/licenses/>.

%% -*- texinfo -*-
%% @deftypefn  {Function File} {@var{g} =} matlabFunction (@var{f})
%% @deftypefnx {Function File} {@var{g} =} matlabFunction (@var{f1}, ..., @var{fn})
%% @deftypefnx {Function File} {@var{g} =} matlabFunction (..., @var{param}, @var{value})
%% @deftypefnx {Function File} {@var{g} =} matlabFunction (..., 'vars', [@var{x} ... @var{z}])
%% @deftypefnx {Function File} {...} matlabFunction (..., 'file', @var{name})
%% @deftypefnx {Function File} {...} matlabFunction (..., 'outputs', [@var{o1} ... @var{on}])
%% Convert symbolic expression into a standard function.
%%
%% This is a synonym of: @xref{function_handle}
%%
%% @seealso{ccode, fortran, latex, function_handle}
%%
%% @end deftypefn

%% Author: Colin B. Macdonald
%% Keywords: symbolic

function f = matlabFunction(varargin)

  f = function_handle(varargin{:});

end


%!test
%! % autodetect inputs
%! syms x y
%! s = warning('off', 'OctSymPy:function_handle:nocodegen');
%! h = matlabFunction(2*x*y, x+y);
%! warning(s)
%! [t1, t2] = h(3,5);
%! assert(t1 == 30 && t2 == 8)
