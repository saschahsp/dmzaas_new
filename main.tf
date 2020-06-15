# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "1.0.1"

  # identity parameters
  compartment_id           = local.oci_base_identity.compartment_id

  # general oci parameters
  region                   = local.oci_base_general.region
  label_prefix             = local.oci_base_general.label_prefix

  # vcn parameters
  internet_gateway_enabled = local.oci_base_vcn.internet_gateway_enabled
  nat_gateway_enabled      = local.oci_base_vcn.nat_gateway_enabled
  service_gateway_enabled  = local.oci_base_vcn.service_gateway_enabled
  tags                     = local.oci_base_vcn.tags
  vcn_cidr                 = local.oci_base_vcn.vcn_cidr
  vcn_dns_label            = local.oci_base_vcn.vcn_dns_label
  vcn_name                 = local.oci_base_vcn.vcn_name
}

module "bastion" {
  source  = "oracle-terraform-modules/bastion/oci"
  version = "1.0.1"

  # provider identity parameters
  tenancy_id           = local.oci_base_identity.tenancy_id
  compartment_id       = local.oci_base_identity.compartment_id
  user_id              = local.oci_base_identity.user_id
  api_fingerprint      = local.oci_base_identity.api_fingerprint
  api_private_key_path = local.oci_base_identity.api_private_key_path

  # general oci parameters
  region               = local.oci_base_general.region
  label_prefix         = local.oci_base_general.label_prefix

  # network parameters
  availability_domain = local.oci_base_bastion.availability_domain
  bastion_access      = local.oci_base_bastion.access
  vcn_id              = module.vcn.vcn_id
  ig_route_id         = module.vcn.ig_route_id
  netnum              = local.oci_base_vcn.netnum["bastion"]
  newbits             = local.oci_base_vcn.newbits["bastion"]

  # bastion parameters
  bastion_enabled     = local.oci_base_bastion.enabled
  bastion_image_id    = local.oci_base_bastion.image_id
  bastion_shape       = local.oci_base_bastion.shape
  bastion_upgrade     = local.oci_base_bastion.package_upgrade
  ssh_public_key      = ""
  ssh_public_key_path = local.oci_base_bastion.ssh_public_key_path
  timezone            = local.oci_base_bastion.timezone

  # notification
  notification_enabled  = local.oci_base_bastion.notification_enabled
  notification_endpoint = local.oci_base_bastion.notification_endpoint
  notification_protocol = local.oci_base_bastion.notification_protocol
  notification_topic    = local.oci_base_bastion.notification_topic

  # tags
  tags = local.oci_base_bastion.tags
}

module "operator" {
  source  = "oracle-terraform-modules/operator/oci"
  version = "1.0.6"

  # identity parameters
  api_fingerprint        = local.oci_base_identity.api_fingerprint
  api_private_key_path   = local.oci_base_identity.api_private_key_path
  tenancy_id             = local.oci_base_identity.tenancy_id
  compartment_id         = local.oci_base_identity.compartment_id
  user_id                = local.oci_base_identity.user_id
  ssh_public_key_path    = local.oci_base_identity.ssh_public_key_path
  ssh_public_key         = ""

  # general oci parameters
  region               = local.oci_base_general.region
  label_prefix         = local.oci_base_general.label_prefix
  timezone             = local.oci_base_operator.timezone
  tags                 = local.oci_base_operator.tags

  # network parameters
  availability_domain  = local.oci_base_operator.availability_domain
  nat_route_id         = module.vcn.nat_route_id
  vcn_id               = module.vcn.vcn_id
  netnum               = local.oci_base_vcn.netnum["operator"]
  newbits              = local.oci_base_vcn.newbits["operator"]

  # operator parameters
  operator_enabled            = local.oci_base_operator.enabled
  operator_image_id           = local.oci_base_operator.image_id
  operator_instance_principal = local.oci_base_operator.enable_instance_principal
  operator_shape              = local.oci_base_operator.shape
  operator_upgrade            = local.oci_base_operator.package_upgrade

  # notification
  notification_enabled  = local.oci_base_operator.notification_enabled
  notification_endpoint = local.oci_base_operator.notification_endpoint
  notification_protocol = local.oci_base_operator.notification_protocol
  notification_topic    = local.oci_base_operator.notification_topic
}

/* module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "2.2.0"

  # identity parameters
  api_fingerprint        = local.oci_base_identity.api_fingerprint
  api_private_key_path   = local.oci_base_identity.api_private_key_path
  tenancy_id             = local.oci_base_identity.tenancy_id
  compartment_id         = local.oci_base_identity.compartment_id
  user_id                = local.oci_base_identity.user_id
  ssh_private_key_path   = local.oci_base_identity.ssh_private_key_path
  ssh_public_key_path    = local.oci_base_identity.ssh_public_key_path

  # project settings
  region                = local.oci_base_general.region
  label_prefix          = local.oci_base_general.label_prefix

  # base settings
  vcn_name                      = local.oci_base_vcn.vcn_name
  vcn_dns_label                 = local.oci_base_vcn.vcn_dns_label
  admin_notification_endpoint   = local.oci_base_bastion.notification_endpoint
  admin_timezone                = local.oci_base_operator.timezone
  bastion_shape                 = local.oci_base_bastion.shape
  bastion_timezone              = local.oci_base_bastion.timezone
  bastion_notification_endpoint = local.oci_base_operator.notification_endpoint

  # ocir settings
  username                      = local.oke_ocir.username
  email_address                 = local.oke_ocir.email_address
  tenancy_name                  = local.oke_ocir.tenancy_name
  existing_key_id               = local.oke_ocir.existing_key_id
  secret_id                     = local.oke_ocir.secret_id

  # oke configuration
  cluster_name                           = local.oke_cluster.cluster_name
  node_pools                             = local.node_pools.node_pools
  service_account_cluster_role_binding   = local.service_account.service_account_cluster_role_binding
} */

## --- Storage Bucket ---
#module "bucket" {
#  source            = "./data/bucket"
#  compartment_ocid  = var.compartment_ocid
#  access_type       = "NoPublicAccess"
#  display_name      = "${var.name}_Bucket"
#}

## --- Autonomuous Database ---
#module "adb" {
#  source            = "./data/adb"
#  compartment_ocid  = var.compartment_ocid
#  type              = "DW"                    # OLTP or DW
#  db_name           = "smartrdb"
#  display_name      = "${var.name}_DB"
#}