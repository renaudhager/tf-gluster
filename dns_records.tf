#
# Consul key for FQDN
#
resource "consul_keys" "gluster_dns_record" {
    datacenter = "${data.terraform_remote_state.vpc_rs.vdc}"
    count      = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
    # Create the entry for DNS
    key {
        path = "app/bind/${data.terraform_remote_state.vpc_rs.vdc}.lan/gluster-0${count.index+1}"
        value = "A ${element(aws_instance.gluster.*.private_ip, count.index)}"
        delete = true
    }
}

resource "consul_keys" "gluster_bis_dns_record" {
    datacenter = "${data.terraform_remote_state.vpc_rs.vdc}"
    count      = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
    # Create the entry for DNS
    key {
        path = "app/bind/${data.terraform_remote_state.vpc_rs.vdc}.lan/gluster-1${count.index+1}"
        value = "A ${element(aws_instance.gluster.*.private_ip, count.index)}"
        delete = true
    }
}
