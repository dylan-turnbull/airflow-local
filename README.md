# Run Airflow 2 Locally

According to the official [Airflow Installation](https://airflow.apache.org/docs/apache-airflow/stable/installation/index.html#) docs, there are several ways to install Airflow 2 locally. To encourage standardization of local environments at Avant, we offer our own instructions for installing Airflow. 

## Prerequisites
### \[Optional\] Install your preferred package manager

* [Homebrew](https://brew.sh/) (macOS, Linux)
* [Scoop](https://scoop.sh/) (Windows)
* [Chocolatey](https://chocolatey.org/install) (Windows)

### Install K9s

**macOS**
```bash
# Via Homebrew
brew install derailed/k9s/k9s

# Via MacPort
sudo port install k9s
```

**Linux**
```bash
# Via LinuxBrew
brew install derailed/k9s/k9s

# Via PacMan
pacman -S k9s
```

**Windows**
```bash
# Via Scoop
scoop install k9s

# Via Chocolatey
choco install k9s
```

### Install Helm

**macOS**
```bash
# Via Homebrew
brew install helm

# Via MacPort
sudo port install helm-3.11
```

**Linux**
```bash
# Via LinuxBrew
brew install helm

# Via PacMan
pacman -S helm
```

**Windows**
```bash
# Via Scoop
scoop install helm

# Via Chocolatey
choco install kubernetes-helm
```

### Install Docker Desktop

Install [Docker Desktop](https://www.docker.com/products/docker-desktop/), and use your Avant email to create a Docker account. 

### Clone the `airflow-local` repository

```bash
git clone https://github.com/dylan-turnbull/airflow-local.git
```

## Install Airflow 2 (simple)

### Copy sample DAGs to relevant directory

```bash
export DAGS_DIR="Documents/airflow-dags"
mkdir ~/${DAGS_DIR}
cp -r airflow-local/example-dags/* ~/${DAGS_DIR}
```

### Set up volume mounting

* Update Docker Desktop settings to allow mounting the `~/Documents/airflow-dags` directory (see screencap)
* In `airflow-volume.yml,` set the "PersistentVolume" configuration for `spec.hostPath.path` to `~/Documents/airflow-dags`

![alt text](images/mount_directory.png)

### Complete Airflow installation

```bash
kubectl apply -f airflow-local/airflow-volume.yml
helm repo add apache-airflow https://airflow.apache.org/
helm repo update
helm install airflow apache-airflow/airflow --version 1.6.0 -f values.yml
```

You should now have an installed Airflow chart (with release name "airflow" and namespace "default"). Confirm this by running `helm list`. 

```bash
NAME      	NAMESPACE	STATUS  	CHART        	APP VERSION
airflow	default  	deployed	airflow-1.6.0	2.3.0
```

## Ok Now What?

### Open a new terminal and run `k9s`

```bash
k9s
```

**NOTE**: You can switch between the kubernetes and celery executors by updating the `values.yml` file.

### "Port-Forward" `my-airflow-webserver`

* Scroll down to `my-airflow-webserver` service
* Type `<shift>` + `<f>`
* Select `OK`

![alt text](images/k9s.png)

### Open the Airflow UI

* In your web browser, go to [http://localhost:8080/home](http://localhost:8080/home) 
* Log into Airflow with username "admin" and password "admin"

### Do stuff

**Select an existing DAG and trigger it from the UI**

* Click on DAG in the home page
* Click "play" button in the DAGs page

![alt text](images/trigger_dag.png)

**Create a new DAG and trigger it from the command line**

* Create new python script (**REMEMBER**: DAG files are stored in `~/Documents/airflow-dags`)
* In `k9s`, select `my-airflow-webserver` service (using `<return>`)
* Access the shell of the running pod (using `<s>`)
* Run ```airflow dags trigger <new_dag_id>```

![alt text](images/create_new_dag.png)

![alt text](images/airflow_cli.png)

**NOTE**: You can exit out of the `k9s` shell by running the `exit` command, and you can "back out" of `k9s` filters by using `<esc>`.

## Install Airflow 2 (advanced)

If you want to install extra dependencies (e.g. a provider package) as part of your Airflow deployment you can do so in a custom Docker image.

### Update Dockerfile with relevant dependencies

```
FROM apache/airflow
COPY . /opt/airflow/dags
RUN pip install --no-cache-dir apache-airflow-providers-databricks
```

### Copy sample DAGs and Dockerfile to relevant directory

```bash
export DAGS_DIR="Documents/airflow-dags"
mkdir ~/${DAGS_DIR}
cp -r airflow-local/example-dags/* ~/${DAGS_DIR}
cp airflow-local/Dockerfile ~/${DAGS_DIR}/Dockerfile
```

### Complete Airflow installation

```bash
docker build --pull --tag my-image:0.0.1 ~/${DAGS_DIR}
helm repo add apache-airflow https://airflow.apache.org/
helm repo update
kubectl apply -f airflow-local/airflow-volume.yml
helm install airflow apache-airflow/airflow \
    --namespace default \
    --version 1.6.0 -f airflow-local/values.yml \
    --set images.airflow.repository=my-image \
    --set images.airflow.tag=0.0.1 \
    --wait=false
```

**ref**: https://github.com/airflow-helm/charts/tree/main/charts/airflow#frequently-asked-questions

