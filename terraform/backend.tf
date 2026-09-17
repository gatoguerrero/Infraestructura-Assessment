#Con este archivo se le dice a terraform que el state se guardará en un Blob Storage, 
#en un contenedor 
#usando Azure AD + OIDC, lo que significa autenticación moderna, segura y sin secretos en 
#el pipeline.

terraform {
  backend "azurerm" {
    use_azuread_auth     = true # En vez de usar la storage account key (la llave secreta del Storage), Terraform se autentica contra Azure usando Azure Active Directory. La identidad recibe RBAC
    use_oidc             = true # Le indica a Terraform que utilice el flujo OIDC (OpenID Connect) heredado de la identidad de Azure DevOps.
  }
}
