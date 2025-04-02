###################################################################################
# This is a read-only file! Its contents can be edited through the Marketplace UI #
# See the docs at: https://cloud.google.com/looker/docs/data-modeling/marketplace              #
###################################################################################

marketplace_ref: {
  listing: "aws-billing"
  version: "1.0.1"
  models: ["aws_billing_block"]
  override_constant: AWS_BILLING_CONNECTION { value:"datalake" }
  override_constant: AWS_SCHEMA_NAME { value:"cloud_cost_final" }
  override_constant: AWS_TABLE_NAME { value:"base_table_date_impute_aws" }
}
