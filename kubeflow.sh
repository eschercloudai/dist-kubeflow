#!/usr/bin/env bash

manifests=(
  00-certmanager.yaml
  01-certmanager-issuer.yaml
  02-istio-base.yaml 
  03-istio-ns.yaml
  04-istio.yaml
  05-dex.yaml
  06-oidc-authservice.yaml
  07-knative.yaml
  08-knative-serving.yaml
  09-knative-eventing.yaml
  10-kubeflow-namespace.yaml
  11-kubeflow-roles.yaml
  12-istio-resources.yaml
  13-kubeflow-pipelines.yaml
  14-kserve.yaml
  15-models-wa.yaml
  16-katib.yaml
  17-dashboard.yaml
  18-admission-webhook.yaml
  19-notebook-controller.yaml
  20-jupyter-webapp.yaml
  21-kfam.yaml
  22-volumes-wa.yaml
  23-tensorboards.yaml
  24-tensorboards-controller.yaml
  25-training-operator.yaml
  26-default-user-ns.yaml
)
for manifest in "${manifests[@]}"; do
	count=0
	until kubectl apply -f $manifest || [ $count -eq 5 ]; do
		echo "Failed to apply $manifest, retrying in 10 seconds"
		sleep 10
	done
	if [ $count -eq 5 ]; then
		echo "$manifest failed to apply after 5 attempts"
	fi
done
