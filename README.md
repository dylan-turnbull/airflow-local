# Run Airflow Locally

**Prerequisites**
- k9s -> `brew install k9s`
- kubectl -> `brew install kubectl`
- helm -> `brew install helm`
- yq -> `brew install yq`

## Prerequisites
1. Download K9s
    - MacOs  
        ```
        # Via Homebrew
        brew install derailed/k9s/k9s
        # Via MacPort
        sudo port install k9s
        ```
    - Linux
        ```
        # Via LinuxBrew
        brew install derailed/k9s/k9s
        # Via PacMan
        pacman -S k9s
        ```
    - Windows  
        ```
        # Via scoop
        scoop install k9s
        # Via chocolatey
        choco install k9s
        ```
2. Clone this repository
    - `git clone https://github.com/dylan-turnbull/airflow-local.git`
    
3. Edit `values.yml` to point to the full airflow-dags path.

4. Deploy Airflow
    - `sh deploy-airflow-locally.sh`

**Note:**  
You can switch between the kubernetes and celery executors by updating the values.yml file

## Connecting to the Airflow UI
Create a port forward to the webserver: `kubectl port-forward deployment/local-airflow-webserver 8080:8080`
Open a browser and navigate to `http://localhost:8080/`