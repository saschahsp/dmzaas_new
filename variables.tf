# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# provider parameters

variable "oci_base_identity" {
  type = object({
    api_fingerprint      = string
    api_private_key_path = string
    tenancy_id           = string
    compartment_id       = string
    user_id              = string
    ssh_private_key_path = string
    ssh_public_key_path  = string
    ##existing_key_id      = string
    ##secret_id            = string
  })
  description = "oci identity parameters"
}

variable "oci_base_general" {
  type = object({
    region               = string
    timezone             = string
    label_prefix         = string
  })
  description = "general oci parameters"
  default = {
    region               = "eu-frankfurt-1"
    timezone             = "Europe/Berlin"
    label_prefix         = "dmz"
  }
}

variable "availability_domains" {
  type = map(number)
  description = "data center targets in a region"
  default = {
    bastion  = 1
    operator = 1
    oke      = 1
    adb      = 1
  }
}

variable "oci_base_vcn" {
  type = object({
    internet_gateway_enabled = bool
    nat_gateway_enabled      = bool
    service_gateway_enabled  = bool
    tags                     = map(any)
    vcn_cidr                 = string
    vcn_dns_label            = string
    vcn_name                 = string
    netnum                   = map(any)
    newbits                  = map(any)
  })
  description = "VCN parameters"
  default = {
    internet_gateway_enabled = true
    nat_gateway_enabled      = true
    service_gateway_enabled  = true
    tags                     = null
    vcn_cidr                 = "10.0.0.0/16"
    vcn_dns_label            = ""
    vcn_name                 = ""
    netnum = {
      bastion  = 32
      operator = 33
      web      = 16
    }
    newbits = {
      bastion  = 13
      operator = 13
      web      = 11
    }
    tags = {
      department  = "dmz"
      environment = "uat"
    }
  }
}

# bastion
variable "oci_base_bastion" {
  type = object({
    access                = string
    enabled               = bool
    image_id              = string
    shape                 = string
    package_upgrade       = bool
    notification_enabled  = bool
    notification_endpoint = string
    notification_protocol = string
    notification_topic    = string
    tags                  = map(any)
  })
  description = "bastion host parameters"
  default = {
    access                = "ANYWHERE"
    enabled               = false
    image_id              = "Autonomous"
    shape                 = ""
    package_upgrade       = true
    notification_enabled  = false
    notification_endpoint = ""
    notification_protocol = "EMAIL"
    notification_topic    = "bastion"
    tags = {
      department  = "dmz"
      environment = "test"
      role        = "bastion"
    }
  }
}

# operator
variable "oci_base_operator" {
  type = object({
    enabled                   = bool
    image_id                  = string
    shape                     = string
    package_upgrade           = bool
    enable_instance_principal = bool
    notification_enabled      = bool
    notification_endpoint     = string
    notification_protocol     = string
    notification_topic        = string
    tags                      = map(any)
  })
  description = "operator host parameters"
  default = {
    enabled                   = false
    image_id                  = "Oracle"
    shape                     = ""
    package_upgrade           = true
    enable_instance_principal = false
    notification_enabled      = false
    notification_endpoint     = ""
    notification_protocol     = "EMAIL"
    notification_topic        = "operator"
    tags = {
      department  = "dmz"
      environment = "uat"
      role        = "operator"
    }
  }
}

# oke
/* variable "oke_config" {
  type = object({
    allow_node_port_access               = bool
    allow_worker_ssh_access              = bool
    cluster_name                         = string
    dashboard_enabled                    = bool
    kubernetes_version                   = string
    node_pools                           = map(any)
    node_pool_name_prefix                = string
    node_pool_image_id                   = string
    node_pool_os                         = string
    node_pool_os_version                 = string
    pods_cidr                            = string
    services_cidr                        = string
    worker_mode                          = string
    lb_subnet_type                       = string
    preferred_lb_subnets                 = string
    helm_version                         = string
    install_helm                         = bool
    calico_version                       = string
    install_calico                       = bool
    install_metricserver                 = bool
    use_encryption                       = bool
    existing_key_id                      = string
    create_service_account               = bool
    service_account_name                 = string
    service_account_namespace            = string
    service_account_cluster_role_binding = string
  })
  description = "oke configuration parameter"
  default = {
    allow_node_port_access  = false
    allow_worker_ssh_access = false
    cluster_name            = "dmz_oke"
    dashboard_enabled       = true
    kubernetes_version      = "LATEST"
    node_pools = {
      np1                   = ["VM.Standard2.1", 3]
      #np2                  = ["VM.Standard2.8", 4]
      #np3                  = ["VM.Standard1.4", 5]
    }
    node_pool_name_prefix   = "dmz"
    node_pool_image_id      = ""
    node_pool_os            = "Oracle Linux"
    node_pool_os_version    = "7.7"
    pods_cidr               = "10.244.0.0/16"
    services_cidr           = "10.96.0.0/16"
    worker_mode             = "private"
    # oke load balancers
    lb_subnet_type          = "public"
    preferred_lb_subnets    = "public"
    # helm
    helm_version            = "3.1.0"
    install_helm            = false
    # calico
    calico_version          = "3.12"
    install_calico          = false
    # metrics server
    install_metricserver    = false
    use_encryption          = false
    existing_key_id         = "id of existing key"
    # service account
    create_service_account               = false
    service_account_name                 = "kubeconfigsa"
    service_account_namespace            = "kube-system"
    service_account_cluster_role_binding = "myapps-manage-binding"
  }
} */

# ocir
/* variable "ocir_config" {
  type = object({
    tenancy_name     = string
    username         = string
    email_address    = string
    secret_id        = string
    existing_key_id  = string
    ocir_urls        = map(string)
  })
  description = "oke configuration parameter"
  default = {
    username        = "dmz_k8s_admin"
    email_address   = "ocilabs@mail.com"
    tenancy_name    = "sabanga"
    existing_key_id = "ocid1.key.oc1.eu-frankfurt-1.bfpm3aygaaaao.abtheljrckd7dzop24rrg2ergrtprsma5xeqfdmxt65itmx5vwhlggyuet3q"
    secret_id       = "ocid1.vaultsecret.oc1.eu-frankfurt-1.amaaaaaagkul77qafcyfbtk5pcztqv2wvktfkx53mbnugese4gpbtlacmxha"
    ocir_urls = {
      ap-sydney-1           = "syd.ocir.io"
      ap-melbourne-1        = "mel.ocir.io"
      ap-mumbai-1           = "bom.ocir.io"
      ap-osaka-1            = "kix.ocir.io"
      ap-seoul-1            = "icn.ocir.io"
      ap-tokyo-1            = "nrt.ocir.io"
      ca-montreal-1         = "yul.ocir.io"
      ca-toronto-1          = "yyz.ocir.io"
      eu-amsterdam-1        = "ams.ocir.io"
      eu-frankfurt-1        = "fra.ocir.io"
      eu-zurich-1           = "zrh.ocir.io"
      me-jeddah-1           = "jed.ocir.io"
      sa-saopaulo-1         = "gru.ocir.io"
      uk-london-1           = "lhr.ocir.io"
      us-ashburn-1          = "iad.ocir.io"
      us-phoenix-1          = "phx.ocir.io"
    }
  }
} */