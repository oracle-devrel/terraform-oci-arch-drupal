## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "drupal" {
  source                    = "github.com/oracle-devrel/terraform-oci-arch-drupal"
  tenancy_ocid              = var.tenancy_ocid
  vcn_id                    = oci_core_virtual_network.drupal_mds_vcn.id
  numberOfNodes             = 1
  availability_domain_name  = var.availability_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availability_domain_name
  compartment_ocid          = var.compartment_ocid
  image_id                  = lookup(data.oci_core_images.InstanceImageOCID.images[0], "id")
  shape                     = var.node_shape
  label_prefix              = var.label_prefix
  ssh_authorized_keys       = var.ssh_public_key
  mds_ip                    = module.mds-instance.mysql_db_system.ip_address
  drupal_subnet_id          = oci_core_subnet.drupal_subnet.id
  admin_password            = var.admin_password
  admin_username            = var.admin_username
  drupal_schema             = var.drupal_schema
  drupal_name               = var.drupal_name
  drupal_password           = var.drupal_password
  display_name              = var.drupal_instance_name
  flex_shape_ocpus          = var.node_flex_shape_ocpus
  flex_shape_memory         = var.node_flex_shape_memory
}

