# 🚀 Guía de Despliegue de PetClinic

En este documento describo los pasos necesarios para desplegar la aplicación PetClinic en dos entornos: Docker Compose y Kubernetes con Helm (Minikube).

---

## 🐳 Despliegue con Docker Compose

### 1. Clonar el repositorio
```bash
git clone https://github.com/tu_usuario/petclinic.git
cd petclinic
```

### 2. Iniciar stack de monitorización
```bash
docker compose -f docker-compose.monitor.yml up -d
```

### 3. Iniciar la aplicación
```bash
docker compose -f docker-compose.yml up -d --build
```

### 4. Verificar servicios
- PetClinic: http://localhost:8080
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000
- Jaeger: http://localhost:16686

---

## ☸️ Despliegue con Helm + Minikube

### 1. Iniciar Minikube
```bash
minikube start --driver=docker
```

### 2. Aplicar MySQL como servicio interno
```bash
kubectl apply -f helm/k8s/mysql-deployment.yaml
```

### 3. Desplegar la aplicación con Helm
```bash
helm install petclinic ./helm
```

### 4. Acceder a la aplicación
```bash
kubectl port-forward service/petclinic-svc 8081:8080
```
Abrir en navegador: http://localhost:8081

---

