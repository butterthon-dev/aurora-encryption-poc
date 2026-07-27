# 現在の最新のAmazon Linux 2 AMIを取得
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Amazon Linux 2
  }

  owners = ["amazon"]
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "${var.name_prefix}-${var.instance_name}"
  }

  lifecycle {
    ignore_changes = [ami]
  }
}

# IAMロールをEC2インスタンスに紐づける
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.name_prefix}-profile-${var.instance_name}"
  role = var.attach_role_name
}
