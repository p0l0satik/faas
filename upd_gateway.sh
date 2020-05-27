
kind load docker-image --name dev-openfaas openfaas/gateway:latest-dev

helm upgrade openfaas --recreate-pods openfaas/openfaas \
    --namespace openfaas  \
    --set basic_auth=true \
    --set openfaasImagePullPolicy=IfNotPresent \
    --set gateway.imagePullPolicy=IfNotPresent \
    --set gateway.image=openfaas/gateway:latest-dev \
    --set functionNamespace=openfaas-fn
kubectl rollout status deploy gateway --watch -n openfaas
kubectl -n openfaas port-forward deploy/gateway 31112:8080