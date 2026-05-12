@echo off
echo Starting Docker Desktop...
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"

echo Waiting for Docker to start...
timeout /t 15 /nobreak

echo Starting k3d cluster...
k3d cluster start testcluster

echo Waiting for cluster to be ready...
timeout /t 10 /nobreak

echo Starting Argo CD port-forward in new window...
start "ArgoCD" cmd /k "kubectl port-forward svc/argocd-server -n argocd 8090:443"

echo.
echo ================================
echo Everything is up!
echo.
echo Your app:  http://localhost:8080
echo Argo CD:   https://localhost:8090
echo ================================
pause