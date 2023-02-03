variable "public_key" {
  description = "The public API key for MongoDB Atlas"
}
variable "private_key" {
  description = "The private API key for MongoDB Atlas"
}
variable "atlasprojectid" {
  description = "Atlas project ID"
}
variable "access_key" {
  description = "The access key for AWS Account"
}
variable "secret_key" {
  description = "The secret key for AWS Account"
}
variable "atlas_region" {
  default     = "EU_WEST_1"
  description = "Atlas Region"
}
variable "aws_region" {
  default     = "eu-west-1"
  description = "AWS Region"
}