# Create the database
resource "snowflake_database" "workspace_database" {
  name    = local.workspace_name
  comment = "Database for Snowflake workspace ${local.workspace_name}"
}
