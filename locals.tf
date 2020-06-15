# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

locals {
    
    # base variables
    oci_base_identity = {
        api_fingerprint      = var.oci_base_identity.api_fingerprint
        api_private_key_path = var.oci_base_identity.api_private_key_path
        tenancy_id           = var.oci_base_identity.tenancy_id
        compartment_id       = var.oci_base_identity.compartment_id
        user_id              = var.oci_base_identity.user_id
        ssh_private_key_path = var.oci_base_identity.ssh_private_key_path
        ssh_public_key_path  = var.oci_base_identity.ssh_public_key_path
    }

    oci_base_general = {
        timezone             = var.oci_base_general.timezone
        region               = var.oci_base_general.region
        label_prefix         = var.oci_base_general.label_prefix
    }

    oci_base_vcn = {
        internet_gateway_enabled  = var.oci_base_vcn.internet_gateway_enabled
        nat_gateway_enabled       = var.oci_base_vcn.nat_gateway_enabled
        service_gateway_enabled   = var.oci_base_vcn.service_gateway_enabled
        tags                      = var.oci_base_vcn.tags
        vcn_cidr                  = var.oci_base_vcn.vcn_cidr
        vcn_dns_label             = var.oci_base_vcn.vcn_dns_label
        vcn_name                  = var.oci_base_vcn.vcn_name
        netnum                    = var.oci_base_vcn.netnum
        newbits                   = var.oci_base_vcn.newbits
    }

    oci_base_bastion = {
        availability_domain   = var.availability_domains["bastion"]
        access                = var.oci_base_bastion.access
        enabled               = var.oci_base_bastion.enabled
        image_id              = var.oci_base_bastion.image_id
        shape                 = var.oci_base_bastion.shape
        package_upgrade       = var.oci_base_bastion.package_upgrade
        netnum                = var.oci_base_vcn.netnum["bastion"]
        newbits               = var.oci_base_vcn.newbits["bastion"]
        notification_enabled  = var.oci_base_bastion.notification_enabled
        notification_endpoint = var.oci_base_bastion.notification_endpoint
        notification_protocol = var.oci_base_bastion.notification_protocol
        notification_topic    = var.oci_base_bastion.notification_topic
        ssh_private_key_path  = var.oci_base_identity.ssh_private_key_path
        ssh_public_key_path   = var.oci_base_identity.ssh_public_key_path
        tags                  = var.oci_base_bastion.tags
        timezone              = var.oci_base_general.timezone
    }

    oci_base_operator = {
        availability_domain       = var.availability_domains["operator"]
        enabled                   = var.oci_base_operator.enabled
        image_id                  = var.oci_base_operator.image_id
        shape                     = var.oci_base_operator.shape
        package_upgrade           = var.oci_base_operator.package_upgrade
        enable_instance_principal = var.oci_base_operator.enable_instance_principal
        netnum                    = var.oci_base_vcn.netnum["operator"]
        newbits                   = var.oci_base_vcn.newbits["operator"]
        notification_enabled      = var.oci_base_operator.notification_enabled
        notification_endpoint     = var.oci_base_operator.notification_endpoint
        notification_protocol     = var.oci_base_operator.notification_protocol
        notification_topic        = var.oci_base_operator.notification_topic
        ssh_private_key_path      = var.oci_base_identity.ssh_private_key_path
        ssh_public_key_path       = var.oci_base_identity.ssh_public_key_path
        tags                      = var.oci_base_operator.tags
        timezone                  = var.oci_base_general.timezone
    }

    # oke variables
    /* ocir = {
        api_fingerprint            = var.oci_base_identity.api_fingerprint
        api_private_key_path       = var.oci_base_identity.api_private_key_path
        tenancy_id                 = var.oci_base_identity.tenancy_id
        compartment_id             = var.oci_base_identity.compartment_id
        user_id                    = var.oci_base_identity.user_id
        home_region                = lookup(data.oci_identity_regions.home_region.regions[0], "name")
    }

    oke_general = {
        ad_names                   = sort(data.template_file.ad_names.*.rendered)
        label_prefix               = var.oci_base_general.label_prefix
        region                     = var.oci_base_general.region
    }

    oke_network_vcn = {
        is_service_gateway_enabled = var.oci_base_vcn.service_gateway_enabled
        vcn_id                     = module.vcn.vcn_id
        ig_route_id                = module.vcn.ig_route_id
        nat_route_id               = module.vcn.nat_gateway_id
        vcn_cidr                   = var.oci_base_vcn.vcn_cidr
        netnum                     = var.oci_base_vcn.netnum["workers"]
        newbits                    = var.oci_base_vcn.newbits["workers"]
    }

    oke_network_worker = {
        allow_node_port_access     = var.oke_config.allow_node_port_access
        allow_worker_ssh_access    = var.oke_config.allow_worker_ssh_access
        worker_mode                = var.oke_config.worker_mode
    }

    oke_identity = {
        compartment_id             = var.oci_base_identity.compartment_id
        user_id                    = var.oci_base_identity.user_id
    }

    oke_admin = {
        bastion_public_ip        = module.bastion.bastion_public_ip
        admin_private_ip         = module.operator.operator_private_ip
        bastion_enabled          = var.oci_base_bastion.enabled
        admin_enabled            = var.oci_base_operator.enabled
        admin_instance_principal = var.oci_base_operator.enable_instance_principal
    }

    oke_cluster = {
        cluster_kubernetes_version                              = var.oke_config.kubernetes_version
        cluster_name                                            = var.oke_config.cluster_name
        cluster_options_add_ons_is_kubernetes_dashboard_enabled = var.oke_config.dashboard_enabled
        cluster_options_kubernetes_network_config_pods_cidr     = var.oke_config.pods_cidr
        cluster_options_kubernetes_network_config_services_cidr = var.oke_config.services_cidr
        #cluster_subnets                                         = module.okenetwork.subnet_ids
        vcn_id                                                  = module.vcn.vcn_id
        use_encryption                                          = var.oke_config.use_encryption
        kms_key_id                                              = var.oci_base_identity.existing_key_id
    }

    node_pools = {
        node_pools            = var.oke_config.node_pools
        node_pool_name_prefix = var.oke_config.node_pool_name_prefix
        node_pool_image_id    = var.oke_config.node_pool_image_id
        node_pool_os          = var.oke_config.node_pool_os
        node_pool_os_version  = var.oke_config.node_pool_os_version
    }

    lbs = {
        preferred_lb_subnets = var.oke_config.preferred_lb_subnets
    }

    oke_ocir = {
        email_address     = var.ocir_config.email_address
        ocir_urls         = var.ocir_config.ocir_urls
        tenancy_name      = var.ocir_config.tenancy_name
        username          = var.ocir_config.username
        secret_id         = var.oci_base_identity.secret_id
        existing_key_id   = var.oci_base_identity.existing_key_id
    }

    helm = {
        helm_version = var.oke_config.helm_version
        install_helm = var.oke_config.install_helm
    }

    calico = {
        calico_version = var.oke_config.calico_version
        install_calico = var.oke_config.install_calico
    }

    oke_kms = {
        use_encryption = var.oke_config.use_encryption
        key_id         = var.oci_base_identity.existing_key_id
    }

    service_account = {
        create_service_account               = var.oke_config.create_service_account
        service_account_name                 = var.oke_config.service_account_name
        service_account_namespace            = var.oke_config.service_account_namespace
        service_account_cluster_role_binding = var.oke_config.service_account_cluster_role_binding
    } */
} 
