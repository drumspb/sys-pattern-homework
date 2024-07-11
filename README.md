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

### Задание 1. СУБД
Кейс
Крупная строительная компания, которая также занимается проектированием и девелопментом, решила создать правильную архитектуру для работы с данными. Ниже представлены задачи, которые необходимо решить для каждой предметной области.

Какие типы СУБД, на ваш взгляд, лучше всего подойдут для решения этих задач и почему?

1.1. Бюджетирование проектов с дальнейшим формированием финансовых аналитических отчётов и прогнозирования рисков. СУБД должна гарантировать целостность и чёткую структуру данных.

1.1.* Хеширование стало занимать длительно время, какое API можно использовать для ускорения работы?

1.2. Под каждый девелоперский проект создаётся отдельный лендинг, и все данные по лидам стекаются в CRM к маркетологам и менеджерам по продажам. Какой тип СУБД лучше использовать для лендингов и для CRM? СУБД должны быть гибкими и быстрыми.

1.2.* Можно ли эту задачу закрыть одной СУБД? И если да, то какой именно СУБД и какой реализацией?

1.3. Отдел контроля качества решил создать базу по корпоративным нормам и правилам, обучающему материалу и так далее, сформированную согласно структуре компании. СУБД должна иметь простую и понятную структуру.

1.3.* Можно ли под эту задачу использовать уже существующую СУБД из задач выше и если да, то как лучше это реализовать?

1.4. Департамент логистики нуждается в решении задач по быстрому формированию маршрутов доставки материалов по объектам и распределению курьеров по маршрутам с доставкой документов. СУБД должна уметь быстро работать со связями.

1.4.* Можно ли к этой СУБД подключить отдел закупок или для них лучше сформировать свою СУБД в связке с СУБД логистов?

1.5.* Можно ли все перечисленные выше задачи решить, используя одну СУБД? Если да, то какую именно?
### Решение 1

Для решения поставленных задач, подходящие типы СУБД могут быть следующими:

1.1. Для бюджетирования и финансовой аналитики подойдут реляционные СУБД, такие как PostgreSQL или Oracle, которые обеспечивают высокую целостность данных и поддержку транзакций. Эти системы хорошо подходят для задач, где необходима строгая структура и сложные запросы.

1.2. Для лендингов и CRM могут подойти NoSQL СУБД, например, MongoDB или Couchbase, которые предлагают гибкость и быстродействие при работе с большими объемами неструктурированных данных.

1.3. Для отдела контроля качества может подойти документо-ориентированная СУБД (например, MongoDB), которая позволяет хранить данные в виде документов, что упрощает работу со структурой компании.

1.4. Для логистики подойдет графовая СУБД (например, Neo4j), которая эффективно работает со связями и может быстро формировать маршруты.
4
1.5.* Использование одной СУБД для всех задач возможно, но может потребовать компромиссов в производительности и управлении. Возможно, стоит рассмотреть использование полифиловой архитектуры, где каждая задача решается наиболее подходящей СУБД, но все системы интегрированы для обеспечения целостности данных и удобства управления. Например, можно использовать реляционную СУБД для финансовых данных, NoSQL для CRM и лендингов, и графовую СУБД для логистики, обеспечивая интеграцию через API или промежуточное ПО.

### Задание 2 Транзакции

2.1. Пользователь пополняет баланс счёта телефона, распишите пошагово, какие действия должны произойти для того, чтобы транзакция завершилась успешно. Ориентируйтесь на шесть действий.

2.1.* Какие действия должны произойти, если пополнение счёта телефона происходило бы через автоплатёж?

Приведите ответ в свободной форме.

### Решение 2

Для успешного завершения транзакции пополнения баланса счёта телефона могут быть следующие шаги:

1. Аутентификация пользователя: Пользователь должен войти в систему или приложение, используя свои учетные данные для подтверждения своей личности.
2. Ввод суммы пополнения: Пользователь вводит сумму, на которую хочет пополнить баланс.
3. Выбор метода оплаты: Пользователь выбирает предпочтительный способ оплаты (например, банковская карта, электронный кошелек и т.д.).
4. Подтверждение платежа: Пользователь подтверждает детали платежа и сумму пополнения.
5. Обработка платежа: Платежная система обрабатывает транзакцию и списывает средства с выбранного метода оплаты.
6. Подтверждение пополнения: После успешного списания средств, система отправляет подтверждение пополнения баланса на телефон пользователя.
   
Если пополнение счёта телефона происходит через автоплатёж, процесс может выглядеть так:

1. Настройка автоплатежа: Пользователь настраивает автоплатёж, указывая сумму и периодичность платежей.
2. Автоматическая аутентификация: Система автоматически аутентифицирует пользователя на основе сохраненных данных.
3. Автоматический выбор метода оплаты: Система использует заранее выбранный пользователем метод оплаты.
4. Автоматическое подтверждение платежа: Система автоматически подтверждает детали платежа в соответствии с настройками автоплатежа.
5. Обработка платежа: Платежная система обрабатывает транзакцию в назначенное время.
6. Уведомление о пополнении: Пользователь получает уведомление о пополнении баланса после успешного выполнения автоплатежа.

