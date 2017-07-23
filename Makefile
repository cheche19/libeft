OPTS = -Wall -g -mfma -march=native -D EFT_FMA -flto -ffat-lto-objects -Ofast

all: qual

qual: testCxx testC testF
	./qual.py

testCxx: testCxx.cxx libeft.a
	g++ $(OPTS) $< -left -L. -o $@

testC: testC.c libeft.a
	gcc $(OPTS) $< -left -L. -o $@

testF: testF.f90 libeft.mod libeft.a
	gfortran $(OPTS) $< -left -L. -o $@

libeft.a: libeft.o
	gcc-ar rcs $@ $^

libeft.mod: libeft_f.f90
	gfortran $(OPTS) -c $<

%.o: %.cxx
	g++ $(OPTS) -c $<

clean:
	$(RM) *.o *.mod *.a essai *~ callgrind.out.*