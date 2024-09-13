#include <iostream>
#include <Windows.h>



int main()
{
	int pid = GetCurrentProcessId();
	HANDLE event = OpenEvent(EVENT_ALL_ACCESS, FALSE, L"OS06_05");

	WaitForSingleObject(event, INFINITE);
	SetEvent(event);
	for (int i = 1; i <= 90; i++)
	{
		printf("B\t Nomer %d Process %d\n", i, pid);
		Sleep(100);
	}

	CloseHandle(event);
}