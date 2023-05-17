#!/usr/bin/env bash

manifests=(
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/00-certmanager.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/01-certmanager-issuer.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/02-istio-base.yaml 
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/03-istio-ns.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/04-istio.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/05-dex.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/06-oidc-authservice.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/07-knative.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/08-knative-serving.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/09-knative-eventing.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/10-kubeflow-namespace.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/11-kubeflow-roles.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/12-istio-resources.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/13-kubeflow-pipelines.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/14-kserve.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/15-models-wa.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/16-katib.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/17-dashboard.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/18-admission-webhook.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/19-notebook-controller.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/20-jupyter-webapp.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/21-kfam.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/22-volumes-wa.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/23-tensorboards.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/24-tensorboards-controller.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/25-training-operator.yaml
  https://raw.githubusercontent.com/eschercloudai/dist-kubeflow/main/26-default-user-ns.yaml
)
for manifest in "${manifests[@]}"; do
	count=0
	until kubectl apply -f $manifest || [ $count -eq 5 ]; do
		count=$((count+1))
		echo "‼️ Failed to apply $manifest, retrying in 10 seconds"
		sleep 10
	done
	if [ $count -eq 5 ]; then
		echo "$manifest failed to apply after 5 attempts"
	fi
done
echo "Kubeflow deployed, please wait while all services come up"
