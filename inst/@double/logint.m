%% Copyright (C) 2016-2017, 2019 Colin B. Macdonald
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
%% @documentencoding UTF-8
%% @defun logint (@var{x})
%% Numerical logint function.
%%
%% Example:
%% @example
%% @group
%% logint (1.1)
%%   @result{} ans = -1.6758
%% @end group
%% @end example
%%
%% @strong{Note} this function may be slow for large numbers of inputs.
%% This is because it is not a native double-precision implementation
%% but rather the numerical evaluation of the SymPy function
%% @code{li}.
%%
%% Note: this file is autogenerated: if you want to edit it, you might
%% want to make changes to 'generate_functions.py' instead.
%%
%% @seealso{@@sym/logint}
%% @end defun


function y = logint (x)
  if (nargin ~= 1)
    print_usage ();
  end
  cmd = { 'L = _ins[0]'
          'A = [complex(li(complex(x))) for x in L]'
          'return A,' };
  c = pycall_sympy__ (cmd, num2cell (x(:)));
  y = reshape (cell2mat (c), size (x));
end


%!test
%! x = 1.1;
%! y = sym(11)/10;
%! A = logint (x);
%! B = double (logint (y));
%! assert (A, B, -4*eps);

%!test
%! y = [2 3 sym(pi); exp(sym(1)) 5 6];
%! x = double (y);
%! A = logint (x);
%! B = double (logint (y));
%! assert (A, B, -4*eps);

%!test
%! % maple:
%! % > A := [1+2*I, -2 + 5*I, 100, 10*I, -1e-4 + 1e-6*I, -20 + I];
%! % > for a in A do evalf(Li(a)) end do;
%! x = [1+2i; -2+5i; 100; 10i; -1e-4 + 1e-6*1i; -20-1i];
%! A = [  1.3876787420229375511 + 2.5087546988592328752*1i
%!        1.6987684473874802274 + 4.5936366057115204667*1i
%!        30.126141584079629926
%!        3.4936715673748995398 + 5.5260023797127391973*1i
%!        0.90264689772681592152e-5 + 3.1415953634267361942*1i
%!       -2.3996350854560916779 - 7.6971739096353664559*1i ];
%! B = logint (x);
%! assert (A, B, -eps)

%!assert (logint (inf), inf)
%!assert (isnan (logint (-inf)))
