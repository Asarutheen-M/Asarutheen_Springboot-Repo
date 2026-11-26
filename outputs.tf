output "ecr_repository_url" { value = aws_ecr_repository.app.repository_url }
output "cluster_name"       { value = module.eks.cluster_name }
