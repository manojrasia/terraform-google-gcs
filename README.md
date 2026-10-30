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

Replace the example Nexus hostname, repository, and version with your own published artifact URL.

## Validate locally

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

See [examples/basic](examples/basic) for a runnable example.

## Centralized GitHub Actions release

This repository delegates its release pipeline to the reusable workflow in
[terraform-github-actions-templates](https://github.com/manojrasia/terraform-github-actions-templates/tree/terraformgcp).

The caller workflow is [.github/workflows/release-module.yml](.github/workflows/release-module.yml).
It runs when a version tag matching `v*.*.*` is pushed, or manually through
**Actions → Release Terraform module to Nexus → Run workflow**.

The shared workflow performs:

1. Checkout of this module repository.
2. Terraform formatting check, initialization without a backend, and validation.
3. Creation of `terraform-google-gcs-<version>.zip` and its SHA-256 checksum.
4. Upload of both files to the configured Nexus Raw repository.

### Required GitHub Actions configuration

Set these repository secrets in **Settings → Secrets and variables → Actions → Secrets**:

- `NEXUS_URL`: Nexus base URL, for example `https://nexus.example.com`
- `NEXUS_USERNAME`
- `NEXUS_PASSWORD`

Set this repository variable in **Settings → Secrets and variables → Actions → Variables**:

- `NEXUS_RAW_REPOSITORY`: name of the Nexus hosted Raw repository

### Runner requirements

The reusable workflow currently targets a self-hosted Linux runner with labels
`self-hosted`, `linux`, and `nexus-local`. The runner needs network access to
Nexus and the `zip` and `curl` utilities.

Because the shared workflow is in another repository, allow it under
**terraform-google-gcs → Settings → Actions → General → Access** if GitHub
requires cross-repository workflow access to be enabled.

For production, pin the reusable workflow to a protected release tag or commit SHA
instead of the development branch ref `@terraformgcp`.
