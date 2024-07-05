provider aws {
    region = "us-east-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

#Creating two buckets
resource "aws_s3_bucket" "bucket1" {
  bucket = "kaizen-daler"
}

resource "aws_s3_bucket" "bucket2" {
  bucket_prefix = "kaizen-"
}

#Creating two addtional buckets manually

resource "aws_s3_bucket" "kaizen-db" {
  bucket = "kaizen-db"
}

resource "aws_s3_bucket" "kaizen-db2" {
  bucket = "kaizen-db2"
}
# Import commands 
#terraform import aws_s3_bucket.kaizen-db kaizen-db
#terraform import aws_s3_bucket.kaizen-db2 kaizen-db2

