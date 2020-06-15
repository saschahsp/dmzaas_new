provider "template" {
  version              = "~> 2.1"
}

provider "oci" {
  version              = "~> 3.78"
  tenancy_ocid         = var.oci_base_identity.tenancy_id
  user_ocid            = var.oci_base_identity.user_id
  fingerprint          = var.oci_base_identity.api_fingerprint
  private_key_path     = var.oci_base_identity.api_private_key_path
  region               = var.oci_base_general.region
  disable_auto_retries = false
}