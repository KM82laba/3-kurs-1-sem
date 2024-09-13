#include <iostream>
#include <Windows.h>
using namespace std;


int main()
{
	time_t t;
	tm tm;
	setlocale(LC_ALL, "Russian");
	time(&t);
	localtime_s(&tm, &t);
	cout << "Дата и время"<< endl << "дд.мм.ггг чч:мин:сек." << endl;
	printf(
		"%d.%d.%d %d:%d:%d",
		tm.tm_mday,
		tm.tm_mon + 1,
		tm.tm_year + 1900,
		tm.tm_hour,
		tm.tm_min,
		tm.tm_sec
	);
}