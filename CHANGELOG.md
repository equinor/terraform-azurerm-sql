# Changelog

## [11.1.0](https://github.com/equinor/terraform-azurerm-sql/compare/v11.0.0...v11.1.0) (2024-12-20)


### Features

* **database:** configure auto pause delay ([#162](https://github.com/equinor/terraform-azurerm-sql/issues/162)) ([a13b7a5](https://github.com/equinor/terraform-azurerm-sql/commit/a13b7a5b822b92649e35179161a44dbb2912f854))
* **database:** configure minimal capacity ([#163](https://github.com/equinor/terraform-azurerm-sql/issues/163)) ([1e0a0c8](https://github.com/equinor/terraform-azurerm-sql/commit/1e0a0c813410b065a396dfd8dbe977bbd82023e3))

## [11.0.0](https://github.com/equinor/terraform-azurerm-sql/compare/v10.6.0...v11.0.0) (2024-11-15)


### ⚠ BREAKING CHANGES

* **database:** remove variable `license_type` for submodule `database`.

### Bug Fixes

* **database:** license type should be managed by owner of existing license ([#159](https://github.com/equinor/terraform-azurerm-sql/issues/159)) ([9d38300](https://github.com/equinor/terraform-azurerm-sql/commit/9d3830003147899a9bda63bc7928fe0748d3e879))

## [10.6.0](https://github.com/equinor/terraform-azurerm-sql/compare/v10.5.1...v10.6.0) (2024-10-18)


### Code Refactoring

* simplify firewall rules exception configuration ([#157](https://github.com/equinor/terraform-azurerm-sql/issues/157)) ([5b7bf80](https://github.com/equinor/terraform-azurerm-sql/commit/5b7bf80dc6ec967baabc4f67f12dec632e614a6b))

## [10.5.1](https://github.com/equinor/terraform-azurerm-sql/compare/v10.5.0...v10.5.1) (2024-09-30)


### Bug Fixes

* prevent replacement of role assignment for any update to server ([#155](https://github.com/equinor/terraform-azurerm-sql/issues/155)) ([f5ca1f7](https://github.com/equinor/terraform-azurerm-sql/commit/f5ca1f7a9d07a70e032b34e353031ea421f962f4))

## [10.5.0](https://github.com/equinor/terraform-azurerm-sql/compare/v10.4.1...v10.5.0) (2024-08-30)


### Features

* configure default Storage blob endpoint ([#153](https://github.com/equinor/terraform-azurerm-sql/issues/153)) ([0f162ef](https://github.com/equinor/terraform-azurerm-sql/commit/0f162ef62fb8bf2cc8b513dbf2d26e58487156fc))

## [10.4.1](https://github.com/equinor/terraform-azurerm-sql/compare/v10.4.0...v10.4.1) (2024-08-26)


### Documentation

* add features section to README ([a1df9e3](https://github.com/equinor/terraform-azurerm-sql/commit/a1df9e39d2659c22356b913a03fbf97b40915cd6))

## [10.4.0](https://github.com/equinor/terraform-azurerm-sql/compare/v10.3.2...v10.4.0) (2024-07-22)


### Features

* output fully qualified domain name ([#148](https://github.com/equinor/terraform-azurerm-sql/issues/148)) ([bc3961d](https://github.com/equinor/terraform-azurerm-sql/commit/bc3961da68d4507fbddc868cb6d6a072e2cdf16f))

## [10.3.2](https://github.com/equinor/terraform-azurerm-sql/compare/v10.3.1...v10.3.2) (2024-06-20)


### Bug Fixes

* **database:** remove deprecated argument `retention_policy` for resource `azurerm_monitor_diagnostic_setting` ([#145](https://github.com/equinor/terraform-azurerm-sql/issues/145)) ([9a8cb07](https://github.com/equinor/terraform-azurerm-sql/commit/9a8cb07d0a586600470781790261a000c9d6ac0c))

## [10.3.1](https://github.com/equinor/terraform-azurerm-sql/compare/v10.3.0...v10.3.1) (2024-03-27)


### Miscellaneous Chores

* update variable and output descriptions ([#139](https://github.com/equinor/terraform-azurerm-sql/issues/139)) ([d0c30c3](https://github.com/equinor/terraform-azurerm-sql/commit/d0c30c32dd334598c250b152f77d767effe38d51))

## [10.3.0](https://github.com/equinor/terraform-azurerm-sql/compare/v10.2.3...v10.3.0) (2024-03-22)


### Features

* add server security policy and vulnerability assessment outputs ([#137](https://github.com/equinor/terraform-azurerm-sql/issues/137)) ([7f27a43](https://github.com/equinor/terraform-azurerm-sql/commit/7f27a4363a6ccff45590cb2892b7ae236931c308))

## [10.2.3](https://github.com/equinor/terraform-azurerm-sql/compare/v10.2.2...v10.2.3) (2024-02-29)


### Bug Fixes

* disallow null input value ([#133](https://github.com/equinor/terraform-azurerm-sql/issues/133)) ([09ae109](https://github.com/equinor/terraform-azurerm-sql/commit/09ae10920a1785fae2924724ef4c42e946a35f4f))

## [10.2.2](https://github.com/equinor/terraform-azurerm-sql/compare/v10.2.1...v10.2.2) (2024-02-27)


### Bug Fixes

* validate diagnostic setting log categories ([#131](https://github.com/equinor/terraform-azurerm-sql/issues/131)) ([6776866](https://github.com/equinor/terraform-azurerm-sql/commit/6776866bb63bceeaac10298527ee6ec7f92853c7))

## [10.2.1](https://github.com/equinor/terraform-azurerm-sql/compare/v10.2.0...v10.2.1) (2024-02-05)


### Bug Fixes

* **database:** disabled metric categories not configured ([#124](https://github.com/equinor/terraform-azurerm-sql/issues/124)) ([07183eb](https://github.com/equinor/terraform-azurerm-sql/commit/07183ebc079f1965bfe625cce74534bdeb7f153f))

## [10.2.0](https://github.com/equinor/terraform-azurerm-sql/compare/v10.1.1...v10.2.0) (2024-02-02)


### Features

* add submodule `database` ([#121](https://github.com/equinor/terraform-azurerm-sql/issues/121)) ([5cfba0c](https://github.com/equinor/terraform-azurerm-sql/commit/5cfba0c5df3665a7ed34b70aae0f471753a71a80))

## [10.1.1](https://github.com/equinor/terraform-azurerm-sql/compare/v10.1.0...v10.1.1) (2023-12-20)


### Bug Fixes

* remove diagnostic setting retention policies ([#119](https://github.com/equinor/terraform-azurerm-sql/issues/119)) ([1d0c128](https://github.com/equinor/terraform-azurerm-sql/commit/1d0c128afc19ad69a8ceb4e255340f0903f687df))

## [10.1.0](https://github.com/equinor/terraform-azurerm-sql/compare/v10.0.0...v10.1.0) (2023-09-29)


### Features

* don't send alerts to admins by default ([#110](https://github.com/equinor/terraform-azurerm-sql/issues/110)) ([a338bf8](https://github.com/equinor/terraform-azurerm-sql/commit/a338bf87945bb5997fbc32f7e02e96338d9904e9))

## [10.0.0](https://github.com/equinor/terraform-azurerm-sql/compare/v9.0.1...v10.0.0) (2023-09-01)


### ⚠ BREAKING CHANGES

* remove database submodule ([#107](https://github.com/equinor/terraform-azurerm-sql/issues/107))

### Features

* remove database submodule ([#107](https://github.com/equinor/terraform-azurerm-sql/issues/107)) ([12fb3c5](https://github.com/equinor/terraform-azurerm-sql/commit/12fb3c54e01ae50a64463e88b1e6d5da35049e9d))

## [9.0.1](https://github.com/equinor/terraform-azurerm-sql/compare/v9.0.0...v9.0.1) (2023-09-01)


### Bug Fixes

* unable to create role assignment ([#106](https://github.com/equinor/terraform-azurerm-sql/issues/106)) ([36b13f8](https://github.com/equinor/terraform-azurerm-sql/commit/36b13f8256333f06e6cd54d1fca2eb397a9b6365))

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
