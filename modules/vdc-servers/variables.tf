variable "ssh_pub_key" {
  type = string
}

variable "vdc_lb" {
  type = number
}

variable "vdc_web" {
  type = number
}

variable "vdc_db" {
  type = number
}

variable "image" {
  type = string
}

variable "flavor_lb" {
  type = string
}

variable "flavor_web" {
  type = string
}

variable "flavor_db" {
  type = string
}

variable "volume_lb" {
  type = number
}

variable "volume_web" {
  type = number
}

variable "volume_db" {
  type = number
}
