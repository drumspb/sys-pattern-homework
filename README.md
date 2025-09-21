# Отчет по дипломному практикуму: Автоматизация развертывания Kubernetes кластера и CI/CD 

# Дромашко Кирилл Сергеевич

## 1–2. Создание облачной инфраструктуры и Kubernetes кластера

### Цель

Подготовить облачную инфраструктуру в Яндекс.Облаке и развернуть рабочий Kubernetes-кластер для тестового приложения.

### Описание выполненной работы

1. **Сервисный аккаунт и права**

   * Создан сервисный аккаунт `terraform-sa` для управления инфраструктурой через Terraform.
   * Назначены роли:

     * `editor` — общее управление ресурсами.
     * `container-registry.images.pusher/puller` — работа с Container Registry.
     * `container-registry.admin` — полный доступ к регистру.

2. **Хранилище состояния Terraform**

   * Создан S3-бакет `diploma-terraform-state-<student_id>` с включенным versioning.
   * Генерируются файлы: `private_key.json` (для Terraform) и `s3-credentials`.

3. **VPC и подсети**

   * VPC `main-network` с тремя подсетями:

     * `subnet-a` – 192.168.10.0/24 (ru-central1-a)
     * `subnet-b` – 192.168.20.0/24 (ru-central1-b)
     * `subnet-c` – 192.168.30.0/24 (ru-central1-d)

4. **Kubernetes кластер**

   * Master-нода: 1 ВМ `k8s-master` (2 CPU, 4 GB RAM, preemptible)
   * Worker-ноды: 2 ВМ `k8s-worker` (2 CPU, 4 GB RAM, preemptible)
   * Настроен пользователь `ubuntu` с sudo без пароля и публичным SSH ключом
   * Поднят NLB с выделенным публичным IP для ingress
   * Генерация Ansible-инвентаря `inventory.ini` для Kubespray

5. **Container Registry**

   * Создан основной регистр `main-registry`
   * Создан репозиторий `test-app` для хранения Docker-образов

6. **CI/CD**

   * Настроен GitLab pipeline с этапами `apply` и `deploy_k8s`
   * Используется `private_key.json` и S3 credentials
   * Применяются preemptible ВМ для экономии бюджета

### Результаты

