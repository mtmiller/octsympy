function S = symprod(f,n,a,b)
%SYMPROD   symbolic product
%   todo: symprod(f, [a b])
%   todo revisit witn sympy 0.7.5:
% symprod(q,n,1,oo )
% ans = [sym] q**oo
% 0^oo
% ans = [sym] 0

  %if (nargin == 3)
  %  n = symvar

  cmd = [ '(f,n,a,b) = _ins\n'  ...
          'S = sp.product(f,(n,a,b))\n'  ...
          'return (S,)' ];
  S = python_cmd (cmd, sym(f), sym(n), sym(a), sym(b));

