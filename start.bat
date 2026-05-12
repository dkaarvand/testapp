@echo off
echo ================================
echo Starting Frontline DevOps Stack
echo ================================

echo.
echo [1/5] Starting Docker Desktop...
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
echo Waiting for Docker to start...
timeout /t 20 /nobreak

echo.
echo [2/5] Starting k3d cluster...
k3d cluster start testcluster
timeout /t 10 /nobreak

echo.
echo [3/5] Creating namespaces (safe to ignore errors if they exist)...
kubectl create namespace dev 2>nul
kubectl create namespace argocd 2>nul

echo.
echo [4/5] Waiting for Argo CD pods to be ready...
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=120s

echo.
echo [5/5] Starting Argo CD port-forward in separate window...
start "ArgoCD Port-Forward" cmd /k "kubectl port-forward svc/argocd-server -n argocd 8090:443"

echo.
echo ================================
echo Everything is up!
echo.
echo Production:  http://localhost:8080
echo Dev:         http://localhost:8081
echo Argo CD:     https://localhost:8090
echo.
echo NOTE: Don't close the ArgoCD window!
echo ================================
pause