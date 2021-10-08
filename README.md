# Snowflake DevOps Framework

## Table of Contents

1. [Overview](#overview)
    1. [SDLC Workflow](#sdlc-workflow)
1. [Environments](#environments)
    1. [Relationship to Snowflake Accounts](#relationship-to-snowflake-accounts)
    1. [Creating Environments](#creating-environments)


## Overview
The purpose of this framework is to provide you with a complete end-to-end DevOps accelerator for Snowflake.

**Please note** that this Snowflake DevOps Framework is a community-developed tool, not an official Snowflake offering. It comes with no support or warranty.

### SDLC Workflow


## Environments
An environment is the combination of an identifier (business subject area) and an SDLC environment (dev/test/prod)

### Relationship to Snowflake Accounts

### Creating Environments

### Seeding Environments


## Branching Strategy

There are many different branching strategies to choose from, but we have decided to adopt Microsoft's [Release Flow](https://devblogs.microsoft.com/devops/release-flow-how-we-do-branching-on-the-vsts-team/) branching strategy. The other popular approach today is GitHub's [GitHub Flow](https://guides.github.com/introduction/flow/) branching strategy. Both strategies are great, and both follow a [Trunk Based Development](https://trunkbaseddevelopment.com/) approach which addresses the challenges of long-lived branches and the resulting merge hell. But we feel that Microsoft's Release Flow provides a little more control over release deployment (by not continuously deploying master to production) and aligns a little better with data engineering style releases. At a high level, here are the steps involved:

* The trunk (main or master) is buildable at all times
* All development happens in either topic or hotfix short-lived branches
* All changes in topic or hotfix branches go through code review in a Pull Request (PR)
* Once a topic or hotfix branch is ready to go and has passed all tests the code is immediately merged to the trunk and the branch can be deleted
* Deployments are made to production at the end of each sprint (always from a release branch)
* At the end of each sprint a release branch is created, which only lives during the lifetime of the following sprint
* All deployments to production happen from the release branch, not the trunk
* Hotfixes, like everything else, are made first to a short-lived branch, then merged to the trunk, then cherry picked to the release branch and deployed
* Old release branches can be deleted

And here is a graphical representation from Microsoft's [Release Flow](https://devblogs.microsoft.com/devops/release-flow-how-we-do-branching-on-the-vsts-team/) page:

<img src="images/branchstrategy-releaseflow.png" width="600" />

Here are a few additional resources to help you understand the Release Flow approach:

* [Release Flow: How We Do Branching on the VSTS Team](https://devblogs.microsoft.com/devops/release-flow-how-we-do-branching-on-the-vsts-team/)
* [How Microsoft develops modern software with DevOps](https://docs.microsoft.com/en-us/devops/develop/how-microsoft-develops-devops)
* [Adopt a Git branching strategy](https://docs.microsoft.com/en-us/azure/devops/repos/git/git-branching-guidance?view=azure-devops)


## CI/CD

### Pipelines

### Settings


## Scripts

### Scripts

### Chatops Bots


## Todos
* Environements
    * Create seeding script/tool
    * Move Terraform scripts into a module like the [Imuta Fast Data Warehouse](https://registry.terraform.io/modules/immuta/fast-data-warehouse/snowflake/latest)
* CI/CD Workflows
    * Add YAML pipelines for other CI/CD tools
* Scripts
    * Move the scripts into a Chatops Bot like [Hubot](https://hubot.github.com/), [Lita](https://www.lita.io/), or [Err](https://github.com/errbotio/errbot)
* Other
    * Add support for dbt


## Maintainers

- Jeremiah Hansen (@sfc-gh-jhansen)

This is a community-developed tool, not an official Snowflake offering. It comes with no support or warranty. However, feel free to raise a GitHub Issue if you find a bug or would like a new feature.


## Legal

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this tool except in compliance with the License. You may obtain a copy of the License at: [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
