resource "aws_iam_role" "this" {
  name               = "${var.name_prefix}-role-${var.role_name}"
  assume_role_policy = local.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
