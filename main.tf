# Lock terraform version
terraform {
  required_version = ">= 0.11.11"
}

# We want the state to be stores in Google 
# cloud storage. 
terraform {
  backend "gcs" {
    bucket  = "ruksack-tf-state-bucket"
    prefix  = "terraform/state"
  }
}

provider "google" {
  credentials = "${file("config/account.json")}"
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}

resource "google_container_cluster" "primary" {
  name     = "${var.cluster_name}"
  location = "${var.gcp_zone}"
  initial_node_count = "${var.initial_node_count}"


  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true

  # Setting an empty username and password explicitly disables basic auth
  master_auth {
    username = ""
    password = ""
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "node-pool-primary"
  location   = "us-central1"
  
  cluster    = "${google_container_cluster.primary.name}"
  node_count = "${var.initial_node_count}"

  node_config {
    preemptible  = true
    machine_type = "${var.node_machine_type}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}

