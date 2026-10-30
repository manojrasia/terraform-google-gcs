# terraform-google-gcs

Reusable Terraform module for creating a secure Google Cloud Storage bucket.

## Features

- Uniform bucket-level access enabled
- Public access prevention enforced
- Object versioning enabled by default
- Configurable location, storage class, labels, and force-destroy behavior
- Terraform lifecycle protection against accidental bucket deletion

## Usage

```hcl
module "gcs" {
  source = "https://nexus.example.com/repository/terraform-modules/terraform-google-gcs/1.0.0/terraform-google-gcs-1.0.0.zip"

  project_id         = "my-gcp-project"
  bucket_name        = "my-globally-unique-bucket-name"
  location           = "asia-south1"
  storage_class      = "STANDARD"
  versioning_enabled = true

  labels = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

Replace the example Nexus hostname and version with your own published artifact URL.

## Validate

```bash
terraform fmt -check -recursive
terraform init
terraform validate
```

See [examples/basic](examples/basic) for a runnable example.
