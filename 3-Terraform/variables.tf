variable "region" {
    type = string
    default = "europe-central2"
}
variable "project" {
    type = string
}

variable "user" {
    type = string
}

#variable "email" {
#    type = string
#}
variable "privatekeypath" {
    type = string
    default = "~/.ssh/id_rsa"
}

variable "publickeypath" {
    type = string
    default = "~/.ssh/id_rsa.pub"
}

variable "environments" {
  type        = list(string)
  description = "The list of environments"
}

variable "image" {
  description = "The name of bot_image"
  type = map(string)
  nullable    = false
}
