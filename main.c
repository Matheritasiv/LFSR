#include<stdio.h>
#include<stdlib.h>
#include<time.h>

extern __uint64_t lfsr_64(__uint64_t);
static __uint64_t seed = 1;

static __uint64_t rand64(void)
{
	return seed = lfsr_64(seed);
}

static void srand64(__uint64_t s)
{
	if (s) {
		seed = s;
	} else {
		free((void *)(seed = (__uint64_t)malloc(0)));
		seed ^= (__uint64_t)time(NULL);
		seed |= 1L<<63;
	}
}

int main(int argc, char *argv[])
{
	srand64(0);
	for (int i = 8; i > 0; i--)
		printf("0x%016lX\n", rand64());
	return 0;
}
