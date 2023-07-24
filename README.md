# Azure SQL Terraform Module

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Equinor Terraform Baseline](https://img.shields.io/badge/Equinor%20Terraform%20Baseline-1.0.0-blueviolet)](https://github.com/equinor/terraform-baseline)

Terraform module which creates Azure SQL resources.

## Features

- Creates an Azure SQL server in the provided resource group.
- Stores vulnerability assessments in the provided Storage account.

## Prerequisites

- Azure role `Contributor` at the resource group scope.
- Azure rule `Owner` at the Storage account scope.
