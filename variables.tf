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
    instance           = number
    owner              = string
    parent_object_name = string
  })

  default = {
    department_code    = ""
    csp_region         = ""
    environment        = ""
    instance           = 0
    owner              = ""
    parent_object_name = "ParentObjName"
  }

  description = <<EOT
    name_attributes_ssc = {
      department_code : "Two character code that uniquely identifies departments across the GC. REQUIRED."
      csp_region : "Single character code that identifies Cloud Service Provider and Region. REQUIRED."
      environment : "Single character code that identifies environment. REQUIRED."
      instance : "The instance number of the object."
      owner : "The name of the resource owner."
      parent_object_name : "The name of the parent object without the suffix (if applicable). Ex: GcPcCNR-CORE"
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

  validation {
    condition     = (!var.government || var.name_attributes_ssc.instance == "" || (var.name_attributes_ssc.instance >= 1 && var.name_attributes_ssc.instance < 100))
    error_message = "The variable var.name_attributes.instance must be between 1-100."
  }

  validation {
    condition     = (!var.government || var.name_attributes_ssc.owner == "" || length(var.name_attributes_ssc.owner) >= 3 && length(var.name_attributes_ssc.owner) <= 4)
    error_message = "The variable owner must be between 3-4 characters."
  }

  validation {
    condition     = (!var.government || var.name_attributes_ssc.parent_object_name == "ParentObjName" || length(var.name_attributes_ssc.parent_object_name) >= 2 && length(var.name_attributes_ssc.parent_object_name) <= 30)
    error_message = "The variable parent_object_name must be between 2-30 characters."
  }
}
