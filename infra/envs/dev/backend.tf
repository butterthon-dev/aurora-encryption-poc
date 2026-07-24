terraform {
  backend "s3" {
    bucket       = "dev-poc-terraform-state-bucket"
    key          = "default.tfstate"
    region       = "us-west-2"
    use_lockfile = true
  }
}
