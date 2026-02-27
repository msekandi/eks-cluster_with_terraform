variable "cluster_name" {}
variable "node_role_arn" {}
variable "private_subnets" {
  type = list(string)
}