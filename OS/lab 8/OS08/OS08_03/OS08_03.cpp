#include <iostream>
#include <Windows.h>
using namespace std;
#define KB (1024)
#define MB (1024 * KB)
#define PG (4 * KB)


void saymem()
{
    MEMORYSTATUS ms;
    GlobalMemoryStatus(&ms);
    cout << "общаяя Физ:  " << ms.dwTotalPhys / KB << " KB\n";
    cout << "доступ физ:  " << ms.dwAvailPhys / KB << " KB\n";
    cout << "общая вирт:  " << ms.dwTotalVirtual / KB << " KB\n";
    cout << "доступ вирт: " << ms.dwAvailVirtual / KB << " KB\n\n";
}
int main()
{
    setlocale(LC_ALL, "ru");
    int pages = 256;
    int countItems = pages * PG / sizeof(int);
    SYSTEM_INFO system_info;
    GetSystemInfo(&system_info);

    cout << "\tВ системе\n";
    saymem();
    cout << "============================================================\n";
    LPVOID xmemaddr = VirtualAlloc(NULL, pages * PG, MEM_COMMIT, PAGE_READWRITE); 
    cout << "\tВыделено " << pages * PG / 1024 << " KB вирт. памяти\n";
    saymem();
    cout << "============================================================\n";
    int* arr = (int*)xmemaddr;
    for (int i = 0; i < countItems; i++)
        arr[i] = i;

    int* byte = arr + 234 * 1024 + 3774;

    cout << "\tЗначение памяти в байте: " << *byte <<"///////////"<< byte << "\n";

    VirtualFree(xmemaddr, NULL, MEM_RELEASE) ? cout << "Виртуальная память освобождена\n" : cout << "\tВиртуальная память не освобождена\n";
    saymem();
    //отладка , память 
}