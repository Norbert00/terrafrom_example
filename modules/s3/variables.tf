variable "bucket_name" {
  type = string
}

variable "bucket_acl" {
  type = string
}

variable "bucket_s3_tag" {
  type = map(string)
}


variable "block_public_acls" {
  type = bool
}

variable "block_public_policy" {
  type = bool
}

variable "ignore_public_acls" {
  type = bool
  
}
variable "restrict_public_buckets" {
  type = bool
}
variable "bucket_versioning" {
  type = string
}

