# The  public API key for MongoDB Atlas
variable "public_key" {
  description = "The public API key for MongoDB Atlas"
  sensitive = true
}

# The  public API key for MongoDB Atlas
variable "private_key" {
  description = "The private API key for MongoDB Atlas"
  sensitive = true
}

variable "project_id" {
  description = "The ID of the Atlas project to deploy to"
  sensitive = true
}