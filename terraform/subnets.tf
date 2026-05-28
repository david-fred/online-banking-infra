# --- Public Subnets ---
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name                                     = "public-subnet-1a"
    "kubernetes.io/cluster/capstone-cluster" = "shared"
    "kubernetes.io/role/elb"                 = "1" # Required for external Load Balancers
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name                                     = "public-subnet-1b"
    "kubernetes.io/cluster/capstone-cluster" = "shared"
    "kubernetes.io/role/elb"                 = "1"
  }
}

# --- Private App Subnets (For EKS Nodes) ---
resource "aws_subnet" "private_app_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name                                     = "private-app-subnet-1a"
    "kubernetes.io/cluster/capstone-cluster" = "shared"
    "kubernetes.io/role/internal-elb"        = "1" # Required for internal Load Balancers
  }
}

resource "aws_subnet" "private_app_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name                                     = "private-app-subnet-1b"
    "kubernetes.io/cluster/capstone-cluster" = "shared"
    "kubernetes.io/role/internal-elb"        = "1"
  }
}

# --- Private DB Subnets (For RDS) ---
resource "aws_subnet" "private_db_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-db-subnet-1a"
  }
}

resource "aws_subnet" "private_db_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-db-subnet-1b"
  }
}