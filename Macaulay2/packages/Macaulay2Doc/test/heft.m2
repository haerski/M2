dgs = {{1, 0, 3, 6}, {1, 6, 7, 5}, {1, 7, 2, 2}, {1, 5, 0, 6}, {1, 8, 7, 5}, {1, 4, 6, 0}, {1, 3, 1, 0}}
R = QQ[a..g, Degrees => dgs]
heft R
assert( heft R == {1,0,0,0} )