### Задание 3 SQL vs NoSQL

3.1. Напишите пять преимуществ SQL-систем по отношению к NoSQL.

### Решение 3

Строгая схема данных: SQL-базы данных требуют определения схемы данных перед началом работы, что обеспечивает строгую структурированность и предсказуемость формата данных.

ACID-свойства: SQL-базы данных поддерживают ACID-свойства (атомарность, согласованность, изоляция, долговечность), что критически важно для транзакционных систем, где необходима высокая надежность обработки данных.

Сложные запросы: SQL-язык запросов позволяет выполнять сложные запросы с использованием операций соединения (JOIN), подзапросов и агрегирования, что делает его мощным инструментом для анализа данных.

Стандартизация: SQL является стандартизированным языком, что облегчает переносимость и совместимость между различными реляционными системами управления базами данных.

Инструменты и поддержка: Благодаря долгой истории развития, SQL-системы имеют широкий спектр инструментов для разработки, мониторинга и оптимизации, а также обширное сообщество и поддержку.

### Задание 4 Кластеры

Необходимо производить большое количество вычислений при работе с огромным количеством данных, под эту задачу выделено 1000 машин.

На основе какого критерия будете выбирать тип СУБД и какая модель распределённых вычислений здесь справится лучше всего и почему?

Приведите ответ в свободной форме.

### Решение 4

Здравствуйте! Как я могу вам помочь сегодня?

Кейс
Крупная строительная компания, которая также занимается проектированием и девелопментом, решила создать правильную архитектуру для работы с данными. Ниже представлены задачи, которые необходимо решить для каждой предметной области.

Какие типы СУБД, на ваш взгляд, лучше всего подойдут для решения этих задач и почему?

1.1. Бюджетирование проектов с дальнейшим формированием финансовых аналитических отчётов и прогнозирования рисков. СУБД должна гарантировать целостность и чёткую структуру данных.

1.1.* Хеширование стало занимать длительно время, какое API можно использовать для ускорения работы?

1.2. Под каждый девелоперский проект создаётся отдельный лендинг, и все данные по лидам стекаются в CRM к маркетологам и менеджерам по продажам. Какой тип СУБД лучше использовать для лендингов и для CRM? СУБД должны быть гибкими и быстрыми.

1.2.* Можно ли эту задачу закрыть одной СУБД? И если да, то какой именно СУБД и какой реализацией?

1.3. Отдел контроля качества решил создать базу по корпоративным нормам и правилам, обучающему материалу и так далее, сформированную согласно структуре компании. СУБД должна иметь простую и понятную структуру.

1.3.* Можно ли под эту задачу использовать уже существующую СУБД из задач выше и если да, то как лучше это реализовать?

1.4. Департамент логистики нуждается в решении задач по быстрому формированию маршрутов доставки материалов по объектам и распределению курьеров по маршрутам с доставкой документов. СУБД должна уметь быстро работать со связями.

1.4.* Можно ли к этой СУБД подключить отдел закупок или для них лучше сформировать свою СУБД в связке с СУБД логистов?

1.5.* Можно ли все перечисленные выше задачи решить, используя одну СУБД? Если да, то какую именно?

Для решения поставленных задач, подходящие типы СУБД могут быть следующими:

1.1. Для бюджетирования и финансовой аналитики подойдут реляционные СУБД, такие как PostgreSQL или Oracle, которые обеспечивают высокую целостность данных и поддержку транзакций. Эти системы хорошо подходят для задач, где необходима строгая структура и сложные запросы.

1.1.* Для ускорения хеширования можно использовать специализированные библиотеки или API, такие как Intel IPP (Integrated Performance Primitives) для оптимизации вычислений.

1.2. Для лендингов и CRM могут подойти NoSQL СУБД, например, MongoDB или Couchbase, которые предлагают гибкость и быстродействие при работе с большими объемами неструктурированных данных.

1.2.* Возможно использование одной NoSQL СУБД для обеих задач, если она поддерживает различные типы данных и обеспечивает необходимую производительность.

1.3. Для отдела контроля качества может подойти документо-ориентированная СУБД (например, MongoDB), которая позволяет хранить данные в виде документов, что упрощает работу со структурой компании.

1.3.* Если структура данных отдела контроля качества схожа с другими задачами, можно использовать ту же СУБД, настроив соответствующие права доступа и отдельные коллекции/таблицы.

1.4. Для логистики подойдет графовая СУБД (например, Neo4j), которая эффективно работает со связями и может быстро формировать маршруты.

1.4.* Отдел закупок может быть подключен к графовой СУБД, если их данные тесно связаны с логистикой, и это позволит оптимизировать взаимодействие между отделами.

1.5.* Использование одной СУБД для всех задач возможно, но может потребовать компромиссов в производительности и управлении. Возможно, стоит рассмотреть использование полифиловой архитектуры, где каждая задача решается наиболее подходящей СУБД, но все системы интегрированы для обеспечения целостности данных и удобства управления. Например, можно использовать реляционную СУБД для финансовых данных, NoSQL для CRM и лендингов, и графовую СУБД для логистики, обеспечивая интеграцию через API или промежуточное ПО.

