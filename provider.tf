provider "template" {
  version              = "~> 2.1"
}

provider "oci" {
  version              = "~> 3.78"
  tenancy_ocid         = var.oci_base_identity.tenancy_id
  region               = var.oci_base_general.region
  disable_auto_retries = false
}