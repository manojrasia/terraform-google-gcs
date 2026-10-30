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
  region  = var.region
}

module "gcs" {
  source = "../../"

  project_id         = var.project_id
  bucket_name        = var.bucket_name
  location           = var.region
  versioning_enabled = true

  labels = {
    environment = "demo"
    managed_by  = "terraform"
  }
}
