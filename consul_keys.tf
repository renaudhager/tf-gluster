#
# Consul key for signing in Puppet
#
resource "consul_keys" "gluster_signing" {
    datacenter = "${data.terraform_remote_state.vpc_rs.vdc}"
    count      = "${length( split( ",", lookup( var.azs, var.region ) ) )}"

    key {
        path = "${data.terraform_remote_state.vpc_rs.vdc}/signed/gluster-0${count.index+1}.${var.tld}"
        value = "true"
        delete = true
    }
}

resource "consul_keys" "gluster_bis_signing" {
    datacenter = "${data.terraform_remote_state.vpc_rs.vdc}"
    count      = "${length( split( ",", lookup( var.azs, var.region ) ) )}"

    key {
        path = "${data.terraform_remote_state.vpc_rs.vdc}/signed/gluster-1${count.index+1}.${var.tld}"
        value = "true"
        delete = true
    }
}
