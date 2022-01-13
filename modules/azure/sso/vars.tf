variable "application" {
  type = string
  description = "The application this service account is intended for"
}

variable "redirect_uri" {
  type = string
  description = "The redirect uri post authentication"
}

variable "roles" {
  type = list(
          object({
            id = string
            name = string
            description = string
          })
  )
}
