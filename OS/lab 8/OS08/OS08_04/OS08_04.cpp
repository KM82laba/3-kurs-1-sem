#include <iostream>
#include <Windows.h>
using namespace std;

void HeapInfo(HANDLE pheap)
{
    PROCESS_HEAP_ENTRY phe;
    phe.lpData = NULL;
    while (HeapWalk(pheap, &phe))
    {
        cout << hex << phe.lpData
            << ", Размер = " << dec << phe.cbData
            << ((phe.wFlags & PROCESS_HEAP_REGION) ? " R" : "") // начало непрерывной области
            << ((phe.wFlags & PROCESS_HEAP_UNCOMMITTED_RANGE) ? " U" : "") // нераспределенная область
            << ((phe.wFlags & PROCESS_HEAP_ENTRY_BUSY) ? " B" : "") // распределенная область
            << "\n";
    }
    std::cout << "======================================================\n\n";
}
void PHeapInfo(HANDLE pheap)
{
    PROCESS_HEAP_ENTRY phe;
    phe.lpData = NULL;

    // Переменные для отслеживания размеров
    SIZE_T totalSize = 0;
    SIZE_T allocatedSize = 0;
    SIZE_T uncommittedSize = 0;

    while (HeapWalk(pheap, &phe))
    {
        totalSize += phe.cbData;

        if (phe.wFlags & PROCESS_HEAP_ENTRY_BUSY)
        {
            // Это распределенная область
            allocatedSize += phe.cbData;
        }
        else if (phe.wFlags & PROCESS_HEAP_UNCOMMITTED_RANGE)
        {
            // Это нераспределенная область
            uncommittedSize += phe.cbData;
        }

    }

    cout << "======================================================\n";
    cout << "Общий размер кучи: " << totalSize << " байт\n";
    cout << "Размер распределенных областей: " << allocatedSize << " байт\n";
    cout << "Размер нераспределенных областей: " << uncommittedSize << " байт\n\n";
}
int main()
{
    setlocale(LC_ALL, "ru");
    HANDLE pheap = GetProcessHeap();
    PHeapInfo(pheap);
   
    int size = 300000;
    int* m = new int[size];
    
    PHeapInfo(pheap);
    //const SIZE_T initialHeapSize = 4 * 1024 * 1024;  // 4 MB
    //HANDLE customHeap = HeapCreate(HEAP_NO_SERIALIZE | HEAP_ZERO_MEMORY, initialHeapSize, 0);

    //HeapInfo(customHeap);

    //int* largeArray = (int*)HeapAlloc(customHeap, HEAP_NO_SERIALIZE | HEAP_ZERO_MEMORY, 4 * 1024 * 1024);

    //HeapInfo(customHeap);
    // почему с кучами так С использованием функции SetThreadStackGuarantee.
}