variable "environment" {
  description = "Environment name, used as prefix"

  type    = string
  default = null
}

variable "key_name" {
  description = "Key pair name"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = list(string)
  default     = []
}
