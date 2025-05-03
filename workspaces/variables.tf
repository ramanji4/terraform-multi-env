variable "instance_type" {
    default = {
        dev = "t3.micro"
        qa = "t3.small"
        prod = "t3.medium"
    }
}