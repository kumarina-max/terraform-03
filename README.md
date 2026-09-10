# terraform-03
Домашнее задание к занятию «Управляющие конструкции в коде Terraform»

### Задание 1

![Задание 1 — Группы безопасности](screenshots/task1.png)

### Задание 2
Созданные ВМ

![Задание 2](screenshots/task2.png)

### Задание 3

![Задание 3](screenshots/task3.png)

### Задание 4

![Задание 3](screenshots/task4.png)

### Задание 5

Добавлен Terraform output со списком виртуальных машин.

Для каждой ВМ выводятся:

- `name`
- `id`
- `fqdn`
- 
![Задание 5](screenshots/task5.png)

### Задание 6
Добавлен `null_resource`, который запускает `ansible-playbook`
после создания inventory.

Проверено подключение к виртуальным машинам с помощью Ansible.

![Задание 6](screenshots/task6.png)
