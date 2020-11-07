restart
needsPackage "NoetherianOperators"
-- Example 2.2
R = QQ[x,y]
n = 4
I = ideal((x+y+1)^n)
noetherianOperators(I, Strategy => "MacaulayMatrix")
noetherianOperators(I, Strategy => "MacaulayMatrix", DependentSet => {R_1})

-- Example 3.16
x = symbol x;
R = QQ[x_1..x_3]
Q = ideal((x_1^2 - x_3)^2, x_2 - x_3 * (x_1^2 - x_3))
P = radical Q
noetherianOperators(Q,P, Strategy => "MacaulayMatrix")

-- Example 3.16, through punctual Hilbert scheme
y = symbol y;
F = frac(R/P)
S = F[y_1,y_2]
gamma = map(S,R, {y_1 + x_1, y_2 + x_2, x_3})
I = gamma Q
zeroDimensionalDual(origin S, I)
-- or
noetherianOperators(Q, Strategy => "PunctualHilbert")

-- Example 4.2
R = QQ[t,x,y]
I = ideal(x^2 - t*y, y^2)
-- Symbolic version
netList noetherianOperators(I, Strategy => "MacaulayMatrix", DependentSet => {x,y})

-- numerical version
pts = toList(1..6) / (i -> matrix{{i_CC, 0, 0}})
nops = pts / (p -> numericalNoetherianOperators(I, p, DependentSet => {x,y}, DegreeLimit => 5));
netList (nops / (n -> n.Ops))
-- interpolating e.g. last coefficient
vals = {1/6,1/3,1/2,2/3, 5/6, 1} -- coefficient in _dx^3
ts = {matrix{{1}},matrix{{2}},matrix{{3}},matrix{{4}},matrix{{5}},matrix{{6}}} -- corresponding value of t
S = RR[t]
numBasis = denBasis = basis(0,1,S)
rationalInterpolation(ts, vals, numBasis, denBasis) -- output is in the form (numerator, denominator)
-- hence we conclude that the coefficient of dx^3 is t/6

-- The procedure above is automated in numericalNoetherianOperators
needsPackage "NumericalAlgebraicGeometry"
needsPackage "Bertini"
R = CC[t,x,y]
I = ideal(x^2 - t*y, y^2)
nv = first components numericalIrreducibleDecomposition(I, Software => BERTINI)
numericalNoetherianOperators(I, nv, DependentSet => {x,y})

-- Example 4.4 is in the file ex44.m2
-- Example 4.5 is in the file ex45.m2