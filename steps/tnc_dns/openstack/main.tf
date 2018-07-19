provider "openstack" {
  region  = "${var.tectonic_openstack_region}"
  profile = "${var.tectonic_openstack_profile}"
  version = "1.6.0"
}

/*
resource "openstack_route53_record" "tectonic_tnc_cname" {
  count   = "${var.tectonic_bootstrap == "true" ? 1 : 0}"
  zone_id = "${local.private_zone_id}"
  name    = "${var.tectonic_cluster_name}-tnc.${var.tectonic_base_domain}"
  type    = "CNAME"
  ttl     = "1"

  records = ["${local.tnc_s3_bucket_domain_name}"]
}

resource "openstack_route53_record" "tectonic_tnc_a" {
  depends_on = ["openstack_route53_record.tectonic_tnc_cname"]
  count      = "${var.tectonic_bootstrap == "true" ? 0 : 1}"
  zone_id    = "${local.private_zone_id}"
  name       = "${var.tectonic_cluster_name}-tnc.${var.tectonic_base_domain}"
  type       = "A"

  alias {
    name                   = "${local.tnc_elb_dns_name}"
    zone_id                = "${local.tnc_elb_zone_id}"
    evaluate_target_health = true
  }
}*/
