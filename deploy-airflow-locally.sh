echo "Storing dags in ${1}"

mkdir -p ${1}

cp -r example-dags/* ${1}

kubectl create -f $(sed "s/DAG_DIR/'${1}'/g" airflow-volume.yml)

