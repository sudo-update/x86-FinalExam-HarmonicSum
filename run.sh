# name stuff
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
#Assemble Control.asm
nasm -f elf64 -l Control.lis -o Control.o Control.asm
#Compile Display.cpp
g++ -c -Wall -m64 -no-pie -o Display.o Display.cpp
#Assemble Fill.asm
nasm -f elf64 -l Fill.lis -o Fill.o Fill.asm
#Assemble Sum.asm
nasm -f elf64 -l Harmonic_mean.lis -o Harmonic_mean.o Harmonic_mean.asm
#Compile Main.c
gcc -c -Wall -m64 -no-pie -o Main.o Main.c -std=c11

g++ -c -Wall -m64 -no-pie -g -o isfloat.o isfloat.cpp


#Link the object files using the g++ linker
g++ -m64 -no-pie -o FinalExam.out Main.o Harmonic_mean.o Fill.o Display.o Control.o isfloat.o
#Run the program SumArray:
./FinalExam.out
