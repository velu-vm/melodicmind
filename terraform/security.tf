resource "aws_security_group" "app_sg" {
  name        = "melodicmind-sg"
  description = "Allow HTTP traffic to ALB and ECS tasks"
  vpc_id      = data.aws_vpc.default.id

  # Inbound rule for ALB (port 80)
  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule (allow all)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Team = "The Ideators"
  }
}
