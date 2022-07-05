# Run Airflow Locally

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
    - `git clone yada-yada-yada`

Work in progress, for now, use this:
```
mkdir ~/Documents/airflow-dags
cp -r example-dags/* ~/Documents/airflow-dags

#### Update Docker desktop settings to allow mounting the ~/Documents/airflow-dags directory ####

# edit airflow-volume.yml to point to the full airflow-dags path
kubectl apply -f airflow-volume.yml

helm repo add apache-airflow https://airflow.apache.org/

helm repo update

helm install my-airflow apache-airflow/airflow --version 1.6.0 -f values.yml
```

path: "{HOME_DIR}/airflow-dags"

