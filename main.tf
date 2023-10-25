# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create two subnets
resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

# Create a security group
resource "aws_security_group" "web" {
  name_prefix = "web-"
  
  # Define your security group rules here
}

# Create an EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-12345678" # Specify a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id
  security_groups = [aws_security_group.web.id]
}

# Create an RDS database
resource "aws_db_instance" "my_database" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "myuser"
  password             = "mypassword"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

output "instance_ip" {
  value = aws_instance.web_server.public_ip
}
