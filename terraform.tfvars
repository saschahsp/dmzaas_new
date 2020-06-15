# general oci parameters
oci_base_general  = {
  region       = "eu-frankfurt-1"
  timezone     = "Europe/Berlin"
  label_prefix = "dmz"
}

availability_domains  = {
  bastion  = 1
  operator = 1
  oke      = 1
  adb      = 1
}

oci_base_vcn = {
  internet_gateway_enabled     = true
  nat_gateway_enabled          = true
  service_gateway_enabled      = true
  vcn_cidr                     = "10.0.0.0/16"
  vcn_dns_label                = "dmztest"
  vcn_name                     = "test"
  netnum = {
    bastion  = 32
    operator = 33
    int_lb  = 16
    pub_lb  = 17
    workers = 1
  }
  newbits = {
    bastion  = 13
    operator = 13
    lb      = 11
    workers = 2
  }
  tags = {
    department  = "dmz"
    environment = "test"
  }
}

oci_base_bastion = {
  availability_domain   = 1
  access                = "ANYWHERE"
  enabled               = true
  image_id              = "Autonomous"
  shape                 = "VM.Standard.E2.2"
  package_upgrade       = true
  notification_enabled  = false
  notification_endpoint = "torsten.boettjer@oracle.com"
  notification_protocol = "EMAIL"
  notification_topic    = "bastion"
  ssh_private_key_path  = "~/.ssh/id_rsa"
  ssh_public_key_path   = "~/.ssh/id_rsa.pub"
  timezone              = "Europe/Berlin"
  tags = {
    department  = "dmz"
    environment = "test"
    role        = "bastion"
  }
}

oci_base_operator = {
  availability_domain       = 1
  enabled                   = true
  image_id                  = "Oracle"
  shape                     = "VM.Standard.E2.2"
  package_upgrade           = false
  enable_instance_principal = true
  notification_enabled      = false
  notification_endpoint     = "torsten.boettjer@oracle.com"
  notification_protocol     = "EMAIL"
  notification_topic        = "bastion"
  ssh_private_key_path      = "~/.ssh/id_rsa"
  ssh_public_key_path       = "~/.ssh/id_rsa.pub"
  timezone                  = "Europe/Berlin"
  tags = {
    department  = "dmz"
    environment = "test"
    role        = "operator"
  }
}

/* oke_config = {
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
  helm_version            = "3.0.0"
  install_helm            = false
  # calico
  calico_version          = "3.9"
  install_calico          = false
  # metrics server
  install_metricserver    = false
  use_encryption          = false
  existing_key_id         = ""
  # service account
  create_service_account               = false
  service_account_name                 = "kubeconfigsa"
  service_account_namespace            = "kube-system"
  service_account_cluster_role_binding = "myapps-manage-binding"
} */

/* ocir_config = {
  username        = "dmz_k8s_admin"
  email_address   = "ocilabs@mail.com"
  tenancy_name    = "sabanga"
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
} */