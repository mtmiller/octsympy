function z = power(x, y)
%.^  Componentwise exponentiation

  cmd = [ '(x,y) = _ins\n'                                    ...
          'if x.is_Matrix and y.is_Matrix:\n'                 ...
          '    # FIXME need a copy?\n'                         ...
          '    for i in range(0, len(x)):\n'                  ...
          '        x[i] = x[i]**y[i]\n'                       ...
          '    return ( x ,)\n'                               ...
          'if x.is_Matrix and not y.is_Matrix:\n'             ...
          '    return ( x.applyfunc(lambda a: a**y) ,)\n'     ...
          'if not x.is_Matrix and y.is_Matrix:\n'             ...
          '    return ( y.applyfunc(lambda a: x**a) ,)\n'     ...
          'else:\n'                                           ...
          '    return ( x**y ,)' ];

  z = python_cmd(cmd, sym(x), sym(y));
