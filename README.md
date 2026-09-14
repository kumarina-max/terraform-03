# Домашнее задание по модулю «Продвинутые методы работы с Terraform» Марина Кукушкина 

## Задание 1

Созданы две ВМ в Yandex Cloud с использованием удалённого модуля:

- `marketing`
- `analytics`

Для ВМ:
- добавлены labels `project`;
- включён `preemptible`;
- через `cloud-init` устанавливается nginx;
- SSH-ключ передаётся через `template_file`.

Результат: обе ВМ созданы и работают, nginx успешно установлен.

![Задание 1](screenshots/task1.1.png)
![Задание 1.2](screenshots/task1.png)
![Задание 1.3](screenshots/task1.2.png)
## Задание 2

Создан локальный модуль `vpc`, который создаёт:

- VPC network;
- subnet.

Модуль принимает `env_name`, `zone`, `cidr` и возвращает информацию о subnet через `output`.

Существующие ресурсы перенесены в state модуля без пересоздания.

Результат:

```text
terraform plan

No changes. Your infrastructure matches the configuration.

Документация модуля сгенерирована с помощью terraform-docs.



