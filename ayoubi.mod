
set N;						#network nodes
printf{i in N}:  "%d\n",i;
set L within N cross N;				#definition of links
set Flow;					#flows
set M;						#VNF types
set mInstance;

param procCap{m in M} >=0;			#proccessing capacity of VNF type m 
param demandResource{m in M} >=0;		#the resource demand of VNF type m 
param maxInstance{m in M} >=0;			#the maximum number of instances allowed for any VNF type m
param capacity{n in N} >=0;			#the capacity of substrate node n
param bandwith{(i,j) in L} >=0;			#the capacity of node between i , j
param sequence{f in Flow};			#the sequence of VNF types


set E; 				

###########################################
#
#	VARIABLES
#
###########################################

#var instanceAssignment{mInstance, M ,N} binary;						#if instance k of m is placed on n
#var flowAssignment{f in Flow ,mInstance,m in M ,n in N} binary;				#if f is assigned instance k of type m on n
#
#
#var flowAddmition{Flow} binary;								#if flow f is admitted
#var routed{E,Flow,N,N} binary;								#if e ∈ E f is routed through link ( i , j )
#
#var traffic {N,N};									#indicates the amount of traffic measured on link ( i , j )
#
#var demandBandwidth{Flow} ; 								#bandwith needed for flow f
#
#
#
##########################################
#
# 	CONSTRAINTS
#
##########################################
#
#subject to constraint2
#{m in M,k in mInstance }:
#	sum{n in N} instanceAssignment[k,m,n] <= 1;
#
#subject to constraint3
#{m in M}:
#	sum {k in mInstance } sum { n in N} instanceAssignment[k,m,n] <= mInstance[m];
#
#subject to constraint4
#{n in N}:
#	sum{m in M} sum {k in mInstance } instanceAssignment[k,m,n] * demandResource[m] <= capacity[n];
#
#subject to constraint5				#this needs some
#{f in Flow,m in sequence[f],n in N,k in maxInstance[m]}:
#	flowAssignment[f,k,m,n] <= instanceAssignment[k,m,n];
#
#subject to constraint6
#{m in sequence[f] , f in Flow}:
#	sum {n in N} sum {k in maxInstance[m]} flowAssignment[f,k,m,n] <= 1;
#
#subject to constraint7
#{m in M,k in maxInstance[m]}:
#	sum{f in Flow} sum{n in N} flowAssignment[f,k,m,n] * demandBandwidth[f] <= procCap[m];
#
#subject to constraint8
#{k in maxInstance[m],m in M , n in N}:
#	sum{f in Flow}flowAssignment[f,k,m,n] >= instanceAssignment[k,m,n];
#
#subject to constraint9
#{f in Flow , i in N , e in E[f]}:
#	sum{(i,j) in L } routed[e,f,i,j] - sum{(j,i) in L}routed[e,f,i,j] = sum{k in maxInstance[m]}flowAssignment[f,k,o[e],n] - sum{k in maxInstance[m]}flowAssignment[f,k,d[e],n];
#
#subject to constraint10
#{(i,j) in L}:
#	traffic[i,j] = sum{f in Flow}sum{e in E[f]} routed[e,f,i,j]*demandBandwidth[f];
#
#
#subject to constraint11
#{[i,j] in L}:
#	traffic[i,j] <= bandwith[i,j];
#
#subject to constraint12
#{f in Flow}:
#	flowAddmition[f] *  abs(sequence[f]) = sum{m in sequence[f]}sum{k in maxInstance[m]}sum{n in N}flowAssignment[f,k,m,n];
#
#
#var res = sum{f in Flow} flowAddmition[f];
#maximize result: res;

solve;
printf {i in procCap} "Vertex %d has value %d\n",i, procCap[i];
end;

