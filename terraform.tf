## --- terraform settings ---
terraform {
  required_version   = ">= 0.12.24"

/*   backend "s3" {
    endpoint   = "https://sabanga.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    region     = "eu-frankfurt-1"
    bucket     = "Terraform_State"
    key        = "smartr/terraform.tfstate"
    shared_credentials_file = "~/.aws/credentials" 

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  } */
}
