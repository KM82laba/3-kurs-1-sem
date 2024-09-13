#include <Windows.h>
#include <iostream>
#include <ctime>
using namespace std;



int main() {
	setlocale(LC_ALL, "Russian");
	long long it = -60 * 10000000;
	HANDLE htimer = CreateWaitableTimer(NULL, FALSE, L"OS07_04");
	if (!SetWaitableTimer(htimer, (LARGE_INTEGER*)&it, 60000, NULL, NULL, FALSE))
		throw "E: SetWaitableTimer ";

	LPCWSTR path = L"C:\\Education\\3 kurs 1 sem\\OS\\lab 7\\OS07\\OS07\\x64\\Debug\\OS07_04X.exe";

	PROCESS_INFORMATION pi1, pi2;
	clock_t start = clock();
	pi1.dwThreadId = 1; pi2.dwThreadId = 2;
	{
		STARTUPINFO si; ZeroMemory(&si, sizeof(STARTUPINFO)); si.cb = sizeof(STARTUPINFO);
		CreateProcess(path, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si, &pi1) ?
			cout << "Процесс номер 1\n" : cout << "Ошибка 1го процесса\n";
	}
	{
		STARTUPINFO si; ZeroMemory(&si, sizeof(STARTUPINFO)); si.cb = sizeof(STARTUPINFO);
		CreateProcess(path, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si, &pi2) ?
			cout << "Процесс номер 2\n" : cout << "Ошибка 2го процесса\n";
	}

	WaitForSingleObject(pi1.hProcess, INFINITE);
	WaitForSingleObject(pi2.hProcess, INFINITE);

	CloseHandle(htimer);
	cout << "Время прохождения: " << (clock() - start) / CLOCKS_PER_SEC << " с.\n";
	system("pause");
	return 0;
}