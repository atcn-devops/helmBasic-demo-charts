**This is sample usage of helm deployment with rollback enhancement logic**

Details see below script
> helmDeploy.sh

Update values.yaml with incorrect image value to make the deployment failed.

```yaml
deployment:
  replicaCount: 1
  name: my-deployment
  image:
    app: nginx222222222222222
    version: latest
```
Run the tests...
```bash
bengi.w.j.yang 6_simplechart_helm_deploy_rollback $ ./helmDeploy.sh
Starting Helm upgrade...
history.go:56: [debug] getting history for release simple
Release "simple" does not exist. Installing it now.
install.go:218: [debug] Original chart version: ""
install.go:235: [debug] CHART PATH: /Users/bengi.w.j.yang/work/kubernetes/helm/helmBasic-demo-charts/6_simplechart_helm_deploy_rollback

client.go:142: [debug] creating 2 resource(s)
wait.go:48: [debug] beginning wait for 2 resources with timeout of 10s
ready.go:297: [debug] Deployment is not ready: default/my-deployment. observedGeneration (0) does not match spec generation (1).
ready.go:303: [debug] Deployment is not ready: default/my-deployment. 0 out of 1 expected pods are ready
ready.go:303: [debug] Deployment is not ready: default/my-deployment. 0 out of 1 expected pods are ready
ready.go:303: [debug] Deployment is not ready: default/my-deployment. 0 out of 1 expected pods are ready
ready.go:303: [debug] Deployment is not ready: default/my-deployment. 0 out of 1 expected pods are ready
Error: client rate limiter Wait returned an error: context deadline exceeded
helm.go:84: [debug] client rate limiter Wait returned an error: context deadline exceeded
Deployment failed. Initiating rollback or uninstall.
Last successful revision: 
No successful revision found. Uninstalling release.
release "simple" uninstalled
bengi.w.j.yang 6_simplechart_helm_deploy_rollback $ 
```