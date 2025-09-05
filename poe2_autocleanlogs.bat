@echo off
chcp 65001 >nul  && cls  && echo off

:: Проверяем права админа
net session >nul 2>&1
if %errorLevel% neq 0 (
 echo Требуется запуск от имени администратора
 pause
 exit /b 1
)

:: Очистка логов при запуске
echo Начата очистка логов...
del /Q /F "C:\Program Files (x86)\Steam\steamapps\common\Path of Exile 2\logs\*.*"
if %errorLevel% equ 0 (
 echo Логи успешно очищены
) else (
 echo Ошибка при очистке логов
)

:: Создание задачи "Clear PoE2Logs" в планировщике
echo Создаем задачу для автоматической очистки...
schtasks /CREATE ^
 /TN "Clear PoE2Logs" ^
 /TR "cmd /c del /Q /F \"C:\Program Files (x86)\Steam\steamapps\common\Path of Exile 2\logs\*.*\"" ^
 /SC ONLOGON ^
 /RU SYSTEM ^
 /RL HIGHEST

if %errorLevel% equ 0 (
 echo Задача успешно создана
 echo Теперь папка с логами будет очищаться при каждом входе в систему
) else (
 echo Произошла ошибка при создании задачи
)

pause
