@echo off
chcp 65001 > nul 2>&1
echo -- строка параметров: %*
echo -- режим: %1
echo -- имя файла: %2


:: Справка при отсутствии параметров
if "%1" equ "" ( 
	echo ---++  z03-06 режим файл
	echo ---++  режим = {создать, удалить}
	echo ---++  файл  = имя файла
	goto EXIT
)

:: Ошибка при неверном режиме работы
if not "%1" equ "удалить" if not "%1" equ "создать" if not "%1" equ "" (
	echo ---+ режим задан некорректно
	goto EXIT
)

:: Ошибка при отсутствии файла в режиме "удалить"
if "%1" equ "удалить" if not "%1" equ "" if not "%2" equ "" if not exist "%2" (
	echo ---+ файл %2 не найден
	goto EXIT
)

:: Ошибка при существовании файла в режиме "создать"
if "%1" equ "создать" if exist "%2" (
	echo ---+ файл %2 уже существует
	goto EXIT
)

:: Ошибка при верном режиме и отсутствии имени файла
if "%1" equ "удалить" if "%2" equ "" (
	echo ---+ не задано имя файла
	goto EXIT
)
if "%1" equ "создать" if "%2" equ "" (
	echo ---+ не задано имя файла
	goto EXIT
)



:: Обработка верной команды создать
if "%1" equ "создать" (
	copy /y NUL %2 >NUL
	echo ---+ файл %2 создан
)

:: Обработка верной команды удалить
if "%1" equ "удалить" (
	del "%2"
	echo ---+ файл %2 удален
)



:EXIT
pause