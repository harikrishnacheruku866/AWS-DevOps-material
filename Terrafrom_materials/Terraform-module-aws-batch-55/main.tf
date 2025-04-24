

module "my_ec2" {
  source        = "./modules/ec2-instance"
  ami           = "ami-0b86aaed8ef90e45f" # Update with your region-specific AMI
  instance_type = "t2.micro"
  instance_name = "MyFirstModuleEC2"
}