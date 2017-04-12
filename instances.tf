#
# Gluster instances
#
resource "aws_instance" "gluster" {
  ami = "${data.aws_ami.centos7_ami.id}"
  instance_type               = "${var.instance_gluster}"
  subnet_id                   = "${element(split( ",", data.terraform_remote_state.vpc_rs.private_subnet), count.index)}"
  key_name                    = "${var.ssh_key_name}"
  vpc_security_group_ids      = ["${aws_security_group.gluster.id}"]
  user_data                   = "${element(data.template_file.gluster.*.rendered, count.index)}"
  associate_public_ip_address = false
  # This does not work :-(
  #count                       = "${length( split( ",", data.terraform_remote_state.vpc_rs.azs ) )}"
  count                       = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
  tags {
    Name  = "gluster-0${count.index+1}"
    Owner = "${var.owner}"
  }
}

resource "aws_instance" "gluster_bis" {
  ami = "${data.aws_ami.centos7_ami.id}"
  instance_type               = "${var.instance_gluster}"
  subnet_id                   = "${element(split( ",", data.terraform_remote_state.vpc_rs.private_subnet), count.index)}"
  key_name                    = "${var.ssh_key_name}"
  vpc_security_group_ids      = ["${aws_security_group.gluster.id}"]
  user_data                   = "${element(data.template_file.gluster_bis.*.rendered, count.index)}"
  associate_public_ip_address = false
  # This does not work :-(
  #count                       = "${length( split( ",", data.terraform_remote_state.vpc_rs.azs ) )}"
  count                       = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
  tags {
    Name  = "gluster-1${count.index+1}"
    Owner = "${var.owner}"
  }
}


#
# Output
#
output "gluster_bis_ip" {
  value = ["${aws_instance.gluster_bis.*.private_ip}"]
}
