----------------------------
-- The granddaddy node -----
----------------------------

document { "Mathematical Overview",
     "In this section we give a comprehensive overview of the main 
     mathematical types of Macaulay 2, their construction and most common
     operations. WARNING: this overview is currently under construction.",
     UL {
	  TO "rings",
	  TO "ideals",
	  TO "matrices",
	  TO "substitution and maps between rings",
	  SEQ ("modules",
	       UL {
		    SEQ (TO "modules: part I", " -- getting started"),
		    SEQ (TO "modules: part II", " -- homological and multilinear algebra")
		    }
	       ),
	  TO "Groebner bases and related computations",
	  TO "chain complexes",
	  TO "varieties",
	  TO "using external libraries",
	  SEQ ("specialized routines",
	       UL {
		    TO "commutative algebra",
		    TO "algebraic geometry"
		    }
	       )
	  }
     }

----------------------------
-- Top level nodes ---------
----------------------------

document { "rings",
     HEADER2 "An overview",
     "Macaulay 2 differs from computer algebra systems such as maple and
     mathematica, in that rings are first class objects.  This means that
     before making polynomials or matrices, you must create a ring where
     you give the variables that you want, and the kinds of coefficients
     you want (e.g. rational numbers, or integers modulo a prime number).",
     UL {
	  SEQ (TO "basic rings",
	       UL {
		    TO "finite fields"
		    }
	       ),
	  SEQ (TO "polynomial rings",
	       UL {
		    TO "monomial orderings",
		    TO "quasi- and multi-graded polynomial rings",
		    TO "quotient rings",
		    TO "manipulating polynomials",
		    TO "factoring polynomials"
		    }
	       ),
	  SEQ ("fields",
	       UL {
		    TO "finite fields, part II",
		    TO "fraction fields",
		    TO "finite field extensions"
		    }
	       ),
	  SEQ ("other algebras",
	       UL {
		    TO "exterior algebras",
		    TO "symmetric algebras",
		    TO "tensor products of rings",
		    TO "Weyl algebras",
		    SEQ (TO "Schur rings", 
			 " -- monomials represent irreducible representations of GL(n)"),
		    TO "associative algebras"
		    }
	       )
       },
      "For additional common operations and a comprehensive list of all routines
     in Macaulay 2 which return or use rings, see ", TO "Ring", "."
     }

document { "ideals",
     HEADER2 "An overview",     
     "In Macaulay 2, once a ring (see ",TO "rings", 
     ") is defined, ideals are constructed in the usual way
     by giving a set of generators.",
     UL {
	  TO "creating an ideal",
	  SEQ ("conversions",
	       UL {
		    TO "ideals to and from matrices",
		    NOCONTENTS TO "ideals to and from modules"
		    }
	       ),
	  SEQ ("basic operations on ideals",
	       UL {
		    TO "sums, products, and powers of ideals",
		    TO "equality and containment",
		    TO "extracting generators of an ideal",
		    TO "dimension, codimension, and degree"
		    }
	       ),
	  SEQ ("components of ideals",
	       UL {
		    TO "intersection of ideals",
		    TO "ideal quotients and saturation",
		    TO "radical of an ideal",
		    TO "minimal primes of an ideal",
		    TO "associated primes of an ideal",
		    TO "primary decomposition"
		    }
	       ),
	  NOCONTENTS TO "Groebner bases and related computations",
          },
     "For those operations where we consider an ideal as a module, such
     as computing Hilbert functions and polynomials, syzygies, free resolutions, see ",
     TO "modules: part I", ".",
     PARA,
      "For additional common operations and a comprehensive list of all routines
     in Macaulay 2 which return or use ideals, see ", TO "Ideal", "."
     }

///

This node is old -- is there anything we want to save from it?

