﻿#include <iostream>
#include <Windows.h>
using namespace std;
DWORD pid = NULL;




DWORD WINAPI ChildThread_T1()
{
	DWORD tid = GetCurrentThreadId();

	for (short i = 1; i <= 50; ++i)
	{
		cout << "OS04_03_T1 process = " << pid << " potok= " << tid << "\n";
		Sleep(750);
	}
	return 0;
}




DWORD WINAPI ChildThread_T2()
{
	DWORD tid = GetCurrentThreadId();

	for (short i = 1; i <= 125; ++i)
	{
		cout << "OS04_03_T2 process = " << pid << " potok= " << tid << "\n";
		Sleep(750);
	}
	return 0;
}




int main()
{
	pid = GetCurrentProcessId();
	DWORD parentId = GetCurrentThreadId();
	DWORD childId_T1 = NULL;
	DWORD childId_T2 = NULL;
	HANDLE handleClild_T1 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)ChildThread_T1, NULL, 0, &childId_T1);
	HANDLE handleClild_T2 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)ChildThread_T2, NULL, 0, &childId_T2);


	for (short i = 1; i <= 100; ++i)
	{
		switch (i)
		{
			case 20: SuspendThread(handleClild_T1); break;
			case 60: ResumeThread(handleClild_T1);  break;
			case 40: SuspendThread(handleClild_T2); break;
			case 100: ResumeThread(handleClild_T2); break;
		}
		cout << "OS04_03 process = " << pid << " potok= " << parentId <<" number = " << i << "\n";
		Sleep(750);
	}


	WaitForSingleObject(handleClild_T1, INFINITE);
	WaitForSingleObject(handleClild_T2, INFINITE);
	CloseHandle(handleClild_T1);
	CloseHandle(handleClild_T2);
	system("pause");
	return 0;
}


//(Get-Process OS04_03).Threads