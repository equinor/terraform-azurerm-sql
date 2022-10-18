# Complete example

Terraform configuration which creates an Azure SQL database with the following features:

- Basic SKU
- Weekly long-term retention (LTR) backup policy
- Administrator login with randomly generated password
- Azure AD administrator
- Firewall rules
- SQL auditing enabled
- Vulnerability assessment enabled
