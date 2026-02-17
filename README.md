### Подготовка

1. Установить dosbox https://sourceforge.net/projects/dosbox/files/dosbox/0.74-3/DOSBox0.74-3-win32-installer.exe/download
2. В DOSBox options config в секцию [autoexec] добавить

```conf
mount D <полный путь к папке с проектом> (например D:\project)
D:
set path=D:\tasm;%path%
cls
```

### Запуск лаб

#### Лаба 1

1. Перейти в директорию лабораторной cd lb1
2. Для запуска программы в обычном режиме прописать в консоли

```dos
run
```

3. Для запуска программы в режиме дебага прописать в консоли debug

```dos
debug
```
