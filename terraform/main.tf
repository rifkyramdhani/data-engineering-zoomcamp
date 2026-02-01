terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.17.0"
    }
  }
}

provider "google" {
  project = "secret-tide-486014-v9"
  region  = "us-central1"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "secret-tide-486014-v9-terra-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}