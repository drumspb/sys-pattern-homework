# Домашнее задание к занятию "`Микросервисы: подходы`" - `Дромашко Кирилл Сергеевич`


# Решения для микросервисной архитектуры

## Задача 1: Организация CI/CD

### Выбранное решение: **GitLab CI/CD + ArgoCD**

#### Компоненты:
1. **GitLab Ultimate** (облачная/SaaS версия)
2. **ArgoCD** (для CD)
3. **HashiCorp Vault** (для секретов)
4. **Docker Registry** (артефакты)

### Соответствие требованиям:
| Требование | Реализация |
|------------|------------|
| Облачная Git-система | GitLab SaaS |
| Репозиторий на сервис | GitLab projects |
| Сборка по событию | GitLab CI pipelines |
| Сборка с параметрами | Manual pipelines with variables |
| Настройки сборки | CI/CD variables per project |
| Шаблоны сборок | `.gitlab-ci.yml` extends |
| Хранение секретов | Vault + GitLab protected variables |
| Множественные конфигурации | Multi-project pipelines |
| Кастомные шаги | Custom CI jobs |
| Собственные Docker-образы | GitLab Container Registry |
| Собственные агенты | GitLab Runner (self-hosted) |
| Параллельные сборки | Parallel jobs in pipelines |
| Параллельные тесты | Parallel test jobs |

**Обоснование**:
- Полная интеграция Git+CI/CD в одном продукте
- Гибкость настройки через YAML
- Поддержка Kubernetes-ориентированного деплоя через ArgoCD
- Enterprise-безопасность через Vault

## Задача 2: Централизованное логирование

### Выбранное решение: **EFK Stack + Loki**

#### Компоненты:
1. **Fluent Bit** (агенты)
2. **Elasticsearch** (хранилище)
3. **Kibana** (UI)
4. **Grafana Loki** (доп. логи)

### Соответствие требованиям:
| Требование | Реализация |
|------------|------------|
| Центральный сбор | Fluent Bit → Elasticsearch |
| Сбор из stdout | Docker log driver → Fluent Bit |
| Гарантированная доставка | Fluent Bit retry mechanism |
| Поиск/фильтрация | Kibana Query Language |
| UI для разработчиков | Kibana (основной), Grafana (для Loki) |
| Ссылки на поиск | Saved Kibana searches/sharing |

**Обоснование**:
- Fluent Bit: минимальное потребление ресурсов
- Elasticsearch: оптимален для полнотекстового поиска
- Loki: эффективен для логов приложений
- Kibana: лучший UI для анализа логов

## Задача 3: Мониторинг системы

### Выбранное решение: **Prometheus + VictoriaMetrics + Grafana**

#### Компоненты:
1. **Prometheus** (сбор метрик)
2. **VictoriaMetrics** (долгосрочное хранение)
3. **Grafana** (визуализация)
4. **kube-state-metrics** (K8s метрики)

### Соответствие требованиям:
| Требование | Реализация |
|------------|------------|
| Сбор метрик хостов | Node Exporter |
| Метрики ресурсов | cAdvisor + Node Exporter |
| Сервис-специфичные метрики | Custom Prometheus exporters |
| UI для запросов | PromQL в Grafana |
| Кастомные дашборды | Grafana dashboards |

**Обоснование**:
- Prometheus: стандарт для микросервисов
- VictoriaMetrics: эффективнее для долгосрочных данных
- Grafana: лучшие возможности визуализации
- Поддержка multi-cloud окружений

