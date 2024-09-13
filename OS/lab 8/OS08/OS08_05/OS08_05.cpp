#include <iostream>
#include <Windows.h>
using namespace std;
#define KB (1024)



void sh(HANDLE pheap)
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
	// Параметры пользовательской кучи:
	// 1. доступ не синхронизирован
	// 2. куча заполняется нулями
	// 3. начальный размер 4 мб
	// 4. конечный размер ограничен размером виртуальной памяти
	setlocale(LC_ALL, "ru");
	HANDLE heap = HeapCreate(HEAP_NO_SERIALIZE | HEAP_ZERO_MEMORY, 4096 * 1024, 0);
	sh(heap);

	int* x1 = (int*)HeapAlloc(heap, HEAP_NO_SERIALIZE | HEAP_ZERO_MEMORY, 300000 * sizeof(int));//динамического выделения блока памяти из кучи процесса
	cout << "\nАдрессс = " << x1 << "\n\n";
	sh(heap);

	HeapFree(heap, HEAP_NO_SERIALIZE, x1);
	
	HeapDestroy(heap);
}