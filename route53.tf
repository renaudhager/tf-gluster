#
# ROUTE 53
#
resource "aws_route53_record" "gluster" {
  zone_id = "${data.terraform_remote_state.vpc_rs.default_route53_zone}"
  name    = "gluster-0${count.index+1}"
  type    = "A"
  ttl     = "300"
  records = ["${element(aws_instance.gluster.*.private_ip, count.index)}"]
  count   = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
}

resource "aws_route53_record" "gluster_bis" {
  zone_id = "${data.terraform_remote_state.vpc_rs.default_route53_zone}"
  name    = "gluster-1${count.index+1}"
  type    = "A"
  ttl     = "300"
  records = ["${element(aws_instance.gluster_bis.*.private_ip, count.index)}"]
  count   = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
}
