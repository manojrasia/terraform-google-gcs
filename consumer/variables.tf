variable "project_id" {
  type        = string
  description = "GCP project ID."
}

variable "bucket_name" {
  type        = string
  description = "Globally unique bucket name."
}

variable "location" {
  type        = string
  description = "Bucket location."
  default     = "asia-south1"
}
