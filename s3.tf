resource "aws_s3_bucket" "ssh_public_keys" {
  region = "us-west-2"
  bucket_prefix = "ssh-keys"
  acl = "public-read"
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_object" "ssh_public_keys" {
  bucket = "${aws_s3_bucket.ssh_public_keys.bucket}"
  key = "${element(var.authorized_key_names,count.index)}.pub"
  content = "${file("../../../keys/ssh/${element(var.authorized_key_names,count.index)}.pub")}"
  count = "${length(var.authorized_key_names)}"
  depends_on = ["aws_s3_bucket.ssh_public_keys"]
}
