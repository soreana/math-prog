set SLA;

set K;

param Deadline ;
param x{(i,j) in K};

subject to DLINE
    {i in SLA}: sum{t in K} x[i,t]=1 ;

data;

set SLA := A17  A18  A25 ;

set K:= 0..Deadline ;

param Deadline :=

A17  32
A18  40
A25  44 ;

end;