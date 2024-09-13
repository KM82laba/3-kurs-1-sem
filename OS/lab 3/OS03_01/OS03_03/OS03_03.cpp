#include <iostream>
#include <Windows.h>
#include <TlHelp32.h>
#include <iomanip>

int main()
{
    DWORD pid = GetCurrentProcessId();
    HANDLE snap = CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
    PROCESSENTRY32 peProcessEntry;
    peProcessEntry.dwSize = sizeof(PROCESSENTRY32);

    std::wcout << L"Current pid: " << pid << "\n";
    try
    {
        if (!Process32First(snap, &peProcessEntry)) throw L"Process32First";
        do
        {
            std::wcout << L"Name: " << peProcessEntry.szExeFile << "\n"
                << L"Pid: " << peProcessEntry.th32ProcessID << "\n"
                << L"Ppid: " << peProcessEntry.th32ParentProcessID << "\n";
            if (peProcessEntry.th32ProcessID == pid) std::wcout << "====> current process \n";
        } while (Process32Next(snap, &peProcessEntry));
    }
    catch (char* msg) {
        std::wcout << L"ERROR: " << msg << "\n";
    }
    system("pause");
    return 0;
}