* [Репозиторий Terraform](https://gitlab.com/devops-netology1654345/terraform)
* Kubernetes кластер развернут и готов к работе
* Container Registry готов к приему Docker-образов
* GitLab pipeline позволяет запускать развёртывание и деплой кластера

---

## 3. Деплой инфраструктуры через Terraform pipeline

### Цель

Автоматизировать создание и изменение облачной инфраструктуры без Terraform Cloud или Atlantis, используя GitLab CI/CD.

### Описание реализации

1. **Этапы GitLab pipeline**

   * `apply` — развёртывание инфраструктуры через Terraform (`init`, `plan`, `apply`)
   * `deploy_k8s` — установка Kubernetes через Ansible/Kubespray

2. **Переменные и секреты**

   * `$TF_VAR_ssh_public_key`, `$YC_KEY_JSON`, `$YC_S3_CREDENTIALS`, `$ANSIBLE_SSH_PRIVATE_KEY`

3. **Особенности**

   * Возможность ручного запуска этапов
   * Preemptible ВМ для экономии бюджета
   * Автоматическая генерация и использование Ansible-инвентаря
   * Полный цикл: от создания инфраструктуры до готового Kubernetes кластера

### Пример структуры pipeline

```yaml
stages:
  - validate
  - plan
  - apply 
  - deploy_k8s

apply:
  stage: apply
  when: manual
  script:
    - cd $TF_WORKING_DIR
    - terraform init
    - terraform plan -out=tfplan
    - terraform apply -auto-approve tfplan
  artifacts:
    paths:
      - $TF_WORKING_DIR/inventory.ini
    expire_in: 1 week

deploy_k8s:
  stage: deploy_k8s
  when: manual
  script:
    - mkdir -p ~/.ssh/
    - echo "$ANSIBLE_SSH_PRIVATE_KEY" > ~/.ssh/yandex_cloud
    - chmod 600 ~/.ssh/yandex_cloud
    - apt-get update
    - apt-get install -y sshpass openssh-client git curl unzip python3-venv python3-pip
    - pip install --upgrade pip
    - pip install --no-cache-dir ansible gitpython jinja2
    - git clone --branch release-2.27 https://github.com/kubernetes-sigs/kubespray.git
    - pip install -r ./kubespray/requirements.txt
    - cd ./kubespray
    - ansible-playbook -i /builds/$CI_PROJECT_PATH/infrastructure/inventory.ini cluster.yml
```

### Результаты

* Автоматическое создание и изменение инфраструктуры
* Готовый Kubernetes кластер после этапа `deploy_k8s`
* Pipeline выполняет функции Atlantis, обеспечивает контроль применения Terraform

---

## 4. Создание тестового приложения

### Цель

Подготовить тестовое приложение для деплоя в Kubernetes и тестирования CI/CD.

### Репозиторий и структура

```
test-app/
├── Dockerfile
├── index.html
├── nginx.conf
├── static/
│   └── style.css
└── kube/
    ├── deployment.yaml
    ├── ingress.yaml
    ├── service.yaml
    ├── playbook.yml
    └── yc-registry-secret.yaml.j2
```

* HTML и статика для приложения
* `nginx.conf` — кастомная конфигурация Nginx
* Kubernetes манифесты для деплоя

### Dockerfile

```dockerfile
FROM nginx:1.25-alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/
COPY static/ /usr/share/nginx/html/static/
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost/health || exit 1
CMD ["nginx", "-g", "daemon off;"]
```

### Результаты

* [Репозиторий тестового приложения](https://gitlab.com/devops-netology1654345/test-app)
* Docker-образ готов к загрузке в Yandex Container Registry
* Kubernetes-манифесты подготовлены для деплоя
* Ansible playbook позволяет автоматизировать деплой


---

## 6. Подготовка системы мониторинга и деплой приложения

### Цель

Настроить систему мониторинга Kubernetes кластера и задеплоить тестовое приложение для проверки работоспособности и доступности сервисов.

---

### Инструменты и подход

* **Kubernetes кластер** — ранее поднят с помощью Terraform и Ansible (Kubespray).
* **Мониторинг** — развернут через Helm-чарты `kube-prometheus`, включающие:

  * Prometheus (сбор метрик кластера)
  * Grafana (визуализация метрик)
  * Alertmanager (уведомления о событиях)
  * Node Exporter (метрики узлов)
* **Ingress контроллер** — `ingress-nginx` для внешнего доступа к приложениям в кластере.
* **Тестовое приложение** — Nginx сервер, отдающий статическую страницу и статику.

Конфигурация и деплой выполнены через **Ansible** с использованием отдельных ролей:

```
.
├── inventory.ini
├── playbook.yml
└── roles
    ├── helm_install
    ├── ingress_install
    └── prometheus_install
```

---

### Основные шаги деплоя

#### 1. Установка Helm

Ansible скачивает бинарь Helm, распаковывает и устанавливает на мастер-ноды:

```yaml
- name: Download Helm binary
- name: Extract Helm
- name: Install Helm binary
```

#### 2. Деплой Ingress

* Установка зависимостей Python и Kubernetes client.
* Создание namespace и копирование `values-ingress.yaml`.
* Добавление Helm репозитория `ingress-nginx`.
* Развёртывание ingress через Helm.
* Ожидание готовности pod контроллера:

```yaml
- name: Deploy ingress-nginx via Helm
- name: Wait for ingress-nginx controller pod to be ready
```

#### 3. Деплой мониторинга (Prometheus + Grafana + Alertmanager)

* Создание namespace для мониторинга.
* Добавление Helm репозитория `kube-prometheus`.
* Копирование файла `values-prometheus.yaml` с конфигурацией.
* Развёртывание Helm-чарта `kube-prometheus-stack`.
* Ожидание готовности Grafana pod:

```yaml
- name: Deploy kube-prometheus via Helm
- name: Wait for Grafana pod to be ready
```

#### 4. Деплой тестового приложения

* Развёртывание Nginx сервера с тестовой страницей через ранее подготовленные манифесты `deployment.yaml`, `service.yaml`, `ingress.yaml`.
* Проверка доступности приложения через Ingress на порту 80.

---

### Результаты

* [Репозиторий Ansible для Kubernetes](https://gitlab.com/devops-netology1654345/ansible-k8s-cluster)
* HTTP доступ к Grafana и дашбордам
* Доступ к тестовому приложению через Ingress
* Автоматизация деплоя одной командой

---

## 7. Установка и настройка CI/CD

### Цель

Автоматическая сборка Docker-образа и деплой приложения при изменениях кода.

### Инструменты

* GitLab CI/CD
* Docker
* Yandex Container Registry
* Ansible

### Этапы pipeline

1. **prepare** — подготовка окружения и переменных
2. **build** — сборка Docker-образа
3. **push** — публикация в YCR
4. **deploy\_production** — деплой в Kubernetes через SSH/Ansible

### Примеры задач

**Сборка Docker-образа:**

```yaml
- docker build -t $IMAGE_NAME:$IMAGE_TAG .
- docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest
```

**Push в YCR:**

```yaml
- echo "$YC_IAM_TOKEN" | docker login cr.yandex --username iam --password-stdin
- docker push $IMAGE_NAME:$IMAGE_TAG
- docker push $IMAGE_NAME:latest
```

**Деплой в Kubernetes:**

```yaml
ssh -i ~/.ssh/yandex_cloud ubuntu@$MASTER_IP "
  kubectl create secret docker-registry yc-registry-secret --docker-server=cr.yandex --docker-username=iam --docker-password=\"$YC_IAM_TOKEN\" --docker-email=none -n production --dry-run=client -o yaml | kubectl apply -f -
  kubectl apply -f /home/ubuntu/deployment.yaml
  kubectl apply -f /home/ubuntu/service.yaml
  kubectl apply -f /home/ubuntu/ingress.yaml
"
```

### Результаты

* GitLab CI/CD доступен по HTTP
* Автоматическая сборка и деплой при коммите или теге
* Возможность версионирования образов через теги
* Полностью автоматизированный цикл CI/CD

---

