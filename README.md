# Run Airflow 2 Locally

According to the official [Airflow Installation](https://airflow.apache.org/docs/apache-airflow/stable/installation/index.html#) docs, there are several ways to install Airflow 2 locally. To encourage standardization of local environments at Avant, we offer our own instructions for installing Airflow. 

## Prerequisites
### 0. \[Optional\] Install your preferred package manager

* [Homebrew](https://brew.sh/) (macOS, Linux)
* [Scoop](https://scoop.sh/) (Windows)
* [Chocolatey](https://chocolatey.org/install) (Windows)

### 1. Install K9s

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

### 2. Install Helm

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

### 3. Install Docker Desktop

Install [Docker Desktop](https://www.docker.com/products/docker-desktop/), and use your Avant email to create a Docker account. 

### 4. Clone the `airflow-local` repository

```bash
git clone https://github.com/dylan-turnbull/airflow-local.git
```

### 5. Install Airflow 2

**Copy sample DAGs to relevant directory**
```bash
mkdir ~/Documents/airflow-dags
cp -r example-dags/* ~/Documents/airflow-dags
```

**Update Docker desktop settings to allow mounting the `~/Documents/airflow-dags` directory**
![alt text](images/mount_directory.png)

**Complete Airflow installation**
```bash
kubectl apply -f airflow-volume.yml
helm repo add apache-airflow https://airflow.apache.org/
helm repo update
helm install my-airflow apache-airflow/airflow --version 1.6.0 -f values.yml
```

**Note**
You can switch between the kubernetes and celery executors by updating the `values.yml` file.

## Ok Now What?

### 1. Open a new terminal and run `k9s`

```bash
k9s
```

### 2. "Port-Forward" `my-airflow-webserver`

* Scroll down to `my-airflow-webserver` service
* Type `<shift>` + `<f>`
* Select `OK`

![alt text](images/k9s.png)

### 3. Open the Airflow UI in your web browser (`http://localhost:8080/home`) 

### 4. Log in with username "admin" and password "admin"

### 5. Do stuff

**Select a sample DAG and trigger it**

![alt text](images/k9s.png)

**Create a new DAG**

![alt text](images/create_new_dag.png)

Remember: DAG files are stored in `~/Documents/airflow-dags`

