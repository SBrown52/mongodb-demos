locals {
 tags = {
    Name      = "sbr-example-tf"
    owner     = "sam.brown"
    expire-on = timeadd(timestamp(), "24h")
    purpose   = "training"
 }
}
