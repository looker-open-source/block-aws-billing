<<<<<<< HEAD
marketplace: {
  listing: "aws-billing"
=======
project_name: "aws_billing"

constant: AWS_BILLING_CONNECTION {
  export: override_required
  value: "mw-alpha-cloud-usage"
}

constant: AWS_SCHEMA_NAME {
  export: override_optional
  value: "cloud_cost_final"
}

constant: AWS_TABLE_NAME {
  export: override_optional
  value: "base_table_date_impute_aws"
>>>>>>> branch 'master' of https://github.com/ues-devops-nowports/block-aws-billing
}
