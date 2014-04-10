# TODO List

## commands

nchoosek binomial

taylor

isinf for oo,zoo, also symum unittext
 isnan(double(sym('NaN'))) fails but nan works


## assumptions

http://docs.sympy.org/dev/modules/assumptions/assume.html

You can define integers at creation:

>>> x, y, z, t = symbols('x y z t')
>>> k, m, n = symbols('k m n', integer=True)
>>> f, g, h = symbols('f g h', cls=Function)

>>> x = Symbol('x', real=True, positive=True)

In Matlab's SMT, assumptions effect expressions already defined.  This seems a bit at odds with Sympy (also c.f., global_assumptions).  The easier approach is to put them in Symbol()



## Global assumptions don't apply "automatically"?


from sympy.assumptions.assume import global_assumptions
from sympy import Q
GA = global_assumptions
x = sp.Symbol('x')

In [23]: sp.sqrt(x**2)
Out[23]: sqrt(x**2)

GA.add(Q.positive(x))

In [29]: sp.sqrt(x**2)
Out[29]: sqrt(x**2)

In [31]: sp.refine(sp.sqrt(x**2))
Out[31]: x

## Assumptions on variables in the constructor

This works well.  But how to map this onto the assume() and
alsoAssume() commands?  Proposal: set assume to generate help text and
a warning.  And extend the constructor instead to work like sympy...



## equality

MST: ==, define equations, equality test only when both sides become double
SymPy: relationalequality, eq()

MST: logical(), "structural" equivalence
SymPy: ==

MST: isAlways(), "mathematical" equivalence
SymPy: bool(LHS.expand() == RHS.expand())
> If .expand() does not help, try simplify(), trigsimp(), etc, which
> attempt more advanced transformations. For example,
[https://github.com/sympy/sympy/wiki/Faq]


## double

python generates C "%a" formatting:

  0.11 -> '0x1.c28f5c28f5c29p-4'

java might work, or write some custom code.  In first instance, I'll
use a string with many digits but it would be good to pass the
bit-exact double precision value back from sympy.


## symfuns, DE solving

symfun: probably this is:

f = Function('f')

todo: can't pickle f (!)   solution seems to be to use "dill".

## matrices

Fundamental choice:
(1) make a matrix array of sym objects; or
(2) use sp.Matrix in sympy.

(1+) seems easy to start with
(1-) but then sin(x) for example will need to call sin for each entry

(2-) requires some effort for functions:  A.applyfunc(sp.sin)
(2+) renders nicely already

essential issue is that scalars are not (1,1) matrices in sympy.
Could do that but, e.g., diff might not work... well we could just
generate the code to make it work.

% size.m:
function b = size(x)
  b = 6



## converting to .m function

matlabFunction() in SMT is convenient.  Parse from string?

TODO: perhaps we want a "filter" method that runs after each return
from sympy on the .text field: convert "oo" to "inf", "Abs -> abs",
etc.


## bugs

potential: double values are passdd directly to python in many spaces: potential problems with not going thru sym constructor

e.g., check what SMT does here
 symsum(pi,n,1,10)
 symsum(pi,n,1,inf)   [error]

probably such fcns should sym()

how about python comand defaults to syming arugements

Sympy: S(zoo) should be inf?

sympy: nan==nan returning True sounds about given == symantics, but Eq(nan,nan) giving True seems undesirable.

parsing errors in octave: need to test on 3.8

## IPC

Currently we have two approaches implemented:

* Using system()

* Using popen2().  Octave has this but it might be unix-specific.


There are quite a few options out there:

* http://code.google.com/p/python-matlab-wormholes/

* http://algoholic.eu/matpy/

* Jython: very promising as there is already a rsympy: sympy in R using this.

* http://stackoverflow.com/questions/1707780/call-python-function-from-matlab?rq=1



## Limitations of system()

Currently we create a temporary file and execute it with system().
Would be nicer to pass the command itself on the command line with
"python -c".  But I couldn't make this work with multiline pickles.

* http://stackoverflow.com/questions/11392033/passing-python-array-to-bash-script-and-passing-bash-variable-to-python-functio

* http://stackoverflow.com/questions/2043453/executing-python-multi-line-statements-in-the-one-line-command-line

* http://superuser.com/questions/607367/raw-multiline-string-in-bash