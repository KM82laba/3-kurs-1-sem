#include <Windows.h>
#include <iostream>
#include <ctime>
using namespace std;


int main()
{
	clock_t start = clock();
	int k = 0;
	bool flag5 = true, flag10 = true;
	setlocale(LC_ALL, "Russian");
	while (true)
	{
		k++;
		if ((clock() - start) / CLOCKS_PER_SEC == 5 && flag5) {
			cout << "Номер итерации после 5 с.: " << k << '\n';
			flag5 = false;
		}
		if ((clock() - start) / CLOCKS_PER_SEC == 10 && flag10) {
			cout << "Номер итерации после 10 с.: " << k << '\n';
			flag10 = false;
		}
		if ((clock() - start) / CLOCKS_PER_SEC == 15) {
			cout << "Номер итерации после 15 с.: " << k << '\n';
			break;
		}
	}

	return 0;
}