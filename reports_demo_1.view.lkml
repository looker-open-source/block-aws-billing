
view: reports_demo_1 {
  derived_table: {
    sql: SELECT * FROM "aws_looker_reports"."aws_looker_reports" limit 10 ;;
  }

  suggestions: no
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: bill_bill_type {
    type: string
    sql: ${TABLE}.bill_bill_type ;;
  }

  dimension: bill_billing_entity {
    type: string
    sql: ${TABLE}.bill_billing_entity ;;
  }

  dimension_group: bill_billing_period_end_date {
    type: time
    sql: ${TABLE}.bill_billing_period_end_date ;;
  }

  dimension_group: bill_billing_period_start_date {
    type: time
    sql: ${TABLE}.bill_billing_period_start_date ;;
  }

  dimension: bill_invoicing_entity {
    type: string
    sql: ${TABLE}.bill_invoicing_entity ;;
  }

  dimension: bill_payer_account_id {
    type: string
    sql: ${TABLE}.bill_payer_account_id ;;
  }

  dimension: bill_payer_account_name {
    type: string
    sql: ${TABLE}.bill_payer_account_name ;;
  }

  dimension: cost_category {
    type: string
    sql: ${TABLE}.cost_category ;;
  }

  dimension: discount {
    type: string
    sql: ${TABLE}.discount ;;
  }

  dimension: identity_line_item_id {
    type: string
    sql: ${TABLE}.identity_line_item_id ;;
  }

  dimension: identity_time_interval {
    type: string
    sql: ${TABLE}.identity_time_interval ;;
  }

  dimension: line_item_blended_cost {
    type: number
    sql: ${TABLE}.line_item_blended_cost ;;
  }

  dimension: line_item_blended_rate {
    type: string
    sql: ${TABLE}.line_item_blended_rate ;;
  }

  dimension: line_item_currency_code {
    type: string
    sql: ${TABLE}.line_item_currency_code ;;
  }

  dimension: line_item_legal_entity {
    type: string
    sql: ${TABLE}.line_item_legal_entity ;;
  }

  dimension: line_item_line_item_description {
    type: string
    sql: ${TABLE}.line_item_line_item_description ;;
  }

  dimension: line_item_line_item_type {
    type: string
    sql: ${TABLE}.line_item_line_item_type ;;
  }

  dimension: line_item_normalization_factor {
    type: number
    sql: ${TABLE}.line_item_normalization_factor ;;
  }

  dimension: line_item_normalized_usage_amount {
    type: number
    sql: ${TABLE}.line_item_normalized_usage_amount ;;
  }

  dimension: line_item_operation {
    type: string
    sql: ${TABLE}.line_item_operation ;;
  }

  dimension: line_item_product_code {
    type: string
    sql: ${TABLE}.line_item_product_code ;;
  }

  dimension: line_item_resource_id {
    type: string
    sql: ${TABLE}.line_item_resource_id ;;
  }

  dimension: line_item_unblended_cost {
    type: number
    sql: ${TABLE}.line_item_unblended_cost ;;
  }

  dimension: line_item_unblended_rate {
    type: string
    sql: ${TABLE}.line_item_unblended_rate ;;
  }

  dimension: line_item_usage_account_id {
    type: string
    sql: ${TABLE}.line_item_usage_account_id ;;
  }

  dimension: line_item_usage_account_name {
    type: string
    sql: ${TABLE}.line_item_usage_account_name ;;
  }

  dimension: line_item_usage_amount {
    type: number
    sql: ${TABLE}.line_item_usage_amount ;;
  }

  dimension_group: line_item_usage_end_date {
    type: time
    sql: ${TABLE}.line_item_usage_end_date ;;
  }

  dimension_group: line_item_usage_start_date {
    type: time
    sql: ${TABLE}.line_item_usage_start_date ;;
  }

  dimension: line_item_usage_type {
    type: string
    sql: ${TABLE}.line_item_usage_type ;;
  }

  dimension: pricing_currency {
    type: string
    sql: ${TABLE}.pricing_currency ;;
  }

  dimension: pricing_public_on_demand_cost {
    type: number
    sql: ${TABLE}.pricing_public_on_demand_cost ;;
  }

  dimension: pricing_public_on_demand_rate {
    type: string
    sql: ${TABLE}.pricing_public_on_demand_rate ;;
  }

  dimension: pricing_rate_code {
    type: string
    sql: ${TABLE}.pricing_rate_code ;;
  }

  dimension: pricing_rate_id {
    type: string
    sql: ${TABLE}.pricing_rate_id ;;
  }

  dimension: pricing_term {
    type: string
    sql: ${TABLE}.pricing_term ;;
  }

  dimension: pricing_unit {
    type: string
    sql: ${TABLE}.pricing_unit ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
  }

  dimension: product_product_family {
    type: string
    sql: ${TABLE}.product_product_family ;;
  }

  dimension: product_region_code {
    type: string
    sql: ${TABLE}.product_region_code ;;
  }

  dimension: product_servicecode {
    type: string
    sql: ${TABLE}.product_servicecode ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension: product_usagetype {
    type: string
    sql: ${TABLE}.product_usagetype ;;
  }

  dimension: resource_tags {
    type: string
    sql: ${TABLE}.resource_tags ;;
  }

  set: detail {
    fields: [
        bill_bill_type,
	bill_billing_entity,
	bill_billing_period_end_date_time,
	bill_billing_period_start_date_time,
	bill_invoicing_entity,
	bill_payer_account_id,
	bill_payer_account_name,
	cost_category,
	discount,
	identity_line_item_id,
	identity_time_interval,
	line_item_blended_cost,
	line_item_blended_rate,
	line_item_currency_code,
	line_item_legal_entity,
	line_item_line_item_description,
	line_item_line_item_type,
	line_item_normalization_factor,
	line_item_normalized_usage_amount,
	line_item_operation,
	line_item_product_code,
	line_item_resource_id,
	line_item_unblended_cost,
	line_item_unblended_rate,
	line_item_usage_account_id,
	line_item_usage_account_name,
	line_item_usage_amount,
	line_item_usage_end_date_time,
	line_item_usage_start_date_time,
	line_item_usage_type,
	pricing_currency,
	pricing_public_on_demand_cost,
	pricing_public_on_demand_rate,
	pricing_rate_code,
	pricing_rate_id,
	pricing_term,
	pricing_unit,
	product,
	product_product_family,
	product_region_code,
	product_servicecode,
	product_sku,
	product_usagetype,
	resource_tags
    ]
  }
}
