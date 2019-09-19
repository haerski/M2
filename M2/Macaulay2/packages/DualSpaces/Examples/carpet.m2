restart
needsPackage "NumericalAlgebraicGeometry"
debug loadPackage ("DualSpaces", Reload => true)
needsPackage "K3Carpets"
needsPackage "Bertini"

I = carpet(2,2, Characteristic => 0)
R = ring I

S = CC monoid R
K = sub(I, S)
J = sub(radical I, S)
nv = numericalIrreducibleDecomposition (J, Software => BERTINI)
pts = bertiniSample(20, first components nv)

numericalNoetherianOperators(I, pts, InterpolationDegreeLimit => 1, NoetherianDegreeLimit => 20)
noethOps I