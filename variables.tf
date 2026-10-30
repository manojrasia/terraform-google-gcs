variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "bucket_name" {
  description = "Globally unique Cloud Storage bucket name."
  type        = string
}

variable "location" {
  description = "Bucket location, such as US or asia-south1."
  type        = string
  default     = "US"
}

variable "storage_class" {
  description = "Cloud Storage storage class."
  type        = string
  default     = "STANDARD"
}

variable "versioning_enabled" {
  description = "Enable object versioning."
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow Terraform to delete a non-empty bucket."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels applied to the bucket."
  type        = map(string)
  default     = {}
}
