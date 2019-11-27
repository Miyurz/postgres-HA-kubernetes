#!/bin/bash

kubectl delete ns sqlanalytics
kubectl create ns sqlanalytics
kubectl apply -f role.yaml
kubectl apply -f role-binding.yaml
kubectl apply -f configmap.yaml
kubectl apply -f secret-2.yaml
kubectl -n sqlanalytics run -i -t stolonctl --image=sorintlab/stolon:master-pg10 --restart=Never --rm -- /usr/local/bin/stolonctl --cluster-name=kube-stolon --store-backend=kubernetes --kube-resource-kind=configmap init --yes
kubectl apply -f sentinel.yaml
kubectl apply -f statefulset.yaml
kubectl apply -f proxy.yaml
kubectl apply -f proxy_service.yaml
kubectl apply -f job-configmap.yaml
sleep 5
kubectl apply -f job.yaml
