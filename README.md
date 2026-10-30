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

Replace the example Nexus hostname, repository, and version with your published artifact URL.

## Local validation

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

See [examples/basic](examples/basic) for a runnable example.

## Centralized GitHub Actions

This module consumes reusable workflows from the central repository:
[terraform-github-actions-templates](https://github.com/manojrasia/terraform-github-actions-templates).

The organization-level layout is:

```text
GitHub Organization
├── terraform-github-actions-templates
│   └── .github/workflows/
│       ├── terraform-validate.yml
│       ├── terraform-security.yml
│       ├── terraform-plan.yml
│       ├── terraform-apply.yml
│       └── terraform-release-nexus.yml
├── terraform-google-gcs
└── platform-infrastructure
```

### Workflows used by this module

- [terraform-ci.yml](.github/workflows/terraform-ci.yml): calls the central validation and Checkov security workflows for pull requests and pushes to `main`.
- [release-module.yml](.github/workflows/release-module.yml): calls the central Nexus release workflow for version tags (`v*.*.*`) or manual releases.

**Plan and apply are intentionally not called from this module repository.** This repository defines a reusable module, not a deployable root configuration. Run plan/apply from `platform-infrastructure`, where concrete values, provider authentication, remote state, and environment approvals belong.

### Required repository configuration

In `terraform-google-gcs`, configure these Actions secrets:

- `NEXUS_URL`: Nexus base URL, e.g. `https://nexus.example.com`
- `NEXUS_USERNAME`
- `NEXUS_PASSWORD`

Configure this Actions variable:

- `NEXUS_RAW_REPOSITORY`: hosted Nexus Raw repository name

The Nexus release workflow uses a self-hosted Linux runner labelled `self-hosted`, `linux`, and `nexus-local`, with `zip`, `curl`, and network access to Nexus.

Allow the central workflow repository under **Settings → Actions → General → Access** for this repository. The central repository must also be configured to allow access from caller repositories.

For production, pin reusable workflow references to protected release tags or immutable commit SHAs after testing.
