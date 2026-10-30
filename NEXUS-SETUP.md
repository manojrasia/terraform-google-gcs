# Local Nexus and GitHub Actions setup

## Start Nexus

```bash
docker compose up -d
docker logs -f nexus
```

Open http://localhost:8081, retrieve the initial admin password from the Nexus data volume, and complete the setup wizard. Create a **Raw (hosted)** repository named `terraform-modules`.

Create a dedicated Nexus publisher account with permission to upload and read artifacts. Do not use the admin account in CI.

## Configure the GitHub Actions runner

A GitHub-hosted runner cannot reach your computer's `localhost:8081`. Install a self-hosted GitHub Actions runner on the same machine as Nexus, or on a machine with network access to Nexus. Add the runner labels `linux` and `nexus-local`.

The workflow targets:

```yaml
runs-on: [self-hosted, linux, nexus-local]
```

For a Nexus server on another machine, use its reachable private DNS name or IP instead of localhost. Use HTTPS, firewall restrictions, and private networking for shared or production use.

## Configure repository secrets and variables

In GitHub repository Settings > Secrets and variables > Actions, add:

**Secrets**
- `NEXUS_URL`: for example `http://localhost:8081`
- `NEXUS_USERNAME`: dedicated publisher username
- `NEXUS_PASSWORD`: dedicated publisher password

**Variable**
- `NEXUS_RAW_REPOSITORY`: `terraform-modules`

Never commit Nexus credentials.

## Publish a release

```bash
git tag v1.0.0
git push origin v1.0.0
```

The workflow checks Terraform formatting, packages the module, creates a SHA-256 checksum, and uploads both files under:

```
<your-nexus-url>/repository/terraform-modules/terraform-google-gcs/1.0.0/
```

## Consume the module

See `consumer/main.tf`. Replace localhost with the Nexus hostname reachable from the Terraform execution environment, and choose the published version. Use HTTPS and appropriate authentication/network controls outside a local demo.
