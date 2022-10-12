# Airflow


# How to pull in Vault Secrets
```yaml
external_secrets:
- name: the-kube-secret-name
  refresh_interval: 30m
  creation_policy: Owner
  deletion_policy: Retain
  secret_store:
    name: foo-store
    kind: ClusterSecretStore
  keys:
  - kube_secret_key: the-kube-secret-key-name
    vault_secret_path: "secret/data/path/in/vault"
    vault_secret_property: "vault-secret-property-that-contins-secret-data"
    vault_secret_version: if-needed--the-vault-secret-version
    conversion_strategy: Default
```