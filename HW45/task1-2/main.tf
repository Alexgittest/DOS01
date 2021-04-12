provider "aws" {
    region = "us-east-1"
    shared_credentials_file = "/root/.aws/credentials "
}

module "aws-sg" {
  source = "./modules/aws-security-group"
  sg_name = "aleks-sg"
  sg_description = "sg for test"
  ports_list = {
      "80"="HTTP",
      "443" ="HTTPS",
      "8080"="HTTP"
    }
  port_mng = "22"
  cidr_for_mng = ["46.53.250.98/32"]
  cidr_for_data = ["0.0.0.0/0"]
  tags_list = {
      Name="sg",
      Owner="Aleks",
      Target="for test"
  }

}



