# --- Internet Gateway ---
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "capstone-igw"
  }
}

# --- Elastic IPs for NAT Gateways ---
resource "aws_eip" "nat_1" {
  domain = "vpc"
  tags   = { Name = "capstone-eip-1a" }
}

resource "aws_eip" "nat_2" {
  domain = "vpc"
  tags   = { Name = "capstone-eip-1b" }
}

# --- NAT Gateways ---
resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.nat_1.id
  subnet_id     = aws_subnet.public_1.id
  tags          = { Name = "capstone-nat-1a" }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.nat_2.id
  subnet_id     = aws_subnet.public_2.id
  tags          = { Name = "capstone-nat-1b" }

  depends_on = [aws_internet_gateway.igw]
}