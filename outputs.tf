output "bucket_name" {
  description = "Created bucket name."
  value       = google_storage_bucket.this.name
}

output "bucket_url" {
  description = "Cloud Storage URL."
  value       = "gs://${google_storage_bucket.this.name}"
}

output "bucket_self_link" {
  description = "Canonical bucket resource URL."
  value       = google_storage_bucket.this.self_link
}
