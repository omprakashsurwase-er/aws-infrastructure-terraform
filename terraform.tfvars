cat > terraform.tfvars << 'EOF'
aws_region              = "us-east-1"
project_name            = "myapp"
vpc_cidr                = "10.0.0.0/16"
public_subnet_1_cidr    = "10.0.1.0/24"
public_subnet_2_cidr    = "10.0.2.0/24"
private_subnet_1_cidr   = "10.0.10.0/24"
private_subnet_2_cidr   = "10.0.11.0/24"
instance_type           = "t3.micro"
app_port                = 3000
ssh_cidr                = "0.0.0.0/0"
asg_min_size            = 2
asg_max_size            = 4
asg_desired_capacity    = 2
EOF