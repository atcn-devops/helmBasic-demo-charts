#!/bin/bash

# To exit whenever any failure
set -e

# Externalize release name as an environment variable
RELEASE_NAME=${RELEASE_NAME:-simple}

# Function to perform rollback or uninstall
rollback_or_uninstall() {
    last_successful_rev=$(helm history $RELEASE_NAME | grep -B 1 "deployed" | tail -n 1 | awk '{print $1}')
    echo "Last successful revision: $last_successful_rev"
    if [ -n "$last_successful_rev" ]; then
        echo "Rolling back to revision $last_successful_rev"
        helm rollback $RELEASE_NAME $last_successful_rev
    else
        echo "No successful revision found. Uninstalling release."
        helm uninstall $RELEASE_NAME || echo "Release not found."
    fi
}

# Deploy Nginx using Helm
echo "Starting Helm upgrade..."
if helm upgrade $RELEASE_NAME . --install --wait --timeout 10s --debug; then
    echo "Helm deployment scheduling completed, now checking pod if in running state."

    # Todo: enhance logic here to check pod status(values get from deployment yaml or helm values
    # Define the label key and value from the Helm template
    label_key="app"
    label_value="nginx"

    # Check if the pod with the specified label value is in the running state
    if kubectl get pod -l "${label_key}=${label_value}" -n default | grep "Running" &> /dev/null; then
        echo "Pod with label ${label_key}=${label_value} is in running state. Deployment successful."
    else
        echo "Pod with label ${label_key}=${label_value} is not in running state. Deployment failed."
    fi
else
    echo "Deployment failed. Initiating rollback or uninstall."
    rollback_or_uninstall
fi
