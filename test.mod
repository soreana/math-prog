param N := 5;
set Vertices := (1..N);
set Edges := {(1,2),(1,3),(1,4),(2,4),(3,5),(2,5)};

var x{i in Vertices}, >= 0, <= 1, integer;
minimize obj: sum{i in Vertices} x[i];

condition_edge{(i,j) in Edges}: x[i] + x[j] >= 1;

solve;
printf{i in Vertices} "Vertex %d has value %d\n", i, x[i];
end;