#
# Gluster storage volumes
#
resource "aws_ebs_volume" "gluster" {
    availability_zone = "${var.region}${element( split( ",", lookup( var.azs, var.region ) ), count.index )}"
    size              = 5
    count             = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
    tags {
        Name = "gluster-vol0${count.index+1}"
    }
}

resource "aws_volume_attachment" "gluster_att" {
  device_name = "/dev/xvdb"
  volume_id   = "${element(aws_ebs_volume.gluster.*.id, count.index)}"
  instance_id = "${element(aws_instance.gluster.*.id, count.index)}"
  count = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
}

resource "aws_ebs_volume" "gluster_bis" {
    availability_zone = "${var.region}${element( split( ",", lookup( var.azs, var.region ) ), count.index )}"
    size              = 5
    count             = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
    tags {
        Name = "gluster-vol1${count.index+1}"
    }
}

resource "aws_volume_attachment" "gluster_bis_att" {
  device_name = "/dev/xvdb"
  volume_id   = "${element(aws_ebs_volume.gluster_bis.*.id, count.index)}"
  instance_id = "${element(aws_instance.gluster_bis.*.id, count.index)}"
  count = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
}