document { "ideals",
     "An ideal ", TT "I", " is represented by its generators,
     which are stored inside it in a one-rowed matrix.",
     PARA,
     "The ideal generated by a list of ring elements can be constructed with the function
     ", TO "ideal", ".",
     EXAMPLE {
	  "R = ZZ/101[a..d];",
      	  "I = ideal (a^2*b-c^2, a*b^2-d^3, c^5-d)",
	  },
     "If you have a matrix, then ", TT "ideal", " will produce the ideal generated
     by the entries of the matrix.",
     EXAMPLE {
	  "f = matrix {{a^2,b^2},{c^2,d^2}}",
      	  "J = ideal f",
	  },
     "An interesting class of ideals can be obtained as the defining ideals in 
     projective space of monomial curves.  The twisted cubic is the closure of the
     set of points ", TT "(1,t^1,t^2,t^3)", " in projective space.  We use a list of
     the exponents and ", TO "monomialCurveIdeal", " to get the ideal.",
     EXAMPLE "monomialCurveIdeal(R,{1,2,3})",
     "The command ", TO "substitute", " can be used to transfer an ideal to another
     ring.  You may want to do this because another ring has a monomial ordering
     more suitable for the computations you are about to do, or it may have
     additional variables in it, one of which you wish to use for homogenization.
     Here is an example of the latter.  We make another ring with a new variable ", TT "t", "
     in it, transfer the ideal, and then homogenize the ideal.",
     EXAMPLE {
	  "S = ZZ/101[a..d,t];",
      	  "substitute(I,S)",
      	  "homogenize(oo,t)",
	  },
     NOINDENT, "In this case, the substitution was done according to the names of
     the variables in the two rings.  There are more explicit ways to specify the
     substitution to be performed.  Here is one where we list the new values for
     all the variables.",
     EXAMPLE {
	  "T = ZZ/101[x,y,z,t];",
	  "use ring I",
      	  "substitute(I,{a=>x^10,b=>y^10,c=>z^10,d=>t^10})",
	  },
     "Now notice that the variable ", TT "a", " appears to be an element of ", TT "S", ".
     The creation of the ring ", TT "S", " supplanted the earlier value.",
     EXAMPLE "a",
     "We restore the variables of ", TT "R", " to visibility.",
     EXAMPLE "use R",
     "To recover the generators of an ideal as a matrix, use ", TO "generators", ".",
     EXAMPLE "generators J",
     "Use the operator ", TT "%", " to reduce a ring element with respect to a
     Groebner basis of the ideal.",
     EXAMPLE "(1+a+a^3+a^4) % J",
     "Membership in the ideal may be tested by comparing the answer to 0 with ", TT "==", ".",
     EXAMPLE {
	  "(1+a+a^3+a^4) % J == 0",
      	  "a^4 % J == 0",
	  },
     PARA,
     "The usual algebraic operations on ideals are available.",
     EXAMPLE {
	  "I+J",
      	  "intersect(I,J)",
      	  "I*J",
      	  "J:I",
	  "saturate(J,I)",
      	  "radical J",
	  },
     "See also: ", TO "intersect", ", ", TO (symbol :, Ideal, Ideal), ",
     ", TO "saturate", ", and ", TO "radical", ".",
     PARA,
     "We may ask whether one ideal is contained in another.",
     EXAMPLE {
	  "isSubset(I,J)",
      	  "isSubset(I,I+J)",
      	  "isSubset(I+J,J)",
	  },
     "Once you have an ideal, then you may construct the quotient ring or the quotient
     module (there is a difference).  Here is the quotient ring.",
     EXAMPLE "R/I",
     "Here is the quotient module.",
     EXAMPLE "M = R^1/I",
     "And if you want the module underlying ", TT "I", " itself, you can get it with
     ", TO "module", ".",
     EXAMPLE "module I",
     "In general, when an ideal is used as an argument to a function that usually
     would be given a module, we try to make an informed choice about whether the user
     intends the ideal to be used as a module directly, or whether the quotient module
     is more suitable.  In homological functions such as ", TO "Ext", " and ", TO "Tor", "
     the underlying module is used.  Here are some examples where the quotient 
     module is used.",
     PARA,
     "A free resolution of ", TT "R^1/I", " can be obtained with ", TO "resolution", ".",
     EXAMPLE "resolution I",
     "The Krull dimension or codimension of the support of the quotient module can
     be obtained.",
     EXAMPLE {
	  "dim I",
      	  "dim J",
      	  "codim I",
	  },
     NOINDENT, "(Beware that for a homogeneous ideal the
     dimension of its projective variety is one less than the number provided by
     ", TO "dim", ".)",
     PARA,
     "If the dimension of the quotient module as a vector space is needed,
     use ", TO "basis", " to get a matrix whose columns form a basis, and compute
     the dimension from it.",
     EXAMPLE {
	  "basis (R^1/J)",
      	  "rank source oo",
	  },
     NOINDENT, "(Here ", TO "oo", " refers to the result on the previous line.",
     PARA,
     "For more information see ", TO "Ideal", "."
     }

