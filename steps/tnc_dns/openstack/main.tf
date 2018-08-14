provider "openstack" {
  profile = "${var.tectonic_openstack_profile}"
  region  = "${var.tectonic_openstack_region}"
  version = ">=1.6.0"
}

/*
resource "openstack_route53_record" "tectonic_tnc_cname" {
  name    = "${var.tectonic_cluster_name}-tnc.${var.tectonic_base_domain}"
  count   = "${var.tectonic_bootstrap == "true" ? 1 : 0}"

  ttl     = "1"
  type    = "CNAME"
  zone_id = "${local.private_zone_id}"

  records = ["${local.tnc_s3_bucket_domain_name}"]

}

resource "openstack_route53_record" "tectonic_tnc_a" {
  name       = "${var.tectonic_cluster_name}-tnc.${var.tectonic_base_domain}"
  count      = "${var.tectonic_bootstrap == "true" ? 0 : 1}"

  depends_on = ["openstack_route53_record.tectonic_tnc_cname"]
  type       = "A"
  zone_id    = "${local.private_zone_id}"

  alias {
    name                   = "${local.tnc_elb_dns_name}"
    zone_id                = "${local.tnc_elb_zone_id}"
    evaluate_target_health = true
  }
}*/

