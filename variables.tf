variable "user_defined" {
  description = "A user-defined field that describes the Azure resource."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.user_defined) >= 2 && length(var.user_defined) <= 15
    error_message = "The user-defined field must be between 2-15 characters long."
  }
}

variable "naming_convention" {
  type        = string
  default     = "stc"
  description = "Sets which naming convention to use. Accepted values: stc, ssc"
  validation {
    condition     = var.naming_convention == "ssc" || var.naming_convention == "stc"
    error_message = "The accepted values for the government variable are: stc, ssc."
  }
}

variable "name_attributes" {
  type = object({
    department_code = string
    csp_region      = string
    environment     = string
  })

  default = {
    department_code = ""
    csp_region      = ""
    environment     = ""
  }

  description = <<EOT
    name_attributes_ssc = {
      department_code : "Two character code that uniquely identifies departments across the GC. REQUIRED."
      csp_region : "Single character code that identifies Cloud Service Provider and Region. REQUIRED."
      environment : "Single character code that identifies environment. REQUIRED."
    }
  EOT

  validation {
    condition     = (var.naming_convention == "stc" || length(var.name_attributes.environment) == 1)
    error_message = "Environment must be 1 character long."
  }

  validation {
    condition     = (var.naming_convention == "stc" || length(var.name_attributes.department_code) == 2)
    error_message = "Department code must be 2 characters long."
  }

  validation {
    condition     = (var.naming_convention == "stc" || length(var.name_attributes.csp_region) == 1)
    error_message = "CSP region must be 1 character long."
  }
}

variable "storage_account_names" {
  type        = list(string)
  description = "Set this variable if you have already created a storage account, otherwise leave it empty. OPTIONAL."
  default     = []
  validation {
    condition     = (var.storage_account_names == [] || alltrue([for name in var.storage_account_names : length(name) >= 3 && length(name) <= 24]))
    error_message = "The storage account name must be between 3-24 characters long."
  }
}
