# --- DB Subnet Group ---
resource "aws_db_subnet_group" "main" {
  name = "capstone-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_db_1.id,
    aws_subnet.private_db_2.id
  ]

  tags = {
    Name = "capstone-db-subnet-group"
  }
}

# --- RDS Security Group ---
resource "aws_security_group" "rds_sg" {
  name        = "capstone-rds-sg"
  description = "Allow MySQL inbound traffic from within the VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "MySQL traffic from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "capstone-rds-sg"
  }
}

# --- RDS MySQL Instance ---
resource "aws_db_instance" "main" {
  identifier             = "capstone-mysql-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "capstonedb"
  username               = "admin"
  password               = "digitalwitch2026" # In a prod environment, this would be in AWS Secrets Manager
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # High Availability setup
  multi_az = true

  # For the sake of the capstone project, allow deletion without taking a snapshot
  skip_final_snapshot = true

  tags = {
    Name = "capstone-mysql-db"
  }
}