# GKE terraform cluster management

This repo contains easy setup for Kubernetes cluster in GKE using terraform.
Allows you to manage and maintain the state of multiple clusters.

## Requirements

You need to make sure you have the required tools to run this repo. 

```sh
# Install terraform
brew install terraform

# Install and setup gcloud cli as well
brew install gcloud

# Initialize and setup gcloud towards your google cloud account
gcloud init
```

## Setup

To run the terraform scripts you need to make sure the environment variable for your credentials is
set. Head over to google cloud and create a service account https://cloud.google.com/iam/docs/creating-managing-service-accounts.

The service account needs access to Cloud Storage, Kuberentes, and Compute.

```sh
# Specify the location of your service account file
export GOOGLE_CREDENTIALS=/Users/Tameem/work/personal/terraform-gcp-kuberentes/config/account.json
```

The config variables are available in config/cluster.tfvars and can be updated in there.

## Running terraform

```sh
# Run terraform init to setup state file
terraform init

# Run terraform plan to checkout changes that will be applied
terraform plan -var-file config/cluster.tfvars

# Apply terraform to start creating the infrastructure
terraform apply -var-file config/cluster.tfvars
```

