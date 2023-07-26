# Changelog

## [9.0.0](https://github.com/equinor/terraform-azurerm-sql/compare/v8.3.1...v9.0.0) (2023-07-26)


### ⚠ BREAKING CHANGES

* don't create failover groups ([#103](https://github.com/equinor/terraform-azurerm-sql/issues/103))
* variable `azuread_authentication_only` default value changed from `false` to `true`.
* Rename variable `name` to `database_name`.
* remove variable `azuread_administrator`, add variables `azuread_administrator_login_username`, `azuread_administrator_object_id` and `azuread_authentication_only`.
* Remove variables `storage_account_access_key` and `identity`. Add variables `storage_account_id` and `identity_ids`.

### Features

* don't create failover groups ([#103](https://github.com/equinor/terraform-azurerm-sql/issues/103)) ([79bcdcc](https://github.com/equinor/terraform-azurerm-sql/commit/79bcdcc22784e3d8a0310d19c06c881225226913)), closes [#102](https://github.com/equinor/terraform-azurerm-sql/issues/102)
* enable Azure AD auth only by default ([#101](https://github.com/equinor/terraform-azurerm-sql/issues/101)) ([138b5fb](https://github.com/equinor/terraform-azurerm-sql/commit/138b5fb23e8178336589b48fb0ac0270f4928ce6)), closes [#98](https://github.com/equinor/terraform-azurerm-sql/issues/98)
* force Azure AD admin configuration ([#100](https://github.com/equinor/terraform-azurerm-sql/issues/100)) ([ec9bbba](https://github.com/equinor/terraform-azurerm-sql/commit/ec9bbba4f62c254545fbd480648f6ba49c2fb88a))
* use RBAC for connecting to Storage ([#97](https://github.com/equinor/terraform-azurerm-sql/issues/97)) ([28cffbe](https://github.com/equinor/terraform-azurerm-sql/commit/28cffbe0610dfde7e46297df7f6ef34511f36e9f)), closes [#96](https://github.com/equinor/terraform-azurerm-sql/issues/96)


### Code Refactoring

* rename database name variable ([#90](https://github.com/equinor/terraform-azurerm-sql/issues/90)) ([d862a18](https://github.com/equinor/terraform-azurerm-sql/commit/d862a18c12327ce38ddeaa7a577d281ee625d460))

## [8.3.1](https://github.com/equinor/terraform-azurerm-sql/compare/v8.3.0...v8.3.1) (2023-06-14)


### Reverts

* allow custom retention days for extended auditing policy ([#93](https://github.com/equinor/terraform-azurerm-sql/issues/93)) ([ac92ec2](https://github.com/equinor/terraform-azurerm-sql/commit/ac92ec226235a2767b73639f5412662576ba09c6))

## [8.3.0](https://github.com/equinor/terraform-azurerm-sql/compare/v8.2.0...v8.3.0) (2023-06-05)


### Features

* allow custom retention days for extended auditing policy ([#91](https://github.com/equinor/terraform-azurerm-sql/issues/91)) ([076fd59](https://github.com/equinor/terraform-azurerm-sql/commit/076fd59dcdb560a3b100a85329f332464a00ab26))

## [8.2.0](https://github.com/equinor/terraform-azurerm-sql/compare/v8.1.1...v8.2.0) (2023-05-03)


### Features

* enable vulnerability assessment email notifications ([#88](https://github.com/equinor/terraform-azurerm-sql/issues/88)) ([7bcb5d9](https://github.com/equinor/terraform-azurerm-sql/commit/7bcb5d912b31e190def34550d0896e0502490bfb))

## [8.1.1](https://github.com/equinor/terraform-azurerm-sql/compare/v8.1.0...v8.1.1) (2023-04-26)


### Bug Fixes

* disable local admin config when using AD auth ([#86](https://github.com/equinor/terraform-azurerm-sql/issues/86)) ([06311c6](https://github.com/equinor/terraform-azurerm-sql/commit/06311c6d0d9032d558b952cd1a0fd20b82d26da9))

## [8.1.0](https://github.com/equinor/terraform-azurerm-sql/compare/v8.0.1...v8.1.0) (2023-04-20)


### Features

* create failover groups ([#72](https://github.com/equinor/terraform-azurerm-sql/issues/72)) ([21ddc88](https://github.com/equinor/terraform-azurerm-sql/commit/21ddc88192f3fc2893afe3c1314e2febfac56ed9)), closes [#71](https://github.com/equinor/terraform-azurerm-sql/issues/71)


### Bug Fixes

* disable metrics ([#85](https://github.com/equinor/terraform-azurerm-sql/issues/85)) ([4400718](https://github.com/equinor/terraform-azurerm-sql/commit/44007181c452316d63785da1e30a52056ea299e1))

## [8.0.1](https://github.com/equinor/terraform-azurerm-sql/compare/v8.0.0...v8.0.1) (2023-04-19)


### Bug Fixes

* disable all metrics ([#81](https://github.com/equinor/terraform-azurerm-sql/issues/81)) ([a949959](https://github.com/equinor/terraform-azurerm-sql/commit/a949959bb4054cf3284617a51c020e2e73cc5af2)), closes [#79](https://github.com/equinor/terraform-azurerm-sql/issues/79)

## [8.0.0](https://github.com/equinor/terraform-azurerm-sql/compare/v7.2.0...v8.0.0) (2023-04-18)


### ⚠ BREAKING CHANGES

* remove resources `azurerm_storage_account.this` and `azurerm_storage_container.this`, remove variable `storage_account_name` and add variables `storage_blob_endpoint` and `storage_account_key`.
* add variable `log_analytics_workspace_id`.
* submodule `database` must be explicitly called.

### Features

* send diagnostics to Log Analytics ([#76](https://github.com/equinor/terraform-azurerm-sql/issues/76)) ([46efca3](https://github.com/equinor/terraform-azurerm-sql/commit/46efca3c13cad5e791a7ad1b806164a6e9410b67))
* use existing Storage account ([52f112c](https://github.com/equinor/terraform-azurerm-sql/commit/52f112cf1c345d39955f0f0a5f8d034aced568c3)), closes [#75](https://github.com/equinor/terraform-azurerm-sql/issues/75)


### Code Refactoring

* 1-to-1 mapping of module-to-resources ([#77](https://github.com/equinor/terraform-azurerm-sql/issues/77)) ([6795252](https://github.com/equinor/terraform-azurerm-sql/commit/6795252b7c251ce1b0d4fe076d84f2e27c2b9db1))

## [7.2.0](https://github.com/equinor/terraform-azurerm-sql/compare/v7.1.0...v7.2.0) (2023-03-20)


### Features

* set server alert policy email attributes ([#69](https://github.com/equinor/terraform-azurerm-sql/issues/69)) ([e1e67e9](https://github.com/equinor/terraform-azurerm-sql/commit/e1e67e92b96b1727a97b1ac30ec121d4f25f91bf))

## [7.1.0](https://github.com/equinor/terraform-azurerm-sql/compare/v7.0.0...v7.1.0) (2023-02-09)


### Features

* set max size in GB ([#63](https://github.com/equinor/terraform-azurerm-sql/issues/63)) ([5f45ff0](https://github.com/equinor/terraform-azurerm-sql/commit/5f45ff0d4223ec057853f80aa0322471a9e9af90))

## [7.0.0](https://github.com/equinor/terraform-azurerm-sql/compare/v6.5.0...v7.0.0) (2023-01-25)


### ⚠ BREAKING CHANGES

* dont ignore changes to database sku ([#59](https://github.com/equinor/terraform-azurerm-sql/issues/59))
* rename variables ([#58](https://github.com/equinor/terraform-azurerm-sql/issues/58))
* set firewall rules ([#55](https://github.com/equinor/terraform-azurerm-sql/issues/55))
* disable Azure AD administrator ([#54](https://github.com/equinor/terraform-azurerm-sql/issues/54))
* create single database ([#51](https://github.com/equinor/terraform-azurerm-sql/issues/51))

### Features

* dont ignore changes to database sku ([#59](https://github.com/equinor/terraform-azurerm-sql/issues/59)) ([ba53e68](https://github.com/equinor/terraform-azurerm-sql/commit/ba53e68a626e95e69d42ce4cd6ec3aef3d83ee0e))


### Code Refactoring

* create single database ([#51](https://github.com/equinor/terraform-azurerm-sql/issues/51)) ([17578ea](https://github.com/equinor/terraform-azurerm-sql/commit/17578ea053677488670ab65b5972b51f4e5a1d74))
* disable Azure AD administrator ([#54](https://github.com/equinor/terraform-azurerm-sql/issues/54)) ([056c6f6](https://github.com/equinor/terraform-azurerm-sql/commit/056c6f65b3a85c439a931d30a8e683e6ff52933b))
* rename variables ([#58](https://github.com/equinor/terraform-azurerm-sql/issues/58)) ([3b0e8b1](https://github.com/equinor/terraform-azurerm-sql/commit/3b0e8b196dd5ba6854e1dbc254005161603e5634))
* set firewall rules ([#55](https://github.com/equinor/terraform-azurerm-sql/issues/55)) ([2b8d73b](https://github.com/equinor/terraform-azurerm-sql/commit/2b8d73b5f69b808445a064e1a4b562f597636eaf))
