#include <iostream>
#include <cstdlib>
#include <intrin.h>
#include <iomanip>
#include "Windows.h"
using namespace std;
#include <locale>


void PrintProcessPriority(HANDLE processHandle)
{
	DWORD processPriority = GetPriorityClass(processHandle);

	switch (processPriority)
	{
	case IDLE_PRIORITY_CLASS:				cout << "Приоритет процесса:  IDLE_PRIORITY_CLASS\n";				break;
	case BELOW_NORMAL_PRIORITY_CLASS:		cout << "Приоритет процесса:  BELOW_NORMAL_PRIORITY_CLASS\n";		break;
	case NORMAL_PRIORITY_CLASS:				cout << "Приоритет процесса:  NORMAL_PRIORITY_CLASS\n";			break;
	case ABOVE_NORMAL_PRIORITY_CLASS:		cout << "Приоритет процесса:  ABOVE_NORMAL_PRIORITY_CLASS\n";		break;
	case HIGH_PRIORITY_CLASS:				cout << "Приоритет процесса:  HIGH_PRIORITY_CLASS\n";				break;
	case REALTIME_PRIORITY_CLASS:			cout << "Приоритет процесса:  REALTIME_PRIORITY_CLASS\n";			break;
	default:								cout << "[ОШИБКА] Неизвестный приоритет процесса.\n";					break;
	}
}




void PrintThreadPriority(HANDLE threadHandle)
{
	DWORD threadPriority = GetThreadPriority(threadHandle);

	switch (threadPriority)
	{
	case THREAD_PRIORITY_LOWEST:		cout << "Приоритет потока: THREAD_PRIORITY_LOWEST\n";			break;
	case THREAD_PRIORITY_BELOW_NORMAL:	cout << "Приоритет потока: THREAD_PRIORITY_BELOW_NORMAL\n";	break;
	case THREAD_PRIORITY_NORMAL:		cout << "Приоритет потока: THREAD_PRIORITY_NORMAL\n";			break;
	case THREAD_PRIORITY_ABOVE_NORMAL:	cout << "Приоритет потока: THREAD_PRIORITY_ABOVE_NORMAL\n";	break;
	case THREAD_PRIORITY_HIGHEST:		cout << "Приоритет потока: THREAD_PRIORITY_HIGHEST\n";			break;
	case THREAD_PRIORITY_IDLE:			cout << "Приоритет потока: THREAD_PRIORITY_IDLE\n";			break;
	default:							cout << "[ОШИБКА] Неизвестный приоритет потока.\n";					break;
	}
}




void PrintAffinityMask(HANDLE hp, HANDLE ht) {
	DWORD_PTR pa = 0, sa = 0, icpu = -1;

	if (!GetProcessAffinityMask(hp, &pa, &sa))
		throw "[FATAL] GetProcessAffinityMask threw an exception.";

	_ui64toa_s(pa, buf, sizeof(buf), 2); // Используем _ui64toa_s для вывода 64-битного значения
	cout << "Маска привязки процесса: " << buf;
	cout << " (" << showbase << hex << pa << ")\n";

	_ui64toa_s(sa, buf, sizeof(buf), 2); // Используем _ui64toa_s для вывода 64-битного значения
	cout << "Маска привязки системы: " << buf;
	cout << " (" << showbase << hex << sa << ")\n";

	SYSTEM_INFO sys_info;
	GetSystemInfo(&sys_info);
	cout << "Количество процессоров: " << dec << sys_info.dwNumberOfProcessors << "\n";
	icpu = SetThreadIdealProcessor(ht, MAXIMUM_PROCESSORS);
	cout << "Процессор потока: " << icpu << "\n";
}


int main()
{
	std::locale::global(std::locale(""));
	HANDLE processHandle = GetCurrentProcess();
	HANDLE threadHandle = GetCurrentThread();
	DWORD pid = GetCurrentProcessId();
	DWORD tid = GetCurrentThreadId();


	for (int i = 0; i < 1000000; i++)
	{
		if (i % 1000 == 0)
		{
			cout << "Номер:         " << i << "\n\n";
			cout << "Процесс: " << pid << "\n";
			cout << "Поток: " << tid << "\n";
			PrintProcessPriority(processHandle);
			PrintThreadPriority(threadHandle);
			PrintAffinityMask(processHandle, threadHandle);
			cout << "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n";
			Sleep(200);
		}
	}

	system("pause");
}