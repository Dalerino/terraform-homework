terraform {
  backend "s3" {
    bucket = "daler-kaizen"
    key    = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "lock-state"
  }
}