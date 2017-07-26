param N := 5; # number of instances

set instances :=  (1..N);
set instanceCpuCapacity;
set maxInstance;
set cpuRequired;

var x { i in instances} >=0, integer;
var y {j in instanceCpuCapacity} >= 0 , integer;

maximize obj: sum{i in instances} x[i];
condition_edge {i in instances , j in instanceCpuCapacity}: x[i] <= y[j];
#condition_edge {i in instances }: x[i] <= y[i];

condition_2 {j in instanceCpuCapacity}: y[j] = j;

#maximize obj : condition_3 {i in instances}: x[i];

#condition_edge{(i,j) in Edges}: x[i] + x[j] >= 1;
#
#subject to constraint2:
#sum{n in instances} x[n] <= 1;
#
#
solve;
printf {i in instances} "instances %d has value %d \n", i, x[i];
printf {i in instanceCpuCapacity} "instanceCpuCapacity %d has value %d \n", i, y[i];

data;
set maxInstance := 2 3 5 ;
set cpuRequired := 3 2 1 ;
set instanceCpuCapacity := 4 5 6 7 8;

end;