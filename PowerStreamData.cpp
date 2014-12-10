#include <iostream>

using namespace std;

const int SIZE = 1 << 30;

double A[SIZE];
double B[SIZE];

int main(){
	__protected_store_stream_set(FORWARD, &a, 0);
	//__protected_stream_count_depth(SIZE*sizeof(double)/128, DEEPER, 0);
	__protected_stream_count_depth(1023, DEEPER, 0);
	__protected_stream_set(FORWARD, &b, 1);
	__transient_protected_stream_count_depth(1023, DEEPER, 1);
	eieio();
	__protected_stream_go();
	
	for(int i = 0; i < 10; i++)
		for(int j = 0; j < SIZE; j++){
			A[i] += B[i];
		}

	return 0;
}