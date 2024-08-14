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

### ЗЗадание 1
Напишите запрос к учебной базе данных, который вернёт процентное отношение общего размера всех индексов к общему размеру всех таблиц.

```
SELECT 
    (SUM(index_size) / SUM(data_size)) * 100 AS процентное_отношение
FROM (
    SELECT 
        data_length AS data_size,
        index_length AS index_size
    FROM 
        information_schema.tables
    WHERE 
        table_schema NOT IN ('information_schema', 'ysql', 'performance_schema')
) AS subquery;
```


![Название скриншота 1](https://github.com/drumspb/sys-pattern-homework/blob/%D0%B8%D0%BD%D0%B4%D0%B5%D0%BA%D1%81%D1%8B/img/1.png)`


---

### Задание 2
Выполните explain analyze следующего запроса:

```
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
```
перечислите узкие места;
оптимизируйте запрос: внесите корректировки по использованию операторов, при необходимости добавьте индексы.

```
explain analyze 
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id

-> Table scan on <temporary>  (cost=2.5..2.5 rows=0) (actual time=7676..7676 rows=391 loops=1)
    -> Temporary table with deduplication  (cost=0..0 rows=0) (actual time=7676..7676 rows=391 loops=1)
        -> Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title )   (actual time=3341..7413 rows=642000 loops=1)
            -> Sort: c.customer_id, f.title  (actual time=3341..3414 rows=642000 loops=1)
                -> Stream results  (cost=22.6e+6 rows=16.5e+6) (actual time=0.916..2542 rows=642000 loops=1)
                    -> Nested loop inner join  (cost=22.6e+6 rows=16.5e+6) (actual time=0.907..2171 rows=642000 loops=1)
                        -> Nested loop inner join  (cost=20.9e+6 rows=16.5e+6) (actual time=0.893..1928 rows=642000 loops=1)
                            -> Nested loop inner join  (cost=19.3e+6 rows=16.5e+6) (actual time=0.877..1613 rows=642000 loops=1)
                                -> Inner hash join (no condition)  (cost=1.65e+6 rows=16.5e+6) (actual time=0.851..61.2 rows=634000 loops=1)
                                    -> Filter: (cast(p.payment_date as date) = '2005-07-30')  (cost=1.72 rows=16500) (actual time=0.0691..10.1 rows=634 loops=1)
                                        -> Table scan on p  (cost=1.72 rows=16500) (actual time=0.0463..7.23 rows=16044 loops=1)
                                    -> Hash
                                        -> Covering index scan on f using idx_title  (cost=112 rows=1000) (actual time=0.0923..0.565 rows=1000 loops=1)
                                -> Covering index lookup on r using rental_date (rental_date=p.payment_date)  (cost=0.969 rows=1) (actual time=0.0016..0.00226 rows=1.01 loops=634000)
                            -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=250e-6 rows=1) (actual time=287e-6..314e-6 rows=1 loops=642000)
                        -> Single-row covering index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=250e-6 rows=1) (actual time=176e-6..203e-6 rows=1 loops=642000)

```
На основе предоставленного плана выполнения запроса, можно определить следующие узкие места:

Полный сканирование таблицы payment: В плане выполнения запроса видим полное сканирование таблицы payment (Table scan on p). Это может быть медленным, особенно если таблица большая.

Недостаток индексов: В плане выполнения запроса нет индексов на столбцах customer_id, inventory_id и rental_date. Это может привести к медленным соединениям и фильтрациям.

Использование оконной функции: Использование оконной функции SUM() может быть медленным, особенно если количество строк в таблице большое.

Сортировка: В плане выполнения запроса видим сортировку по столбцам c.customer_id и f.title. Это может быть медленным, особенно если количество строк в таблице большое.

Временная таблица: В плане выполнения запроса видим создание временной таблицы для хранения результатов. Это может быть медленным, особенно если количество строк в таблице большое.
```
CREATE INDEX idx_payment_date ON payment (payment_date);
CREATE INDEX idx_customer_id ON rental (customer_id);
CREATE INDEX idx_inventory_id ON rental (inventory_id);
CREATE INDEX idx_rental_date ON rental (rental_date);
SELECT 
  c.last_name, 
  c.first_name, 
  f.title, 
  SUM(p.amount) AS total_amount 
FROM 
  payment p 
  INNER JOIN rental r ON p.rental_id = r.rental_id 
  INNER JOIN customer c ON r.customer_id = c.customer_id 
  INNER JOIN inventory i ON r.inventory_id = i.inventory_id 
  INNER JOIN film f ON i.film_id = f.film_id 
WHERE 
  p.payment_date >= '2005-07-30 00:00:00' 
  AND p.payment_date < '2005-07-31 00:00:00' 
GROUP BY 
  c.customer_id, 
  f.title, 
  c.last_name, 
  c.first_name

-> Table scan on <temporary>  (actual time=12..12.1 rows=634 loops=1)
    -> Aggregate using temporary table  (actual time=12..12 rows=634 loops=1)
        -> Nested loop inner join  (cost=1173 rows=634) (actual time=0.217..9.66 rows=634 loops=1)
            -> Nested loop inner join  (cost=951 rows=634) (actual time=0.212..8.39 rows=634 loops=1)
                -> Nested loop inner join  (cost=729 rows=634) (actual time=0.207..7.17 rows=634 loops=1)
                    -> Nested loop inner join  (cost=507 rows=634) (actual time=0.19..5.92 rows=634 loops=1)
                        -> Filter: (p.rental_id is not null)  (cost=286 rows=634) (actual time=0.0532..4.46 rows=634 loops=1)
                            -> Index range scan on p using idx_payment_date over ('2005-07-30 00:00:00' <= payment_date < '2005-07-31 00:00:00'), with index condition: ((p.payment_date >= TIMESTAMP'2005-07-30 00:00:00') and (p.payment_date < TIMESTAMP'2005-07-31 00:00:00'))  (cost=286 rows=634) (actual time=0.0522..4.36 rows=634 loops=1)
                        -> Single-row index lookup on r using PRIMARY (rental_id=p.rental_id)  (cost=0.25 rows=1) (actual time=0.00202..0.00205 rows=1 loops=634)
                    -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=0.25 rows=1) (actual time=0.00172..0.00175 rows=1 loops=634)
                -> Single-row index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=0.25 rows=1) (actual time=0.00165..0.00168 rows=1 loops=634)
            -> Single-row index lookup on f using PRIMARY (film_id=i.film_id)  (cost=0.25 rows=1) (actual time=0.00174..0.00177 rows=1 loops=634)

```

