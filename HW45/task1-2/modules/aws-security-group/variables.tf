variable "sg_name" {
  type = string
  description = "Security group name"
}

variable "sg_description" {
  type = string
  description = "Security group description"
}

variable "cidr_for_mng" {
  type = list
  description = "IP for SSH"
}

variable "cidr_for_data" {
  type = list
  description = "IP for user access"
}

variable "port_mng" {
  type = string
  description = "SSH management port"
}

variable "ports_list" {
  type = map
  description = "List of opened ports"
}

variable "tags_list" {
  type = map
  description = "List of tags"
  default = {
      Name = "Test"
      Owner = "Aleks"
      Target = "For Test"
  }
}