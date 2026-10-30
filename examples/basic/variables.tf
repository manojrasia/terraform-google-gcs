variable "project_id" {
  type        = string
  description = "GCP project ID."
}

variable "bucket_name" {
  type        = string
  description = "Globally unique bucket name."
}

variable "region" {
  type        = string
  description = "GCP region."
  default     = "asia-south1"
}