///


document { "matrices",
     HEADER2 "An overview",     
     "In Macaulay 2, each matrix is defined over a ring, (see ", TO "rings", "). 
     Matrices are perhaps the most common data type in Macaulay 2.",
     UL {
	  SEQ ("making matrices", 
	       UL {
		    TO "input a matrix",
		    TO "random and generic matrices",
		    TO "concatenating matrices"
		    }
	       ),
	  SEQ ("operations involving matrices",
	       UL {
		    TO "simple information about a matrix",
		    TO "basic arithmetic of matrices",
		    TO "kernel, cokernel and image of a matrix",
		    TO "differentiation"
		    }
	       ),
	  SEQ ("determinants and related computations",
	       UL {
		    TO "rank of a matrix",
		    TO "determinants and minors",
		    TO "Pfaffians",
		    TO "exterior power of a matrix"
		    }
	       ),
	  SEQ ("display of matrices and saving matrices to a file",
	       UL {
		    TO "format and display of matrices in Macaulay 2",
		    TO "importing and exporting matrices"
		    }
	       )
	  },
     "For an overview of matrices as homomorphisms between modules, 
     see ", TO "modules: part I", ".  
     For additional common operations and a comprehensive list of all routines
     in Macaulay 2 which return or use matrices, see ", TO "Matrix", "."
     }

document { "substitution and maps between rings",
     HEADER2 "An overview",
     UL {
	  TO "substitute values for variables",
	  TO "working with multiple rings",
	  SEQ ("ring maps",
	       UL {
		    TO "basic construction, source and target of a ring map",
	       	    TO "evaluation and composition of ring maps",
		    TO "kernel and image of a ring map"
		    }
	       ),
	  },
      "For additional common operations and a comprehensive list of all routines
     in Macaulay 2 which return or use ring maps, see ", TO "RingMap", "."
     }
     
document { "modules: part I",
     HEADER2 "Getting started",
     UL {
	  SEQ ("construction of modules",
	       UL {
		    TO "free modules",
		    SEQ (TO "matrices to and from modules", " (including kernel, cokernel and image)"),
		    TO "ideals to and from modules"
		    }
	       ),
	  SEQ (TO "Hilbert functions and free resolutions",
	       UL {
		    "including degree and betti numbers"
		    }
	       ),
	  SEQ (TO "operations on modules",
	       UL {
		    "including direct sum, tensor products, and annihilators"
		    }
	       ),
	  SEQ (TO "homomorphisms (maps) between modules",
	       UL {
		    "including elements of modules"
		    }
--	       UL {
--		    TO "constructing maps between modules",
--		    TO "information about a map of modules",
--		    TO "kernel, cokernel and image of a map of modules"
--		    }
	       ),
--	  ("graded modules",
--	       UL {
--		    TO "degrees of elements and free modules",
--		    TO "degree and multiplicity of a module",
--		    TO "Hilbert functions and polynomials",
--		    TO "homogenization",
--		    TO "truncation and homogeneous components of a graded module"
--		    }
--	       ),
	  SEQ (TO "subquotient modules", " -- the way Macaulay 2 represents modules",
	       UL {
		    "Macaulay 2 has handed you a subquotient module.  What now?"
		    }
--	       UL {
--		    TO "what is a subquotient module?",
--		    TO "extracting parts of a subquotient module",
--		    TO "quotients of modules"
--		    }
	       )
	  },
     "See ", TO "modules: part II", " for more operations on modules."
     }

document { "modules: part II",
     UL {
	  SEQ ("multilinear algebra",
	       UL {
		    TO "exterior power of a module",
		    TO "Fitting ideals",
		    TO "adjoints of maps"
		    }
	       ),
	  SEQ ("homological algebra",
	       UL {
		    TO "Hom module",
		    TO "Tor and Ext"
		    },
	       "For more operations in homological algebra, see ", TO "chain complexes", "."
	       )
	  },
      "For additional common operations and a comprehensive list of all routines
     in Macaulay 2 which return or use modules, see ", TO "Module", "."
     }

