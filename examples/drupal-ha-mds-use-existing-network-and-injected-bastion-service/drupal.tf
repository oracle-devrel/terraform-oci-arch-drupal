## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "oci-arch-drupal" {
  source                          = "github.com/oracle-devrel/terraform-oci-arch-drupal"
  tenancy_ocid                    = var.tenancy_ocid
  vcn_id                          = oci_core_virtual_network.drupal_mds_vcn.id
  numberOfNodes                   = 2
  availability_domain_name        = var.availability_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availability_domain_name
  compartment_ocid                = var.compartment_ocid
  image_id                        = lookup(data.oci_core_images.InstanceImageOCID.images[0], "id")
  shape                           = var.node_shape
  ssh_authorized_keys             = var.ssh_public_key
  mds_ip                          = module.mds-instance.mysql_db_system.ip_address
  drupal_subnet_id                = oci_core_subnet.drupal_subnet.id
  lb_subnet_id                    = oci_core_subnet.lb_subnet_public.id 
  bastion_subnet_id               = oci_core_subnet.bastion_subnet_public.id 
  fss_subnet_id                   = oci_core_subnet.fss_subnet_private.id 
  admin_password                  = var.admin_password
  admin_username                  = var.admin_username
  drupal_schema                   = var.drupal_schema
  drupal_name                     = var.drupal_name
  drupal_password                 = var.drupal_password
  display_name                    = var.drupal_name
  lb_shape                        = var.lb_shape 
  flex_lb_min_shape               = var.flex_lb_min_shape 
  flex_lb_max_shape               = var.flex_lb_max_shape 
  inject_bastion_service_id       = true
  use_bastion_service             = true
  inject_bastion_server_public_ip = false
  bastion_service_id              = oci_bastion_bastion.bastion_service.id
  bastion_service_region          = var.region
}

