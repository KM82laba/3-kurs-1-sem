#include <iostream>
#include <cstdlib>
#include "Windows.h"
#include <locale>

using namespace std;

DWORD intToProcessPriority(int i) {
	switch (i) 
	{
	case 1: return IDLE_PRIORITY_CLASS;
	case 2: return BELOW_NORMAL_PRIORITY_CLASS;
	case 3: return NORMAL_PRIORITY_CLASS;
	case 4: return ABOVE_NORMAL_PRIORITY_CLASS;
	case 5: return HIGH_PRIORITY_CLASS;
	case 6: return REALTIME_PRIORITY_CLASS;
	default: throw "Неизвстный класс приоритетов процессора";
	}
}

int main(int argc, char* argv[])
{
	std::locale::global(std::locale(""));
	
	try 
	{
			HANDLE processHandle = GetCurrentProcess();
			DWORD_PTR pa = NULL, sa = NULL, icpu = -1;
			char buf[66];
			int parm1;
			int parm2;
			int parm3;
			cin >> parm1 >> parm2 >> parm3 ;
			if (!GetProcessAffinityMask(processHandle, &pa, &sa)) 
				throw "Error in GetProcessAffinityMask";
			cout << "\t\tДо:\n";
			_itoa_s(pa, buf, sizeof(buf), 2); // Используем _ui64toa_s для вывода 64-битного значения
			cout << "Маска привязки процесса: " << buf << endl;
			_itoa_s(sa, buf, sizeof(buf), 2); // Используем _ui64toa_s для вывода 64-битного значения
			cout << "Маска привязки системы: " << buf << endl;

			if (!SetProcessAffinityMask(processHandle, parm1)) 
				throw "ERROR in SetProcessAffinityMask";
			if (!GetProcessAffinityMask(processHandle, &pa, &sa)) 
				throw "Error in GetProcessAffinityMask";

			cout << "\t\tПосле:\n";
			_itoa_s(pa, buf, 2);
			cout << "Маска привязки процесса: " << buf << endl;
			_itoa_s(sa, buf, 2);
			cout << "Маска привязки процесса: " << buf << endl;
				
			_itoa_s(parm1, buf, 2);
			cout << "Приоритет первого: " << parm2 << endl;
			cout << "Приоритет второго: " << parm3 << endl;

			LPCWSTR path1 = L"C:\\Education\\3 kurs 1 sem\\OS\\lab 5\\OS_Lab5\\x64\\Debug\\OS05_02x.exe";
			LPCWSTR path2 = L"C:\\Education\\3 kurs 1 sem\\OS\\lab 5\\OS_Lab5\\x64\\Debug\\OS05_02x.exe";

			STARTUPINFO si1, si2;
			PROCESS_INFORMATION pi1, pi2;

			ZeroMemory(&si1, sizeof(STARTUPINFO));
			ZeroMemory(&si2, sizeof(STARTUPINFO));
			si1.cb = sizeof(STARTUPINFO);
			si2.cb = sizeof(STARTUPINFO);

			if (CreateProcess(path1, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE | intToProcessPriority(parm2), NULL, NULL, &si1, &pi1))
				cout << "Процесс 1 создан\n";
			else cout << "Ошибка\n";

			if (CreateProcess(path2, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE | intToProcessPriority(parm3), NULL, NULL, &si2, &pi2))
				cout << "Процесс 2 создан\n";
			else cout << "Ошибка\n";

			WaitForSingleObject(pi1.hProcess, INFINITE);
			WaitForSingleObject(pi2.hProcess, INFINITE);

			CloseHandle(pi1.hProcess);
			CloseHandle(pi2.hProcess);
		
	}
	catch (string err) 
	{
		cout << err << endl;
	}
	system("pause");
}
//65535