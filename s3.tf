data "aws_iam_policy_document" "ssh_public_keys" {
  statement {
    sid = "VPCAllow",
    principals {
      type = "AWS",
      identifiers = ["*"]
    },
    effect = "Allow",
    actions = ["s3:GetObject"],
    resources = ["${aws_s3_bucket.ssh_public_keys.arn}/*"],
    condition {
      test = "StringEquals",
      variable = "aws:SourceVpc",
      values = ["${var.vpc_id}"]
    }
  }
}

resource "aws_s3_bucket_policy" "ssh_public_keys" {
  bucket = "${aws_s3_bucket.ssh_public_keys.bucket}"
  policy = "${data.aws_iam_policy_document.ssh_public_keys.json}"
}

resource "aws_s3_bucket" "ssh_public_keys" {
  region = "us-west-2"
  bucket_prefix = "ssh-keys"
  acl = "private"
  website {}
}

resource "aws_s3_bucket_object" "ssh_public_keys" {
  bucket = "${aws_s3_bucket.ssh_public_keys.bucket}"
  key = "${element(split(",", var.authorized_key_names), count.index)}.pub"
  content = "${file("../../../keys/ssh/${element(var.authorized_key_names,count.index)}.pub")}"
  count = "${length(split(",", var.authorized_key_names))}"
  depends_on = ["aws_s3_bucket.ssh_public_keys"]
}


