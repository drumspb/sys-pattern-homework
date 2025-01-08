Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.

Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.

---

![image](https://github.com/user-attachments/assets/fc1cba4f-ad87-48b4-97ed-0885b7c06d5a)

![image](https://github.com/user-attachments/assets/135cc0e2-bf96-4619-b55a-85d1b9c0a3cd)

**Что нужно сделать**

1. Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done. 
1. Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done. 
1. При проведении обеих задач по статусам используйте kanban. 
1. Верните задачи в статус Open.
1. Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт.
2. Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.


![image](https://github.com/user-attachments/assets/62e1a5fe-4d21-43db-b125-339df6ce3ddb)

![image](https://github.com/user-attachments/assets/a1aee51b-1859-4650-bec0-519d8a6eaa0c)

![image](https://github.com/user-attachments/assets/5d6c8c2b-c102-4891-bac1-48ced016583d)

![image](https://github.com/user-attachments/assets/730606c1-32af-4157-a0a8-1d9df99e90d7)


