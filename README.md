# Домашнее задание к занятию "`Название занятия`" - `Фамилия и имя студента`


### Инструкция по выполнению домашнего задания

   1. Сделайте `fork` данного репозитория к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/git-hw или  https://github.com/имя-вашего-репозитория/7-1-ansible-hw).
   2. Выполните клонирование данного репозитория к себе на ПК с помощью команды `git clone`.
   3. Выполните домашнее задание и заполните у себя локально этот файл README.md:
      - впишите вверху название занятия и вашу фамилию и имя
      - в каждом задании добавьте решение в требуемом виде (текст/код/скриншоты/ссылка)
      - для корректного добавления скриншотов воспользуйтесь [инструкцией "Как вставить скриншот в шаблон с решением](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md)
      - при оформлении используйте возможности языка разметки md (коротко об этом можно посмотреть в [инструкции  по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md))
   4. После завершения работы над домашним заданием сделайте коммит (`git commit -m "comment"`) и отправьте его на Github (`git push origin`);
   5. Для проверки домашнего задания преподавателем в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
   6. Любые вопросы по выполнению заданий спрашивайте в чате учебной группы и/или в разделе “Вопросы по заданию” в личном кабинете.
   
Желаем успехов в выполнении домашнего задания!
   
### Дополнительные материалы, которые могут быть полезны для выполнения задания

1. [Руководство по оформлению Markdown файлов](https://gist.github.com/Jekins/2bf2d0638163f1294637#Code)

---

### Задание 1

1. Найдите полный хеш и комментарий коммита, хеш которого начинается на `aefea`.
```
git show aefea
```
![image](https://github.com/user-attachments/assets/0a1426f3-cfca-403c-a337-941a674898a3)

### Задание 2

2. Ответьте на вопросы.

* Какому тегу соответствует коммит `85024d3`?
```
git tag --contains 85024d3

```
  ![image](https://github.com/user-attachments/assets/674e4b3b-68b9-4aac-b9da-e249170e39e2)

* Сколько родителей у коммита `b8d720`? Напишите их хеши.
```
git rev-parse b8d720^
git rev-parse b8d720^2
```
    - Первый родитель: `56cd7859e0`
    - Второй родитель: `9ea88f22fc`
  
* Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами  v0.12.23 и v0.12.24.
```
git log v0.12.23..v0.12.24 --oneline
```
![image](https://github.com/user-attachments/assets/721d88a6-6437-4dfe-a454-8c256c89c384)

* Найдите коммит, в котором была создана функция `func providerSource`, её определение в коде выглядит так: `func providerSource(...)` (вместо троеточия перечислены аргументы).
```
git grep 'func providerSource'
git blame provider_source.go | grep 'func providerSource'
```

![image](https://github.com/user-attachments/assets/5d25034a-b1b5-4513-a982-c13e8b070bee)

хеш коммита:5af1e6234ab

* Найдите все коммиты, в которых была изменена функция `globalPluginDirs`.
```
git log --pretty=format:"%H" -S 'func globalPluginDirs'

```
  
  ![image](https://github.com/user-attachments/assets/527d30bf-d2ee-45f2-8518-1dfa1ed684cd)

* Кто автор функции `synchronizedWriters`?
* 
  не нахожу такой функции
  
![image](https://github.com/user-attachments/assets/3c3aea77-c8aa-4363-868f-4325a14f5945)
