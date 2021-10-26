# Define variables for object names
locals {
  workspace_name = upper("${var.component_name}_${var.environment_name}")
  role_name_admin = upper("${var.component_name}_ADMIN_ROLE_${var.environment_name}")
  role_name_reader = upper("${var.component_name}_READER_ROLE_${var.environment_name}")
  database_name = local.workspace_name
  warehouse_name = upper("${var.component_name}_WH_${var.environment_name}")
}

# =============================================================================
# Roles and related grants
# =============================================================================

# Roles
resource "snowflake_role" "workspace_admin_role" {
  name    = local.role_name_admin
  comment = "Admin role for Snowflake workspace ${local.workspace_name}"
}

resource "snowflake_role" "workspace_reader_role" {
  name    = local.role_name_reader
  comment = "Reader role for Snowflake workspace ${local.workspace_name}"
}

# Grants
resource "snowflake_role_grants" "sysadmin_grants" {
  role_name = snowflake_role.workspace_admin_role.name

  roles     = [
    "SYSADMIN"
  ]
}

resource "snowflake_role_grants" "admin_grants" {
  role_name = snowflake_role.workspace_reader_role.name

  roles     = [
    snowflake_role.workspace_admin_role.name
  ]
}

# =============================================================================
# Database and related grants
# =============================================================================

# Database
resource "snowflake_database" "workspace_database" {
  name    = local.database_name
  comment = "Database for Snowflake workspace ${local.workspace_name}"
}

# Grants
resource "snowflake_database_grant" "admin_db_ownership" {
  database_name = snowflake_database.workspace_database.name
  privilege     = "OWNERSHIP"
  roles         = [
    snowflake_role.workspace_admin_role.name
  ]
}

resource "snowflake_database_grant" "reader_db_usage" {
  database_name = snowflake_database.workspace_database.name
  privilege     = "USAGE"
  roles         = [
    snowflake_role.workspace_reader_role.name
  ]
}

resource "snowflake_schema_grant" "reader_schema_usage" {
  database_name = snowflake_database.workspace_database.name
  privilege     = "USAGE"
  on_future     = true
  roles         = [
    snowflake_role.workspace_reader_role.name
  ]
}

resource "snowflake_table_grant" "reader_table_select" {
  database_name = snowflake_database.workspace_database.name
  privilege     = "SELECT"
  on_future     = true
  roles         = [
    snowflake_role.workspace_reader_role.name
  ]
}

# =============================================================================
# Warehouse and related grants
# =============================================================================

# Warehouse
resource "snowflake_warehouse" "workspace_warehouse" {
  name           = local.warehouse_name
  comment        = "Warehouse for Snowflake workspace ${local.workspace_name}"
  warehouse_size = "xsmall"
  auto_suspend   = 300
}

# Grants
resource "snowflake_warehouse_grant" "workspace_wh_ownership" {
  warehouse_name = snowflake_warehouse.workspace_warehouse.name
  privilege      = "OWNERSHIP"
  roles          = [
    snowflake_role.workspace_admin_role.name
  ]
}

resource "snowflake_warehouse_grant" "reader_wh_usage" {
  warehouse_name = snowflake_warehouse.workspace_warehouse.name
  privilege      = "USAGE"
  roles          = [
    snowflake_role.workspace_reader_role.name
  ]
}
