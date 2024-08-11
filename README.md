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
Опишите не менее семи таблиц, из которых состоит база данных:

какие данные хранятся в этих таблицах;
какой тип данных у столбцов в этих таблицах, если данные хранятся в PostgreSQL.
Приведите решение к следующему виду:

Сотрудники (

идентификатор, первичный ключ, serial,
фамилия varchar(50),
...
идентификатор структурного подразделения, внешний ключ, integer).

`Приведите ответ в свободной форме........`

1. Должность 

   position_id, первичный ключ, serial,
   Наименование должности varchar(50)

2. Типы подразделений

   type_of_unit_id, первичный ключ, serial,
   Наименование типа подразделения varchar(50)

3. Структурные подразделения

   structural_unit_id первичный ключ serial,
   Наименование структурного подразделения varchar(50)

4. Адрес филиала

   address_id первичный ключ serial,
   Адрес филиала varchar(50)

5. Проекты

   progect_id первичный ключ serial,
   Наименование проэкта varchar(50)

6. Сотрудники

   officer_id первичный ключ, serial,
   фамилия varchar(50),
   имя varchar(50),
   отчество varchar(50),
   дата_найма date,
   position_id integer,
   type_of_unit_id integer,
   structural_unit_id integer,
   address_id integer,
   progect_id_id integer,

8. Оклад

   salary_id первичный ключ serial,
   идентификатор_сотрудника (officer_id) integer,
   Оклад numeric(15, 2)
 

