variable "location" {
  description = "The location/region of the resource"
  default     = "centralus"
}

variable "environment" {
  description = "The environment for the resources"
  default     = "dev"
  validation {
    condition     = can(regex("^(dev|test|stage|prod)$", var.environment))
    error_message = "The environment must be dev, test, stage or prod"
  }
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    owner = "DevOps Team"
    tier  = "Tier1"
  }

}
