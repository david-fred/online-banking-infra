resource "aws_eks_cluster" "main" {
  name     = "capstone-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.30" # Stable version

  vpc_config {
    # Provide both public and private subnets so EKS can deploy Load Balancers properly later
    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      aws_subnet.private_app_1.id,
      aws_subnet.private_app_2.id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}