document { "Groebner bases and related computations",
     HEADER2 "An overview",
     UL {
	  TO "what is a Groebner basis?",
	  TO "finding a Groebner basis",
	  TO "rings that are available for Groebner basis computations",
	  SEQ ("a few applications of Groebner bases",
	       UL {
		    TO "elimination of variables",
		    TO "Hilbert functions",
		    TO "syzygies",
		    TO "saturation",
		    TO "fibers of maps",
		    TO "solving systems of polynomial equations"
		    }
	       ),
	  TO "fine control of a Groebner basis computation"
	  }
     }

document { "chain complexes",
     HEADER2 "An overview",
     UL {
	  TO "free resolutions of modules",
	  TO "extracting information from chain complexes",
	  TO "making chain complexes by hand",
	  TO "manipulating chain complexes",
	  TO "maps between chain complexes"
	  },
      "For additional common operations and a comprehensive list of all routines
      in Macaulay 2 which return or use chain complexes or maps between chain complexes, see ", 
      TO "ChainComplex", " and ", TO "ChainComplexMap", ".",
     }

document { "varieties",
     HEADER2 "An overview",
     UL {
	  TO "algebraic varieties",
	  TO "coherent sheaves",
	  },
     "For details, see ", TO "Variety", ".",
     }

document { "using external libraries",
     UL {
     	  TO "loading a library",
     	  TO "how to get documentation on a library",
     	  SEQ ("available libraries",
	       UL {
	       	    SEQ (TO "blow ups", ""),
	       	    SEQ (TO "convex hulls and polar cones", " -- polarCone.m2"),
	       	    SEQ (TO "D-modules", " -- D-modules.m2"),
	       	    SEQ (TO "elimination theory", " -- eliminate.m2"),
	       	    SEQ (TO "graphing curves and surfaces via 'surf'", ""),
	       	    SEQ (TO "invariants of finite groups", " -- invariants.m2"),
	       	    SEQ (TO "Lenstra-Lenstra-Lovasz (LLL) lattice basis reduction", " -- LLL.m2"),
	       	    SEQ (TO "SAGBI bases", " -- sagbi.m2")
	       	    })
	  }
     }

----------------------------
-- Lead nodes --------------
----------------------------

document { "rings that are available for Groebner basis computations",
     "In Macaulay 2, Groebner bases can be computed for ideals and submodules over many
     different rings.",
     UL {
	  TO "over fields",
          TO "over the ring of integers",
          TO "over polynomial rings over a field",
	  TO "over polynomial rings over the integers",
	  TO "over Weyl algebras",
	  TO "over local rings"
     	  }
    }

-------------------
-- Ring nodes -----
-------------------

-------------------
-- ideal nodes ----
-------------------


-------------------
-- Matrix nodes ---
-------------------


-------------------
-- ring map nodes -
-------------------

-------------------
-- module nodes ---
-------------------


-------------------
-- GB nodes -------
-------------------


-------------------
-- library nodes --
-------------------

document { "loading a library",
     }

document { "how to get documentation on a library",
     }

document { "blow ups",
     }

document { "convex hulls and polar cones",
     }

document { "D-modules",
     }

document { "elimination theory",
     }

document { "graphing curves and surfaces via 'surf'",
     }

document { "invariants of finite groups",
     }

document { "Lenstra-Lenstra-Lovasz (LLL) lattice basis reduction",
     }

document { "SAGBI bases",
     }

-------------------
-- specialized   --
-------------------

document { "commutative algebra",
     TOC {
	  SECTION { "integralClosure",
	       },
	  SECTION { "primaryDecomposition",
	       },
	  SECTION { "symmetricAlgebra",
	       }
	  }
     }

document { "algebraic geometry",
     TOC {
	  SECTION { "cotangentSheaf",
	       }
	  }
     }

-- Local Variables:
-- compile-command: "make -C $M2BUILDDIR/Macaulay2/m2 "
-- End:
