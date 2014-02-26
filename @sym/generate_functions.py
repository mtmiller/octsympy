#!/usr/bin/python

# Yo dawg, I heard you like code generation so I wrote a code
# generator to write your code generators!

# TODO: make a template which we process would be nicer than this

L = """
sqrt exp log
sin sinh asin asinh
cos cosh acos acosh
tan tanh atan atanh
csc csch acsc acsch
sec sech asec asech
cot coth acot acoth
floor ceil
"""

L = L.split();

for f in L:
    fname = '%s.m' % f;
    print fname

    fd = open(fname, "w")

    fd.write ("function z = %s(x)\n" % f)
    fd.write ("%");
    fd.write ("%s  Symbolic %s function\n" % (f.upper(),f))

    s = """%
%   Autogenerated, do not modify

  cmd = [ 'def fcn(ins):\\n'  ...
          '    (x,) = ins\\n'  ...
"""
    fd.write(s)
    fd.write("          '    y = sp.%s(x)\\n'  ...\n" % f)
    fd.write("          '    return (y,)\\n' ];\n")
    fd.write("\n");
    fd.write("z = python_sympy_cmd(cmd, x);\n\n");
    fd.close()


# Now make simple unit tests
for f in L:
    fname = '../unittests/test_%s.m' % f;
    print fname
    fd = open(fname, "w")
    fd.write ("function r = test_%s()\n" % f)
    fd.write ("%");
    fd.write ("TEST_%s  autogenerated test for symbolic %s\n" % (f.upper(),f))

    fd.write("  x = sym(1);\n")
    fd.write("  f1 = %s(x);\n" % f)
    fd.write("  f2 = %s(1);\n" % f)
    fd.write("  r = abs(double(f1) - f2) < 1e-15;\n\n")
    fd.close()

# Output list for .gitignore file
print "**** Optional: copy/paste to update this list in .gitignore ****"
for f in L:
    print "@sym/%s.m" % f;
for f in L:
    print "unittests/test_%s.m" % f;
