terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.4.0"
    }
  }
  backend "gcs" {
    bucket = "k8s-workspace-tf-state"
    prefix = "dev"
  }
}

provider "google" {
  project = "kubernetes-workspace-336702"
  region  = "us-east4"
  zone    = "us-east4-a"
}

resource "google_service_account" "default" {
  account_id = "terraform"
  display_name = "Terraform Service Account"
}

module "k8s" {
  source ="./k8s"
  
  service_account = google_service_account.default.email
}