.PHONY= all clean

CC := gcc

LINKERFLAG = -lm

all: CMS

CMS: CMS.o 
	${CC} -o CMS CMS.c

CMS.o: CMS.c
	${CC} -c CMS.c

clean:
	@echo "Cleaning Up..."
	rm -rvf CMS.o CMS CMS.out a.out *.dat 

