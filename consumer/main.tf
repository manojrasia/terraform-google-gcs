terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0, < 8.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.location
}

module "gcs" {
  source = "http://localhost:8081/repository/terraform-modules/terraform-google-gcs/1.0.0/terraform-google-gcs-1.0.0.zip"

  project_id         = var.project_id
  bucket_name        = var.bucket_name
  location           = var.location
  versioning_enabled = true

  labels = {
    environment = "demo"
    managed_by  = "terraform"
  }
}
