variable "user_defined" {
  description = "A user-defined field that describes the Azure resource."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.user_defined) >= 2 && length(var.user_defined) <= 15
    error_message = "The user-defined field must be between 2-15 characters long."
  }
}

variable "government" {
  type        = bool
  default     = false
  description = "Sets which naming convention to use. If true, use SSC's otherwise use StatCan's."
}

variable "name_attributes_ssc" {
  type = object({
    department_code = string
    environment     = string
    csp_region          = string
  })

  validation {
    condition     = length(var.name_attributes_ssc.environment) == 1
    error_message = "Environment must be 1 character long"
  }

  validation {
    condition     = length(var.name_attributes_ssc.department_code) == 2
    error_message = "Department code must be 1 character long"
  }

  validation {
    condition     = length(var.name_attributes_ssc.region) == 1
    error_message = "Region must be 1 character long"
  }

  validation {
    condition = var.government
    error_message = "The government variable is required to be true when setting the name_attributes_ssc variable."
  }
}
