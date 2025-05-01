# Домашнее задание к занятию "`Базовые обьекты k8s`" - `Дромашко Кирилл Сергеевич`


## Задание 1. Создание Pod hello-world

### Создание манифеста pod.yaml**:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hello-world
  labels:
    app: echoserver
spec:
  containers:
  - name: echoserver
    image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
    ports:
    - containerPort: 8080
```

<img width="826" alt="{46FA2B1C-A142-4340-9DD4-DBC3C912628E}" src="https://github.com/user-attachments/assets/dc17767e-bead-4abf-9d6d-532ce2df2900" />


## Задание 2. Создание Service netology-svc

#### Создание манифеста web-pod.yaml:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: netology-web
  labels:
    app: echoserver
    pod-type: netology 
spec:
  containers:
  - name: echoserver
    image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
    ports:
    - containerPort: 8080
```
#### Создание манифеста service.yaml:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: netology-svc
spec:
  selector:
    app: echoserver
    pod-type: netology 
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
```
<img width="177" alt="{91A7AED8-BAB1-4DF1-9368-D1D68B3978E4}" src="https://github.com/user-attachments/assets/e7ffdff4-3ea7-4d75-97a9-67c8302d1248" />

<img width="263" alt="{20D1B115-7DBC-43A9-85B6-873BC3B352A1}" src="https://github.com/user-attachments/assets/fb22c70c-352f-47cc-9a2a-378bab08b6a3" />

<img width="827" alt="{572673BA-2181-4632-A988-F6706A485C0B}" src="https://github.com/user-attachments/assets/0e65ca1f-18b8-4894-b0fb-dd5ceae89d26" />
