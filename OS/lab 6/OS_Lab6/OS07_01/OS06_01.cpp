#include <iostream>
#include <ctime>
#include <Windows.h>

DWORD WINAPI A();
DWORD WINAPI B();

void LockSemaph();
void UnlockSemaph();

int check = 0;

int main() {
	DWORD AId = NULL, BId = NULL;
	HANDLE hA = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)A, NULL, 0, &AId);
	HANDLE hB = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)B, NULL, 0, &BId);

	WaitForSingleObject(hA, INFINITY);
	WaitForSingleObject(hB, INFINITY);
	CloseHandle(hA);
	CloseHandle(hB);

	system("pause");
	return 0;
}

DWORD WINAPI A() {
	int start = clock();

	LockSemaph();
	for (int i = 0; i < 5; i++) {
		std::cout << "F thread Number " << i << "|| Vremia posle starta: " << clock() - start << std::endl;
		Sleep(1);
	}
	UnlockSemaph();

	return 0;
}

DWORD WINAPI B() {
	int start = clock();

	LockSemaph();
	for (int i = 0; i < 5; i++) {
		std::cout << "S thread Number " << i << " || Vremia posle starta: " << clock() - start << std::endl;
		Sleep(1);
	}
	UnlockSemaph();

	return 0;
}

void LockSemaph() { // Проверка и установка бита
	_asm {
	CriticalSection:
		lock bts check, 0;
		jc CriticalSection
	}
}

void UnlockSemaph() { //Проверка и сброс бита
	_asm lock btr check, 0
}