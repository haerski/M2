-- -*- coding: utf-8 -*-
newPackage(
     "NumericalHilbert",
     PackageExports => {"DualSpaces"},
     Version => "0.3", 
     Date => "September 19, 2019",
     Authors => {{Name => "Robert Krone", 
    	       Email => "krone@math.gatech.edu"}},
     Headline => "numerically compute local dual space and Hilbert functions"
)

export { }

protect \ {
    Igens,
    syl,
    strategy,
    deg,
    dBasis,
    hIgens,
    BMintegrals,
    BMcoefs,
    BMbasis,
    Seeds
    }

print "warning: NumericalHilbert is depracated, use DualSpaces"

end

