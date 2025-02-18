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
  description = "Sets which naming convention to use. If true, use SSC's naming convention and set the name_attributes_ssc variable."
}

variable "name_attributes_ssc" {
  type = object({
    department_code    = string
    csp_region         = string
    environment        = string
  })

  default = {
    department_code    = ""
    csp_region         = ""
    environment        = ""
  }

  description = <<EOT
    name_attributes_ssc = {
      department_code : "Two character code that uniquely identifies departments across the GC. REQUIRED."
      csp_region : "Single character code that identifies Cloud Service Provider and Region. REQUIRED."
      environment : "Single character code that identifies environment. REQUIRED."
    }
  EOT

  validation {
    condition     = var.government || (var.name_attributes_ssc.department_code == "" && var.name_attributes_ssc.csp_region == "" && var.name_attributes_ssc.environment == "")
    error_message = "The variable 'name_attributes_ssc' must not be set if the variable 'government' is set to false."
  }

  validation {
    condition     = (!var.government || length(var.name_attributes_ssc.environment) == 1)
    error_message = "Environment must be 1 character long."
  }

  validation {
    condition     = (!var.government || length(var.name_attributes_ssc.department_code) == 2)
    error_message = "Department code must be 2 characters long."
  }

  validation {
    condition     = (!var.government || length(var.name_attributes_ssc.csp_region) == 1)
    error_message = "CSP region must be 1 character long."
  }
}
