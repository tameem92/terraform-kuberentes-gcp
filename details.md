**Problem Statement**
Whenever we are running any infrastructure, best practice is to use infrastructure as code so it can be versioned and maintained properly. In this recipe we will be creating and managing a GKE cluster using terraform.

**Solution**
Terraform is a great tool for managing infrastructure in the cloud. This recipe uses terraform's official google_cluster module to maintain a cluster with a custom node pool. The state of the cluster will be stored as terraform state in Google Cloud storage. This will allow you to version state of the cluster and easily modify this cluster as required be rerunning terraform script.
