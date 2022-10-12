# Run Airflow Locally

### Prerequisites
The following packages are needed:
- k9s: A lightweight graphical Kubernetes client -> `brew install k9s`
- kubectl: The standard Kubernetes command-line tool -> `brew install kubectl`
- helm: A tool for installing, and upgrading applications running on Kubernetes -> `brew install helm`
- yq: jq, but for yaml -> `brew install yq`

You will also need to have [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed with [Kubernetes enabled](https://docs.docker.com/desktop/kubernetes/#enable-kubernetes).

### Deploying Airflow
1. Clone this repository -> `git clone https://github.com/dylan-turnbull/airflow-local.git`
    
2. Edit `values.yml` to point to the full airflow-dags path.  
    **Note**: On MacOS the dag path will need to be somewhere within the `/Users` directory

3. Deploy Airflow -> `sh deploy-airflow-locally.sh`  
    **Note**: This script can be run for both the initial install and to deploy changes to the values.yaml file

**Note:**  
You can switch between the kubernetes and celery executors by updating the values.yml file

### Connecting to the Airflow UI
Create a port forward to the webserver: `kubectl port-forward deployment/local-airflow-webserver 8080:8080`
Open a browser and navigate to `http://localhost:8080/`

### Connecting to Airflows StatsD Exporter
For those that would like to see what stats are exported by Airflows StatsD exporter:
Create a port forward to the exporter: `kubectl port-forward deployment/local-airflow-statsd 9102:9102`
Open a browser and navigate to `http://localhost:9102/metrics`

### Additional Information:
**Helm Resources**  
[An Introduction to Helm Video](https://www.youtube.com/watch?v=Zzwq9FmZdsU)  
[Helm Values (values.yaml) Documentation](https://helm.sh/docs/chart_template_guide/values_files/)  
[Helm Commands](https://helm.sh/docs/helm/helm/)  
 
**Kubernetes Resources**  
[Kubernetes Deployments Reference](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
