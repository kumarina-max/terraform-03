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

### Задание 7

В Terraform Console выполнено удаление третьего элемента
из списков `subnet_ids` и `subnet_zones`.

```hcl
merge(
  local.vpc,
  {
    subnet_ids = concat(
      slice(local.vpc.subnet_ids, 0, 2),
      slice(local.vpc.subnet_ids, 3, length(local.vpc.subnet_ids))
    )
    subnet_zones = concat(
      slice(local.vpc.subnet_zones, 0, 2),
      slice(local.vpc.subnet_zones, 3, length(local.vpc.subnet_zones))
    )
  }
)
```
