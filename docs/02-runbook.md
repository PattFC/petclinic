# 🔧 Runbook de Incidentes - PetClinic

Este documento recoge respuestas rápidas para resolver incidencias comunes en el entorno DevOps del proyecto PetClinic.

---

## 1. Aplicación no conecta a MySQL

### Diagnóstico
- Revisar los logs del pod:
```bash
kubectl logs deployment/mysql
kubectl logs deployment/petclinic-app
```

### Solución
- Revisar que el pod `mysql` está corriendo.
- Verificar credenciales en el `deployment.yaml`.

---

## 2. El pod `petclinic-app` entra en CrashLoopBackOff

### Diagnóstico
```bash
kubectl get pods
kubectl logs <nombre-del-pod>
```

### Solución
- Esperar a que MySQL esté listo antes de instalar la app.
- Reinstalar Helm chart si es necesario:
```bash
helm uninstall petclinic
helm install petclinic ./helm
```

---

## 3. Port-forward falla (puerto ocupado)

### Diagnóstico
```bash
lsof -i :8080
```

### Solución
- Usar otro puerto:
```bash
kubectl port-forward service/petclinic-svc 8081:8080
```

---

## 4. CI/CD falla al subir imagen

### Diagnóstico
- Ver error en GitHub Actions → pestaña “Actions”

### Solución
- Revisar que `DOCKER_USERNAME` y `DOCKER_PASSWORD` estén correctamente configurados en GitHub Secrets.
- En este caso había conflicto de mayúsculas en el username.
- Volver a hacer `git push`.

---

