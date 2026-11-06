c:
	gcc -lm -O3 -o dirty30_c dirty30.c

cpp:
	g++ -std=c++20 -O3 dirty30.cpp -o dirty30_cpp

d:
	dmd -O -release -of="dirty30_d" dirty30.d

nim:
	nim compile -d:release -o:dirty30_nim dirty30.nim

v:
	v -prod -o dirty30_v dirty30.v
