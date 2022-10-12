volume_dir=$(yq '.local_dag_path' values.yml)
mkdir -p ${volume_dir}
cp -r example-dags/* ${volume_dir}
CHARTS=$(helm list -q -A)

if echo "$CHARTS" | grep -F -wq "local-airflow"; then 
    echo Updating Airflow...
    helm upgrade local-airflow ./airflow -f values.yml
else
    echo Installing Airflow...
    helm install local-airflow ./airflow -f values.yml
fi
