variable "instances" {
    type = map
}

variable "zone_id" {
    default = "Z09654101CXVBN7HDWZ5Y"
}

variable "domain_name" {
    default = "ram4india.space"
}

variable "common_tags" {
    type = map
    default = {
        Project = "expense"
        terraform = "True"
    }
}

variable "sg_name" {
    default = "allow_ssh"
}

variable "sg_description" {
    default = "Allow port number 22 for SSH protocol connection"
}

variable "from_port" {
    default = "22"
    type = number
}

variable "to_port" {
    default = "22"
}

variable "protocol" {
    default = "tcp"
}

variable "ingress_cidr" {
    default = ["0.0.0.0/0"]
    type = list(string) 
}

variable "tags" {
    type = map
}

variable "environment" {
}