Задание 2. Транзакции
2.1. Пользователь пополняет баланс счёта телефона, распишите пошагово, какие действия должны произойти для того, чтобы транзакция завершилась успешно. Ориентируйтесь на шесть действий.

2.1.* Какие действия должны произойти, если пополнение счёта телефона происходило бы через автоплатёж?

Приведите ответ в свободной форме.

Для успешного завершения транзакции пополнения баланса счёта телефона могут быть следующие шаги:

Аутентификация пользователя: Пользователь должен войти в систему или приложение, используя свои учетные данные для подтверждения своей личности.
Ввод суммы пополнения: Пользователь вводит сумму, на которую хочет пополнить баланс.
Выбор метода оплаты: Пользователь выбирает предпочтительный способ оплаты (например, банковская карта, электронный кошелек и т.д.).
Подтверждение платежа: Пользователь подтверждает детали платежа и сумму пополнения.
Обработка платежа: Платежная система обрабатывает транзакцию и списывает средства с выбранного метода оплаты.
Подтверждение пополнения: После успешного списания средств, система отправляет подтверждение пополнения баланса на телефон пользователя.
Если пополнение счёта телефона происходит через автоплатёж, процесс может выглядеть так:

Настройка автоплатежа: Пользователь настраивает автоплатёж, указывая сумму и периодичность платежей.
Автоматическая аутентификация: Система автоматически аутентифицирует пользователя на основе сохраненных данных.
Автоматический выбор метода оплаты: Система использует заранее выбранный пользователем метод оплаты.
Автоматическое подтверждение платежа: Система автоматически подтверждает детали платежа в соответствии с настройками автоплатежа.
Обработка платежа: Платежная система обрабатывает транзакцию в назначенное время.
Уведомление о пополнении: Пользователь получает уведомление о пополнении баланса после успешного выполнения автоплатежа.
Эти шаги могут незначительно отличаться в зависимости от конкретной платежной системы и настроек безопасности.

Напишите пять преимуществ SQL-систем по отношению к NoSQL.

SQL-системы, также известные как реляционные базы данных, имеют ряд преимуществ по сравнению с NoSQL-системами:

Строгая схема данных: SQL-базы данных требуют определения схемы данных перед началом работы, что обеспечивает строгую структурированность и предсказуемость формата данных.

ACID-свойства: SQL-базы данных поддерживают ACID-свойства (атомарность, согласованность, изоляция, долговечность), что критически важно для транзакционных систем, где необходима высокая надежность обработки данных.

Сложные запросы: SQL-язык запросов позволяет выполнять сложные запросы с использованием операций соединения (JOIN), подзапросов и агрегирования, что делает его мощным инструментом для анализа данных.

Стандартизация: SQL является стандартизированным языком, что облегчает переносимость и совместимость между различными реляционными системами управления базами данных.

Инструменты и поддержка: Благодаря долгой истории развития, SQL-системы имеют широкий спектр инструментов для разработки, мониторинга и оптимизации, а также обширное сообщество и поддержку.

Эти преимущества делают SQL-системы предпочтительным выбором для многих приложений, особенно там, где важна надежность и точность обработки данных.

Необходимо производить большое количество вычислений при работе с огромным количеством данных, под эту задачу выделено 1000 машин.

На основе какого критерия будете выбирать тип СУБД и какая модель распределённых вычислений здесь справится лучше всего и почему?

Приведите ответ в свободной форме.

Выбор типа СУБД и модели распределённых вычислений для работы с большим объёмом данных на 1000 машинах будет зависеть от нескольких критериев:

Масштабируемость: Важно выбрать систему, которая может масштабироваться горизонтально, чтобы увеличивать производительность путём добавления новых машин.

Устойчивость к отказам: Система должна обеспечивать высокую доступность и устойчивость к отказам, автоматически восстанавливая работу в случае сбоев.

Балансировка нагрузки: Необходима эффективная балансировка нагрузки для равномерного распределения вычислительных задач между машинами.

Согласованность данных: Для некоторых задач критична согласованность данных, что может потребовать использования транзакционных СУБД с поддержкой ACID.

Скорость обработки запросов: Выбранная система должна обеспечивать быструю обработку запросов, особенно при работе с большими объёмами данных.

Типы данных и запросов: В зависимости от типов данных и запросов, может потребоваться использование специализированных СУБД, например, временных рядов для аналитики или графовых для обработки связей.

Исходя из этих критериев, модель распределённых вычислений, которая может справиться лучше всего, — это MapReduce или её вариации (например, Hadoop или Spark). Эти системы хорошо подходят для обработки больших объёмов данных благодаря их способности распределять задачи по большому количеству узлов и эффективно обрабатывать параллельные вычисления.

MapReduce позволяет разбивать большие задачи на множество мелких, которые могут выполняться параллельно, а затем агрегировать результаты. Это обеспечивает высокую производительность и масштабируемость, что идеально подходит для работы с огромными объёмами данных на тысяче машин.
