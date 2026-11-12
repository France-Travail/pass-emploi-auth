variable "smtp_email_password" {
  type = string
}
variable "ssl_required" {
  type        = string
  default     = "all"
  description = "Enabled SSL required on pass-emploi realm"
}

############### CONSEILLER DEPT ###############
variable "conseiller_dept_client_secret" {
  type        = string
  sensitive   = true
  description = "Client secret for conseiller_dept"
}

variable "conseiller_dept_valid_redirect_uris" {
  type        = list(string)
  sensitive   = true
  description = "Valid redirect uris for conseiller_dept"
}
