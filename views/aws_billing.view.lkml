view: aws_billing {
  derived_table: {
      sql:
      select
        CONCAT(CAST(line_item_usage_start_date as VARCHAR),'|', CAST(row_number() over (partition by line_item_usage_start_date ) as VARCHAR)) as id,
        --row_number() over () as id,
        a.*
      from
        @{AWS_SCHEMA_NAME}.@{AWS_TABLE_NAME} as a;;
  }

    dimension: cloud {
      type: string
      sql: 'AWS' ;;
      link: {
        label: "{{ value }} Cost Management"
        url: "/dashboards/aws_billing::aws_summary"
        icon_url: "looker.com/favicon.ico"
      }
    }

    dimension: id {
      group_label: "IDs"
      type: number
      primary_key: yes
      sql: ${TABLE}.id ;;
    }

    dimension: availability_zone {
      type: string
      sql: ${TABLE}.line_item_availability_zone ;;
    }

    dimension: blended_rate {
      group_label: "Rates"
      type: number
      sql: ${TABLE}.line_item_blended_rate ;;
    }

    dimension: blended_cost {
      type: number
      hidden: yes
      sql: ${TABLE}.line_item_blended_cost ;;
    }

    measure: total_blended_cost {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost} ;;


      drill_fields: [detail*]
      link: {
        label: "By Service Area"
        url: "{{link}}&fields=aws_billing.product_name,aws_billing.total_blended_cost&f[aws_billing.total_blended_cost]=%3E10&sorts=aws_billing.total_blended_cost+desc&limit=500&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22show_view_names%22%3Afalse%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22gray%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22show_sql_query_menu_options%22%3Afalse%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22series_cell_visualizations%22%3A%7B%22aws_billing.total_blended_cost%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22fae75734-3ca0-306f-cd80-ee17dcc4a65b%22%2C%22collection_id%22%3A%22b43731d5-dc87-4a8e-b807-635bef3948e7%22%2C%22custom_colors%22%3A%5B%22%23ff9900%22%2C%22%23e47911%22%2C%22%23146EB4%22%5D%7D%7D%7D%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Afalse%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Atrue%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22bottom%22%2C%22series%22%3A%5B%7B%22axisId%22%3A%22aws_billing.total_blended_cost%22%2C%22id%22%3A%22aws_billing.total_blended_cost%22%2C%22name%22%3A%22Total+Blended+Cost%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Afalse%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22tickDensityCustom%22%3A5%2C%22type%22%3A%22linear%22%7D%5D%2C%22label_value_format%22%3A%22%5B%5Cu003c1000000%5D%240.0%2C%5C%22K%5C%22%3B%5B%5Cu003e%3D1000000%5D%240.0%2C%2C%5C%22M%5C%22%22%2C%22series_types%22%3A%7B%7D%2C%22series_colors%22%3A%7B%22aws_billing.total_blended_cost%22%3A%22%23FF9900%22%7D%2C%22type%22%3A%22looker_grid%22%2C%22defaults_version%22%3A1%7D&filter_config=%7B%22aws_billing.total_blended_cost%22%3A%5B%7B%22type%22%3A%22%5Cu003e%22%2C%22values%22%3A%5B%7B%22constant%22%3A%2210%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
        icon_url: "https://www.amazon.com/favicon.ico"
      }
      link: {
        label: "By Linked Account"
        url: "{{link}}&fields=aws_billing.linked_account_id,aws_billing.total_blended_cost&f[aws_billing.total_blended_cost]=%3E10&sorts=aws_billing.total_blended_cost+desc&limit=500&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22show_view_names%22%3Afalse%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22gray%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22show_sql_query_menu_options%22%3Afalse%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22series_cell_visualizations%22%3A%7B%22aws_billing.total_blended_cost%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22fae75734-3ca0-306f-cd80-ee17dcc4a65b%22%2C%22collection_id%22%3A%22b43731d5-dc87-4a8e-b807-635bef3948e7%22%2C%22custom_colors%22%3A%5B%22%23ff9900%22%2C%22%23e47911%22%2C%22%23146EB4%22%5D%7D%7D%7D%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Afalse%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Atrue%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22bottom%22%2C%22series%22%3A%5B%7B%22axisId%22%3A%22aws_billing.total_blended_cost%22%2C%22id%22%3A%22aws_billing.total_blended_cost%22%2C%22name%22%3A%22Total+Blended+Cost%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Afalse%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22tickDensityCustom%22%3A5%2C%22type%22%3A%22linear%22%7D%5D%2C%22label_value_format%22%3A%22%5B%5Cu003c1000000%5D%240.0%2C%5C%22K%5C%22%3B%5B%5Cu003e%3D1000000%5D%240.0%2C%2C%5C%22M%5C%22%22%2C%22series_types%22%3A%7B%7D%2C%22series_colors%22%3A%7B%22aws_billing.total_blended_cost%22%3A%22%23FF9900%22%7D%2C%22type%22%3A%22looker_grid%22%2C%22defaults_version%22%3A1%7D&filter_config=%7B%22aws_billing.total_blended_cost%22%3A%5B%7B%22type%22%3A%22%5Cu003e%22%2C%22values%22%3A%5B%7B%22constant%22%3A%2210%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
        icon_url: "https://www.amazon.com/favicon.ico"
      }
      link: {
        label: "By Usage Type"
        url: "{{link}}&fields=aws_billing.usage_type,aws_billing.total_blended_cost&f[aws_billing.total_blended_cost]=%3E10&sorts=aws_billing.total_blended_cost+desc&limit=500&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22show_view_names%22%3Afalse%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22gray%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22show_sql_query_menu_options%22%3Afalse%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22series_cell_visualizations%22%3A%7B%22aws_billing.total_blended_cost%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22fae75734-3ca0-306f-cd80-ee17dcc4a65b%22%2C%22collection_id%22%3A%22b43731d5-dc87-4a8e-b807-635bef3948e7%22%2C%22custom_colors%22%3A%5B%22%23ff9900%22%2C%22%23e47911%22%2C%22%23146EB4%22%5D%7D%7D%7D%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Afalse%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Atrue%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22bottom%22%2C%22series%22%3A%5B%7B%22axisId%22%3A%22aws_billing.total_blended_cost%22%2C%22id%22%3A%22aws_billing.total_blended_cost%22%2C%22name%22%3A%22Total+Blended+Cost%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Afalse%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22tickDensityCustom%22%3A5%2C%22type%22%3A%22linear%22%7D%5D%2C%22label_value_format%22%3A%22%5B%5Cu003c1000000%5D%240.0%2C%5C%22K%5C%22%3B%5B%5Cu003e%3D1000000%5D%240.0%2C%2C%5C%22M%5C%22%22%2C%22series_types%22%3A%7B%7D%2C%22series_colors%22%3A%7B%22aws_billing.total_blended_cost%22%3A%22%23FF9900%22%7D%2C%22type%22%3A%22looker_grid%22%2C%22defaults_version%22%3A1%7D&filter_config=%7B%22aws_billing.total_blended_cost%22%3A%5B%7B%22type%22%3A%22%5Cu003e%22%2C%22values%22%3A%5B%7B%22constant%22%3A%2210%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
        icon_url: "https://www.amazon.com/favicon.ico"
      }
      link: {
        label: "By Resource"
        url: "{{link}}&fields=aws_billing.resource_id,aws_billing.total_blended_cost&f[aws_billing.total_blended_cost]=%3E10&sorts=aws_billing.total_blended_cost+desc&limit=500&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22show_view_names%22%3Afalse%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22gray%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22show_sql_query_menu_options%22%3Afalse%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22series_cell_visualizations%22%3A%7B%22aws_billing.total_blended_cost%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22fae75734-3ca0-306f-cd80-ee17dcc4a65b%22%2C%22collection_id%22%3A%22b43731d5-dc87-4a8e-b807-635bef3948e7%22%2C%22custom_colors%22%3A%5B%22%23ff9900%22%2C%22%23e47911%22%2C%22%23146EB4%22%5D%7D%7D%7D%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Afalse%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Atrue%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22bottom%22%2C%22series%22%3A%5B%7B%22axisId%22%3A%22aws_billing.total_blended_cost%22%2C%22id%22%3A%22aws_billing.total_blended_cost%22%2C%22name%22%3A%22Total+Blended+Cost%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Afalse%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22tickDensityCustom%22%3A5%2C%22type%22%3A%22linear%22%7D%5D%2C%22label_value_format%22%3A%22%5B%5Cu003c1000000%5D%240.0%2C%5C%22K%5C%22%3B%5B%5Cu003e%3D1000000%5D%240.0%2C%2C%5C%22M%5C%22%22%2C%22series_types%22%3A%7B%7D%2C%22series_colors%22%3A%7B%22aws_billing.total_blended_cost%22%3A%22%23FF9900%22%7D%2C%22type%22%3A%22looker_grid%22%2C%22defaults_version%22%3A1%7D&filter_config=%7B%22aws_billing.total_blended_cost%22%3A%5B%7B%22type%22%3A%22%5Cu003e%22%2C%22values%22%3A%5B%7B%22constant%22%3A%2210%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
        icon_url: "https://www.amazon.com/favicon.ico"
      }
      link: {
        label: "AWS Summary Dashboard"
        url: "/dashboards/aws_billing::aws_summary"
        icon_url: "https://www.amazon.com/favicon.ico"
      }
    }

    measure: total_blended_cost_reserved {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost};;
      drill_fields: [detail*]

      filters: {
        field: reserved_instance
        value: "true"
      }
    }

    measure: total_blended_cost_non_reserved {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost};;
      drill_fields: [detail*]

      filters: {
        field: reserved_instance
        value: "false"
      }
    }

    dimension: unblended_rate {
      group_label: "Rates"
      type: number
      sql: ${TABLE}.line_item_unblended_rate ;;
    }

    dimension: unblended_cost {
      hidden: yes
      type: number
      sql: ${TABLE}.line_item_unblended_cost ;;
    }

    measure: total_unblended_cost {
      type: sum
      value_format: "$#,##0.00"
      sql: ${unblended_cost};;
      drill_fields: [detail*]

    }

    # dimension: cost {
    #   type: number
    #   hidden: yes
    #   sql: ${TABLE}.lineItem_Cost ;;
    # }

    # measure: total_cost {
    #   type: sum
    #   value_format: "$#,##0.00"
    #   sql: ${cost};;
    #   drill_fields: [detail*]

    # }

    # measure: total_cost_new {
    #   type: sum
    #   value_format: "$#,##0.00"
    #   sql: coalesce(${cost},${unblended_cost});;
    #   drill_fields: [detail*]
    # }

    dimension: invoice_id {
      group_label: "IDs"
      type: string
      sql: ${TABLE}.bill_invoice_id ;;
    }

    dimension: item_description {
      type: string
      sql: ${TABLE}.line_item_line_item_description ;;
    }

    dimension: linked_account_id {
      group_label: "IDs"
      type: string
      sql: ${TABLE}.line_item_usage_account_id ;;
    }
    dimension: operation {
      type: string
      sql: ${TABLE}.line_item_operation ;;
    }

    dimension: payer_account_id {
      group_label: "IDs"
      type: number
      sql: ${TABLE}.bill_payer_account_id ;;
    }

    dimension: pricing_plan_id {
      group_label: "IDs"
      type: number
      hidden: yes
      sql: ${TABLE}.pricing_plan_id ;;
    }

    dimension: product_name {
      type: string
      sql: ${TABLE}.product_product_name ;;
      drill_fields: [linked_account_id]
    }

    dimension: rate {
      group_label: "Rates"
      type: number
      hidden: yes
      sql: ${TABLE}.rate ;;
    }

    dimension: rate_id {
      group_label: "IDs"
      type: number
      sql: ${TABLE}.pricing_rate_id ;;
    }

    dimension: record_id {
      group_label: "IDs"
      type: string
      sql: CONCAT(CAST(${TABLE}.identity_line_item_id as VARCHAR),CAST(${TABLE}.identity_time_interval as VARCHAR),CAST(${TABLE}.bill_bill_type as VARCHAR)) ;;
    }

    dimension: reserved_instance {
      type: string
      sql: CASE WHEN ${TABLE}.line_item_line_item_type = 'DiscountedUsage' then 'true' else 'false' end;;
    }

    dimension: resource_id {
      group_label: "IDs"
      type: string
      sql: ${TABLE}.line_item_resource_id ;;
    }

    dimension: subscription_id {
      group_label: "IDs"
      type: number
      sql: ${TABLE}.reservation_subscription_id ;;
    }

    dimension_group: usage_end {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      convert_tz: no
      sql: ${TABLE}.line_item_usage_end_date ;;
    }

    dimension: usage_quantity {
      group_label: "Usage"
      type: number
      sql: ${TABLE}.line_item_usage_amount ;;
    }

    dimension_group: usage_start {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year,
        month_name
      ]
      convert_tz: no
      sql: ${TABLE}.line_item_usage_start_date ;;
    }

    dimension: month {
      type: string
      hidden: yes
      sql: CASE WHEN LENGTH(CAST(${TABLE}.month as VARCHAR))=1
            then CONCAT('0',CAST(${TABLE}.month as VARCHAR))
            else CAST(${TABLE}.month as VARCHAR) END ;;
    }

    dimension: year {
      type: string
      hidden: yes
      sql: CAST(${TABLE}.year as VARCHAR) ;;
    }

    dimension: invoice_month {
      type: date_month
      sql: DATE_PARSE(CONCAT(${year},'-',${month}),'%Y-%m') ;;
    }

    dimension: usage_type {
      group_label: "Usage"
      type: string
      sql: ${TABLE}.line_item_usage_type ;;
    }

    dimension: user_cost_category {
      group_label: "User"
      type:  string
      hidden: yes
      sql:${TABLE}.user_cost_category ;;
    }

    dimension: user_name {
      group_label: "User"
      type:  string
      hidden: yes
      sql:${TABLE}.user_name ;;
    }

    measure: count {
      hidden: yes
      type: count
      drill_fields: [product_name]
    }

    # REDSHIFT

    # dimension: is_current_month {
    #   type: yesno
    #   # hidden: yes
    #   sql:  ${usage_start_month} = TO_CHAR(current_date, 'YYYY-MM');;
    # }

    measure: count_usage_months {
      hidden: yes
      type: count_distinct
      sql: ${usage_start_month} ;;
    }


    measure: average_cost_per_month {
      type: number
      sql: ${total_blended_cost}/NULLIF(${count_usage_months},0) ;;
      drill_fields: [detail*]
      value_format_name: usd

    }


    # measure: total_current_month_cost {
    #   label: "Total Blended Cost This Month"
    #   type: sum
    #   sql: ${blended_cost} ;;
    #   value_format_name: usd
    #   drill_fields: [detail*]
    #   filters: {
    #     field: is_current_month
    #     value: "yes"
    #   }
    # }



## PRODUCT-SPECIFIC MEASURES

    measure: blended_EC2_cost {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost};;
      drill_fields: [detail*]

      filters: {
        field: product_name
        value: "Amazon Elastic Compute Cloud"
      }
    }

    measure: blended_reserved_EC2_cost {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost};;
      drill_fields: [detail*]

      filters: {
        field: product_name
        value: "Amazon Elastic Compute Cloud"
      }
      filters: {
        field: reserved_instance
        value: "true"
      }
    }

    measure: blended_non_reserved_EC2_cost {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost};;
      drill_fields: [detail*]

      filters: {
        field: product_name
        value: "Amazon Elastic Compute Cloud"
      }
      filters: {
        field: reserved_instance
        value: "false"
      }
    }

    # measure: total_current_month_ec2_cost {
    #   label: "Current Month EC2 Cost"
    #   type: sum
    #   sql: ${blended_cost} ;;
    #   value_format_name: usd
    #   drill_fields: [detail*]
    #   filters: {
    #     field: is_current_month
    #     value: "yes"

    #     field: product_name
    #     value: "Amazon Elastic Compute Cloud"
    #   }
    # }

    # measure: current_month_reserved_ec2_cost {
    #   label: "Current Month Reserved EC2 Cost"
    #   type: sum
    #   sql: ${blended_cost} ;;
    #   value_format_name: usd
    #   drill_fields: [detail*]
    #   filters: {
    #     field: is_current_month
    #     value: "yes"

    #     field: product_name
    #     value: "Amazon Elastic Compute Cloud"

    #     field: reserved_instance
    #     value: "true"
    #   }
    # }

    # measure: current_month_non_reserved_ec2_cost {
    #   label: "Current Month Non Reserved EC2 Cost"
    #   type: sum
    #   sql: ${blended_cost} ;;
    #   value_format_name: usd
    #   drill_fields: [detail*]
    #   filters: {
    #     field: is_current_month
    #     value: "yes"

    #     field: product_name
    #     value: "Amazon Elastic Compute Cloud"

    #     field: reserved_instance
    #     value: "false"
    #   }
    # }

    measure: blended_rds_cost {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost};;
      drill_fields: [detail*]

      filters: {
        field: product_name
        value: "Amazon RDS"
      }
    }

    measure: blended_reserved_rds_cost {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost};;
      drill_fields: [detail*]

      filters: {
        field: product_name
        value: "Amazon RDS"
      }
      filters: {
        field: reserved_instance
        value: "true"
      }
    }

    measure: blended_non_reserved_rds_cost {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost};;
      drill_fields: [detail*]

      filters: {
        field: product_name
        value: "Amazon RDS"
      }
      filters: {
        field: reserved_instance
        value: "false"
      }
    }

    measure: blended_redshift_cost {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost};;
      drill_fields: [detail*]

      filters: {
        field: product_name
        value: "Amazon Redshift"
      }
    }

    measure: blended_reserved_redshift_cost {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost};;
      drill_fields: [detail*]

      filters: {
        field: product_name
        value: "Amazon Redshift"
      }
      filters: {
        field: reserved_instance
        value: "true"
      }
    }

    measure: blended_non_reserved_redshift_cost {
      type: sum
      value_format: "$#,##0.00"
      sql: ${blended_cost};;
      drill_fields: [detail*]

      filters: {
        field: product_name
        value: "Amazon Redshift"
      }
      filters: {
        field: reserved_instance
        value: "false"
      }
    }


    set: detail {
      fields: [product_name,invoice_id,item_description,record_id,subscription_id,resource_id,total_unblended_cost,total_blended_cost]
    }
  }



# view: base_table_date_impute_aws {
#   sql_table_name: `mw-alpha-cloud-cost-usage.cloud_cost_final.base_table_date_impute_aws`
#     ;;

#   dimension: bill_bill_type {
#     type: string
#     sql: ${TABLE}.bill_BillType ;;
#   }

#   dimension: bill_billing_entity {
#     type: string
#     sql: ${TABLE}.bill_BillingEntity ;;
#   }

#   dimension_group: bill_billing_period_end {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.bill_BillingPeriodEndDate ;;
#   }

#   dimension_group: bill_billing_period_start {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.bill_BillingPeriodStartDate ;;
#   }

#   dimension: bill_invoice_id {
#     type: string
#     sql: ${TABLE}.bill_InvoiceId ;;
#   }

#   dimension: bill_payer_account_id {
#     type: number
#     sql: ${TABLE}.bill_PayerAccountId ;;
#   }

#   dimension: identity_line_item_id {
#     type: string
#     sql: ${TABLE}.identity_LineItemId ;;
#   }

#   dimension_group: identity_time_interval_end {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.identity_TimeInterval_End ;;
#   }

#   dimension_group: identity_time_interval_start {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.identity_TimeInterval_Start ;;
#   }

#   dimension: line_item_availability_zone {
#     type: string
#     sql: ${TABLE}.lineItem_AvailabilityZone ;;
#   }

#   dimension: line_item_blended_cost {
#     type: number
#     sql: ${TABLE}.lineItem_BlendedCost ;;
#   }

#   dimension: line_item_blended_rate {
#     type: number
#     sql: ${TABLE}.lineItem_BlendedRate ;;
#   }

#   dimension: line_item_currency_code {
#     type: string
#     sql: ${TABLE}.lineItem_CurrencyCode ;;
#   }

#   dimension: line_item_legal_entity {
#     type: string
#     sql: ${TABLE}.lineItem_LegalEntity ;;
#   }

#   dimension: line_item_line_item_description {
#     type: string
#     sql: ${TABLE}.lineItem_LineItemDescription ;;
#   }

#   dimension: line_item_line_item_type {
#     type: string
#     sql: ${TABLE}.lineItem_LineItemType ;;
#   }

#   dimension: line_item_normalization_factor {
#     type: number
#     sql: ${TABLE}.lineItem_NormalizationFactor ;;
#   }

#   dimension: line_item_normalized_usage_amount {
#     type: number
#     sql: ${TABLE}.lineItem_NormalizedUsageAmount ;;
#   }

#   dimension: line_item_operation {
#     type: string
#     sql: ${TABLE}.lineItem_Operation ;;
#   }

#   dimension: line_item_product_code {
#     type: string
#     sql: ${TABLE}.lineItem_ProductCode ;;
#   }

#   dimension: line_item_resource_id {
#     type: string
#     sql: ${TABLE}.lineItem_ResourceId ;;
#   }

#   dimension: line_item_tax_type {
#     type: string
#     sql: ${TABLE}.lineItem_TaxType ;;
#   }

#   dimension: line_item_unblended_cost {
#     type: number
#     sql: ${TABLE}.lineItem_UnblendedCost ;;
#   }

#   dimension: line_item_unblended_rate {
#     type: number
#     sql: ${TABLE}.lineItem_UnblendedRate ;;
#   }

#   dimension: line_item_usage_account_id {
#     type: number
#     sql: ${TABLE}.lineItem_UsageAccountId ;;
#   }

#   dimension: line_item_usage_amount {
#     type: number
#     sql: ${TABLE}.lineItem_UsageAmount ;;
#   }

#   dimension_group: line_item_usage_end {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.lineItem_UsageEndDate ;;
#   }

#   dimension_group: line_item_usage_start {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.lineItem_UsageStartDate ;;
#   }

#   dimension: line_item_usage_type {
#     type: string
#     sql: ${TABLE}.lineItem_UsageType ;;
#   }

#   dimension: pricing_currency {
#     type: string
#     sql: ${TABLE}.pricing_currency ;;
#   }

#   dimension: pricing_public_on_demand_cost {
#     type: number
#     sql: ${TABLE}.pricing_publicOnDemandCost ;;
#   }

#   dimension: pricing_public_on_demand_rate {
#     type: number
#     sql: ${TABLE}.pricing_publicOnDemandRate ;;
#   }

#   dimension: pricing_rate_code {
#     type: string
#     sql: ${TABLE}.pricing_RateCode ;;
#   }

#   dimension: pricing_rate_id {
#     type: string
#     sql: ${TABLE}.pricing_RateId ;;
#   }

#   dimension: pricing_term {
#     type: string
#     sql: ${TABLE}.pricing_term ;;
#   }

#   dimension: pricing_unit {
#     type: string
#     sql: ${TABLE}.pricing_unit ;;
#   }

#   dimension: product_alarm_type {
#     type: string
#     sql: ${TABLE}.product_alarmType ;;
#   }

#   dimension: product_attachment_type {
#     type: string
#     sql: ${TABLE}.product_attachmentType ;;
#   }

#   dimension: product_availability {
#     type: string
#     sql: ${TABLE}.product_availability ;;
#   }

#   dimension: product_capacitystatus {
#     type: string
#     sql: ${TABLE}.product_capacitystatus ;;
#   }

#   dimension: product_category {
#     type: string
#     sql: ${TABLE}.product_category ;;
#   }

#   dimension: product_ci_type {
#     type: string
#     sql: ${TABLE}.product_ciType ;;
#   }

#   dimension: product_clock_speed {
#     type: string
#     sql: ${TABLE}.product_clockSpeed ;;
#   }

#   dimension: product_component {
#     type: string
#     sql: ${TABLE}.product_component ;;
#   }

#   dimension: product_compute_family {
#     type: string
#     sql: ${TABLE}.product_computeFamily ;;
#   }

#   dimension: product_compute_type {
#     type: string
#     sql: ${TABLE}.product_computeType ;;
#   }

#   dimension: product_current_generation {
#     type: string
#     sql: ${TABLE}.product_currentGeneration ;;
#   }

#   dimension: product_database_engine {
#     type: string
#     sql: ${TABLE}.product_databaseEngine ;;
#   }

#   dimension: product_deployment_option {
#     type: string
#     sql: ${TABLE}.product_deploymentOption ;;
#   }

#   dimension: product_description {
#     type: string
#     sql: ${TABLE}.product_description ;;
#   }

#   dimension: product_durability {
#     type: string
#     sql: ${TABLE}.product_durability ;;
#   }

#   dimension: product_ecu {
#     type: string
#     sql: ${TABLE}.product_ecu ;;
#   }

#   dimension: product_endpoint_type {
#     type: string
#     sql: ${TABLE}.product_endpointType ;;
#   }

#   dimension: product_engine_code {
#     type: string
#     sql: ${TABLE}.product_engineCode ;;
#   }

#   dimension: product_enhanced_networking_supported {
#     type: string
#     sql: ${TABLE}.product_enhancedNetworkingSupported ;;
#   }

#   dimension: product_from_location {
#     type: string
#     sql: ${TABLE}.product_fromLocation ;;
#   }

#   dimension: product_from_location_type {
#     type: string
#     sql: ${TABLE}.product_fromLocationType ;;
#   }

#   dimension: product_gpu {
#     type: string
#     sql: ${TABLE}.product_gpu ;;
#   }

#   dimension: product_gpu_memory {
#     type: string
#     sql: ${TABLE}.product_gpuMemory ;;
#   }

#   dimension: product_group {
#     type: string
#     sql: ${TABLE}.product_group ;;
#   }

#   dimension: product_group_description {
#     type: string
#     sql: ${TABLE}.product_groupDescription ;;
#   }

#   dimension: product_instance_family {
#     type: string
#     sql: ${TABLE}.product_instanceFamily ;;
#   }

#   dimension: product_instance_name {
#     type: string
#     sql: ${TABLE}.product_instanceName ;;
#   }

#   dimension: product_instance_type {
#     type: string
#     sql: ${TABLE}.product_instanceType ;;
#   }

#   dimension: product_instance_type_family {
#     type: string
#     sql: ${TABLE}.product_instanceTypeFamily ;;
#   }

#   dimension: product_intel_avx2_available {
#     type: string
#     sql: ${TABLE}.product_intelAvx2Available ;;
#   }

#   dimension: product_intel_avx_available {
#     type: string
#     sql: ${TABLE}.product_intelAvxAvailable ;;
#   }

#   dimension: product_intel_turbo_available {
#     type: string
#     sql: ${TABLE}.product_intelTurboAvailable ;;
#   }

#   dimension: product_license_model {
#     type: string
#     sql: ${TABLE}.product_licenseModel ;;
#   }

#   dimension: product_location {
#     type: string
#     sql: ${TABLE}.product_location ;;
#   }

#   dimension: product_location_type {
#     type: string
#     sql: ${TABLE}.product_locationType ;;
#   }

#   dimension: product_logs_destination {
#     type: string
#     sql: ${TABLE}.product_logsDestination ;;
#   }

#   dimension: product_max_iops_burst_performance {
#     type: string
#     sql: ${TABLE}.product_maxIopsBurstPerformance ;;
#   }

#   dimension: product_max_iopsvolume {
#     type: string
#     sql: ${TABLE}.product_maxIopsvolume ;;
#   }

#   dimension: product_max_throughputvolume {
#     type: string
#     sql: ${TABLE}.product_maxThroughputvolume ;;
#   }

#   dimension: product_max_volume_size {
#     type: string
#     sql: ${TABLE}.product_maxVolumeSize ;;
#   }

#   dimension: product_memory {
#     type: string
#     sql: ${TABLE}.product_memory ;;
#   }

#   dimension: product_memory_gib {
#     type: string
#     sql: ${TABLE}.product_memoryGib ;;
#   }

#   dimension: product_message_delivery_frequency {
#     type: string
#     sql: ${TABLE}.product_messageDeliveryFrequency ;;
#   }

#   dimension: product_message_delivery_order {
#     type: string
#     sql: ${TABLE}.product_messageDeliveryOrder ;;
#   }

#   dimension: product_min_volume_size {
#     type: string
#     sql: ${TABLE}.product_minVolumeSize ;;
#   }

#   dimension: product_network_performance {
#     type: string
#     sql: ${TABLE}.product_networkPerformance ;;
#   }

#   dimension: product_normalization_size_factor {
#     type: string
#     sql: ${TABLE}.product_normalizationSizeFactor ;;
#   }

#   dimension: product_operating_system {
#     type: string
#     sql: ${TABLE}.product_operatingSystem ;;
#   }

#   dimension: product_operation {
#     type: string
#     sql: ${TABLE}.product_operation ;;
#   }

#   dimension: product_physical_cpu {
#     type: string
#     sql: ${TABLE}.product_physicalCpu ;;
#   }

#   dimension: product_physical_gpu {
#     type: string
#     sql: ${TABLE}.product_physicalGpu ;;
#   }

#   dimension: product_physical_processor {
#     type: string
#     sql: ${TABLE}.product_physicalProcessor ;;
#   }

#   dimension: product_platoclassificationtype {
#     type: string
#     sql: ${TABLE}.product_platoclassificationtype ;;
#   }

#   dimension: product_platoinstancename {
#     type: string
#     sql: ${TABLE}.product_platoinstancename ;;
#   }

#   dimension: product_platoinstancetype {
#     type: string
#     sql: ${TABLE}.product_platoinstancetype ;;
#   }

#   dimension: product_platopricingtype {
#     type: string
#     sql: ${TABLE}.product_platopricingtype ;;
#   }

#   dimension: product_platostoragetype {
#     type: string
#     sql: ${TABLE}.product_platostoragetype ;;
#   }

#   dimension: product_platousagetype {
#     type: string
#     sql: ${TABLE}.product_platousagetype ;;
#   }

#   dimension: product_pre_installed_sw {
#     type: string
#     sql: ${TABLE}.product_preInstalledSw ;;
#   }

#   dimension: product_processor_architecture {
#     type: string
#     sql: ${TABLE}.product_processorArchitecture ;;
#   }

#   dimension: product_processor_features {
#     type: string
#     sql: ${TABLE}.product_processorFeatures ;;
#   }

#   dimension: product_product_family {
#     type: string
#     sql: ${TABLE}.product_productFamily ;;
#   }

#   dimension: product_product_name {
#     type: string
#     sql: ${TABLE}.product_ProductName ;;
#   }

#   dimension: product_queue_type {
#     type: string
#     sql: ${TABLE}.product_queueType ;;
#   }

#   dimension: product_region {
#     type: string
#     sql: ${TABLE}.product_region ;;
#   }

#   dimension: product_routing_target {
#     type: string
#     sql: ${TABLE}.product_routingTarget ;;
#   }

#   dimension: product_routing_type {
#     type: string
#     sql: ${TABLE}.product_routingType ;;
#   }

#   dimension: product_servicecode {
#     type: string
#     sql: ${TABLE}.product_servicecode ;;
#   }

#   dimension: product_servicename {
#     type: string
#     sql: ${TABLE}.product_servicename ;;
#   }

#   dimension: product_sku {
#     type: string
#     sql: ${TABLE}.product_sku ;;
#   }

#   dimension: product_storage {
#     type: string
#     sql: ${TABLE}.product_storage ;;
#   }

#   dimension: product_storage_class {
#     type: string
#     sql: ${TABLE}.product_storageClass ;;
#   }

#   dimension: product_storage_family {
#     type: string
#     sql: ${TABLE}.product_storageFamily ;;
#   }

#   dimension: product_storage_media {
#     type: string
#     sql: ${TABLE}.product_storageMedia ;;
#   }

#   dimension: product_storage_type {
#     type: string
#     sql: ${TABLE}.product_storageType ;;
#   }

#   dimension: product_tenancy {
#     type: string
#     sql: ${TABLE}.product_tenancy ;;
#   }

#   dimension: product_to_location {
#     type: string
#     sql: ${TABLE}.product_toLocation ;;
#   }

#   dimension: product_to_location_type {
#     type: string
#     sql: ${TABLE}.product_toLocationType ;;
#   }

#   dimension: product_transfer_type {
#     type: string
#     sql: ${TABLE}.product_transferType ;;
#   }

#   dimension: product_usagetype {
#     type: string
#     sql: ${TABLE}.product_usagetype ;;
#   }

#   dimension: product_vcpu {
#     type: string
#     sql: ${TABLE}.product_vcpu ;;
#   }

#   dimension: product_version {
#     type: string
#     sql: ${TABLE}.product_version ;;
#   }

#   dimension: product_volume_api_name {
#     type: string
#     sql: ${TABLE}.product_volumeApiName ;;
#   }

#   dimension: product_volume_type {
#     type: string
#     sql: ${TABLE}.product_volumeType ;;
#   }

#   dimension: reservation_amortized_upfront_cost_for_usage {
#     type: number
#     sql: ${TABLE}.reservation_AmortizedUpfrontCostForUsage ;;
#   }

#   dimension: reservation_amortized_upfront_fee_for_billing_period {
#     type: string
#     sql: ${TABLE}.reservation_AmortizedUpfrontFeeForBillingPeriod ;;
#   }

#   dimension: reservation_effective_cost {
#     type: number
#     sql: ${TABLE}.reservation_EffectiveCost ;;
#   }

#   dimension: reservation_end_time {
#     type: string
#     sql: ${TABLE}.reservation_EndTime ;;
#   }

#   dimension: reservation_modification_status {
#     type: string
#     sql: ${TABLE}.reservation_ModificationStatus ;;
#   }

#   dimension: reservation_normalized_units_per_reservation {
#     type: string
#     sql: ${TABLE}.reservation_NormalizedUnitsPerReservation ;;
#   }

#   dimension: reservation_number_of_reservations {
#     type: number
#     sql: ${TABLE}.reservation_NumberOfReservations ;;
#   }

#   dimension: reservation_recurring_fee_for_usage {
#     type: number
#     sql: ${TABLE}.reservation_RecurringFeeForUsage ;;
#   }

#   dimension: reservation_start_time {
#     type: string
#     sql: ${TABLE}.reservation_StartTime ;;
#   }

#   dimension: reservation_subscription_id {
#     type: string
#     sql: ${TABLE}.reservation_SubscriptionId ;;
#   }

#   dimension: reservation_total_reserved_normalized_units {
#     type: number
#     sql: ${TABLE}.reservation_TotalReservedNormalizedUnits ;;
#   }

#   dimension: reservation_total_reserved_units {
#     type: number
#     sql: ${TABLE}.reservation_TotalReservedUnits ;;
#   }

#   dimension: reservation_units_per_reservation {
#     type: number
#     sql: ${TABLE}.reservation_UnitsPerReservation ;;
#   }

#   dimension: reservation_unused_amortized_upfront_fee_for_billing_period {
#     type: number
#     sql: ${TABLE}.reservation_UnusedAmortizedUpfrontFeeForBillingPeriod ;;
#   }

#   dimension: reservation_unused_normalized_unit_quantity {
#     type: number
#     sql: ${TABLE}.reservation_UnusedNormalizedUnitQuantity ;;
#   }

#   dimension: reservation_unused_quantity {
#     type: number
#     sql: ${TABLE}.reservation_UnusedQuantity ;;
#   }

#   dimension: reservation_unused_recurring_fee {
#     type: number
#     sql: ${TABLE}.reservation_UnusedRecurringFee ;;
#   }

#   dimension: reservation_upfront_value {
#     type: number
#     sql: ${TABLE}.reservation_UpfrontValue ;;
#   }

#   dimension: row_key {
#     type: string
#     sql: ${TABLE}.row_key ;;
#   }

#   dimension: savings_plan_amortized_upfront_commitment_for_billing_period {
#     type: number
#     sql: ${TABLE}.savingsPlan_AmortizedUpfrontCommitmentForBillingPeriod ;;
#   }

#   dimension: savings_plan_recurring_commitment_for_billing_period {
#     type: number
#     sql: ${TABLE}.savingsPlan_RecurringCommitmentForBillingPeriod ;;
#   }

#   dimension: savings_plan_savings_plan_arn {
#     type: string
#     sql: ${TABLE}.savingsPlan_SavingsPlanARN ;;
#   }

#   dimension: savings_plan_savings_plan_effective_cost {
#     type: number
#     sql: ${TABLE}.savingsPlan_SavingsPlanEffectiveCost ;;
#   }

#   dimension: savings_plan_savings_plan_rate {
#     type: number
#     sql: ${TABLE}.savingsPlan_SavingsPlanRate ;;
#   }

#   dimension: savings_plan_total_commitment_to_date {
#     type: number
#     sql: ${TABLE}.savingsPlan_TotalCommitmentToDate ;;
#   }

#   dimension: savings_plan_used_commitment {
#     type: number
#     sql: ${TABLE}.savingsPlan_UsedCommitment ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: [product_product_name, product_volume_api_name, product_platoinstancename, product_instance_name, product_servicename]
#   }
# }


# # view: aws_billing {
# #   sql_table_name: `mw-alpha-cloud-cost-usage.cloud_cost_scrubed.aws_billing`
# #     ;;

#   view: aws_billing {
#     derived_table: {
#       sql:
#       select
#         CONCAT(CAST(lineItem_UsageStartDate as STRING),'|', CAST(row_number() over (partition by lineItem_UsageStartDate ) as STRING)) as id,
#         --row_number() over () as id,
#         a.*
#       from
#         `cloud_cost_final.base_table_date_impute_aws` as a;;
#       #   WHERE {% condition usage_start_date %}  TIMESTAMP(_PARTITIONDATE) {% endcondition %} ;;
#       # persist_for: "24 hours"
#     }

#     dimension_group: partition {
#       type: time
#       sql: ${TABLE}._PARTITIONDATE  ;;
#     }

#     dimension: cloud {
#       type: string
#       sql: 'AWS' ;;
#       link: {
#         label: "{{ value }} Cost Management"
#         url: "/dashboards-next/8"
#         icon_url: "looker.com/favicon.ico"
#       }
#     }

#     dimension: id {
#       group_label: "IDs"
#       type: number
#       primary_key: yes
#       sql: ${TABLE}.id ;;
#     }

#     dimension: availability_zone {
#       type: string
#       sql: ${TABLE}.lineItem_AvailabilityZone ;;
#     }

#     dimension: blended_rate {
#       group_label: "Rates"
#       type: number
#       sql: ${TABLE}.lineItem_BlendedRate ;;
#     }

#     dimension:blended_cost {
#       type: number
#       hidden: yes
#       sql: ${TABLE}.lineItem_BlendedCost ;;
#     }

#     measure: total_blended_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost} ;;


#       drill_fields: [detail*]
#       link: {
#         label: "By Service Area"
#         url: "{{link}}&fields=aws_billing.product_name,aws_billing.total_blended_cost&f[aws_billing.total_blended_cost]=%3E10&sorts=aws_billing.total_blended_cost+desc&limit=500&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22show_view_names%22%3Afalse%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22gray%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22show_sql_query_menu_options%22%3Afalse%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22series_cell_visualizations%22%3A%7B%22aws_billing.total_blended_cost%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22fae75734-3ca0-306f-cd80-ee17dcc4a65b%22%2C%22collection_id%22%3A%22b43731d5-dc87-4a8e-b807-635bef3948e7%22%2C%22custom_colors%22%3A%5B%22%23ff9900%22%2C%22%23e47911%22%2C%22%23146EB4%22%5D%7D%7D%7D%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Afalse%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Atrue%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22bottom%22%2C%22series%22%3A%5B%7B%22axisId%22%3A%22aws_billing.total_blended_cost%22%2C%22id%22%3A%22aws_billing.total_blended_cost%22%2C%22name%22%3A%22Total+Blended+Cost%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Afalse%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22tickDensityCustom%22%3A5%2C%22type%22%3A%22linear%22%7D%5D%2C%22label_value_format%22%3A%22%5B%5Cu003c1000000%5D%240.0%2C%5C%22K%5C%22%3B%5B%5Cu003e%3D1000000%5D%240.0%2C%2C%5C%22M%5C%22%22%2C%22series_types%22%3A%7B%7D%2C%22series_colors%22%3A%7B%22aws_billing.total_blended_cost%22%3A%22%23FF9900%22%7D%2C%22type%22%3A%22looker_grid%22%2C%22defaults_version%22%3A1%7D&filter_config=%7B%22aws_billing.total_blended_cost%22%3A%5B%7B%22type%22%3A%22%5Cu003e%22%2C%22values%22%3A%5B%7B%22constant%22%3A%2210%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
#         icon_url: "https://www.amazon.com/favicon.ico"
#       }
#       link: {
#         label: "By Linked Account"
#         url: "{{link}}&fields=aws_billing.linked_account_id,aws_billing.total_blended_cost&f[aws_billing.total_blended_cost]=%3E10&sorts=aws_billing.total_blended_cost+desc&limit=500&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22show_view_names%22%3Afalse%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22gray%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22show_sql_query_menu_options%22%3Afalse%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22series_cell_visualizations%22%3A%7B%22aws_billing.total_blended_cost%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22fae75734-3ca0-306f-cd80-ee17dcc4a65b%22%2C%22collection_id%22%3A%22b43731d5-dc87-4a8e-b807-635bef3948e7%22%2C%22custom_colors%22%3A%5B%22%23ff9900%22%2C%22%23e47911%22%2C%22%23146EB4%22%5D%7D%7D%7D%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Afalse%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Atrue%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22bottom%22%2C%22series%22%3A%5B%7B%22axisId%22%3A%22aws_billing.total_blended_cost%22%2C%22id%22%3A%22aws_billing.total_blended_cost%22%2C%22name%22%3A%22Total+Blended+Cost%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Afalse%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22tickDensityCustom%22%3A5%2C%22type%22%3A%22linear%22%7D%5D%2C%22label_value_format%22%3A%22%5B%5Cu003c1000000%5D%240.0%2C%5C%22K%5C%22%3B%5B%5Cu003e%3D1000000%5D%240.0%2C%2C%5C%22M%5C%22%22%2C%22series_types%22%3A%7B%7D%2C%22series_colors%22%3A%7B%22aws_billing.total_blended_cost%22%3A%22%23FF9900%22%7D%2C%22type%22%3A%22looker_grid%22%2C%22defaults_version%22%3A1%7D&filter_config=%7B%22aws_billing.total_blended_cost%22%3A%5B%7B%22type%22%3A%22%5Cu003e%22%2C%22values%22%3A%5B%7B%22constant%22%3A%2210%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
#         icon_url: "https://www.amazon.com/favicon.ico"
#       }
#       link: {
#         label: "By Usage Type"
#         url: "{{link}}&fields=aws_billing.usage_type,aws_billing.total_blended_cost&f[aws_billing.total_blended_cost]=%3E10&sorts=aws_billing.total_blended_cost+desc&limit=500&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22show_view_names%22%3Afalse%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22gray%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22show_sql_query_menu_options%22%3Afalse%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22series_cell_visualizations%22%3A%7B%22aws_billing.total_blended_cost%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22fae75734-3ca0-306f-cd80-ee17dcc4a65b%22%2C%22collection_id%22%3A%22b43731d5-dc87-4a8e-b807-635bef3948e7%22%2C%22custom_colors%22%3A%5B%22%23ff9900%22%2C%22%23e47911%22%2C%22%23146EB4%22%5D%7D%7D%7D%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Afalse%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Atrue%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22bottom%22%2C%22series%22%3A%5B%7B%22axisId%22%3A%22aws_billing.total_blended_cost%22%2C%22id%22%3A%22aws_billing.total_blended_cost%22%2C%22name%22%3A%22Total+Blended+Cost%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Afalse%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22tickDensityCustom%22%3A5%2C%22type%22%3A%22linear%22%7D%5D%2C%22label_value_format%22%3A%22%5B%5Cu003c1000000%5D%240.0%2C%5C%22K%5C%22%3B%5B%5Cu003e%3D1000000%5D%240.0%2C%2C%5C%22M%5C%22%22%2C%22series_types%22%3A%7B%7D%2C%22series_colors%22%3A%7B%22aws_billing.total_blended_cost%22%3A%22%23FF9900%22%7D%2C%22type%22%3A%22looker_grid%22%2C%22defaults_version%22%3A1%7D&filter_config=%7B%22aws_billing.total_blended_cost%22%3A%5B%7B%22type%22%3A%22%5Cu003e%22%2C%22values%22%3A%5B%7B%22constant%22%3A%2210%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
#         icon_url: "https://www.amazon.com/favicon.ico"
#       }
#       link: {
#         label: "By Resource"
#         url: "{{link}}&fields=aws_billing.resource_id,aws_billing.total_blended_cost&f[aws_billing.total_blended_cost]=%3E10&sorts=aws_billing.total_blended_cost+desc&limit=500&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22show_view_names%22%3Afalse%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22gray%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22show_sql_query_menu_options%22%3Afalse%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22series_cell_visualizations%22%3A%7B%22aws_billing.total_blended_cost%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22fae75734-3ca0-306f-cd80-ee17dcc4a65b%22%2C%22collection_id%22%3A%22b43731d5-dc87-4a8e-b807-635bef3948e7%22%2C%22custom_colors%22%3A%5B%22%23ff9900%22%2C%22%23e47911%22%2C%22%23146EB4%22%5D%7D%7D%7D%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Afalse%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Atrue%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22bottom%22%2C%22series%22%3A%5B%7B%22axisId%22%3A%22aws_billing.total_blended_cost%22%2C%22id%22%3A%22aws_billing.total_blended_cost%22%2C%22name%22%3A%22Total+Blended+Cost%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Afalse%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22tickDensityCustom%22%3A5%2C%22type%22%3A%22linear%22%7D%5D%2C%22label_value_format%22%3A%22%5B%5Cu003c1000000%5D%240.0%2C%5C%22K%5C%22%3B%5B%5Cu003e%3D1000000%5D%240.0%2C%2C%5C%22M%5C%22%22%2C%22series_types%22%3A%7B%7D%2C%22series_colors%22%3A%7B%22aws_billing.total_blended_cost%22%3A%22%23FF9900%22%7D%2C%22type%22%3A%22looker_grid%22%2C%22defaults_version%22%3A1%7D&filter_config=%7B%22aws_billing.total_blended_cost%22%3A%5B%7B%22type%22%3A%22%5Cu003e%22%2C%22values%22%3A%5B%7B%22constant%22%3A%2210%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
#         icon_url: "https://www.amazon.com/favicon.ico"
#       }
#       link: {
#         label: "AWS Summary Dashboard"
#         url: "https://meta.looker.com/dashboards-next/8"
#         icon_url: "https://www.amazon.com/favicon.ico"
#       }
#     }

#     measure: total_blended_cost_reserved {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost};;
#       drill_fields: [detail*]

#       filters: {
#         field: reserved_instance
#         value: "true"
#       }
#     }

#     measure: total_blended_cost_non_reserved {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost};;
#       drill_fields: [detail*]

#       filters: {
#         field: reserved_instance
#         value: "false"
#       }
#     }

#     dimension:unblended_rate {
#       group_label: "Rates"
#       type: number
#       sql: ${TABLE}.lineItem_UnblendedRate ;;
#     }

#     dimension:unblended_cost {
#       hidden: yes
#       type: number
#       sql: ${TABLE}.lineItem_UnblendedCost ;;
#     }

#     measure: total_unblended_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${unblended_cost};;
#       drill_fields: [detail*]

#     }

#     dimension: cost {
#       type: number
#       hidden: yes
#       sql: ${TABLE}.lineItem_Cost ;;
#     }

#     measure: total_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${cost};;
#       drill_fields: [detail*]

#     }

#     measure: total_cost_new {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: coalesce(${cost},${unblended_cost});;
#       drill_fields: [detail*]
#     }

#     dimension: invoice_id {
#       group_label: "IDs"
#       type: string
#       sql: ${TABLE}.lineItem_InvoiceId ;;
#     }

#     dimension: item_description {
#       type: string
#       sql: ${TABLE}.lineItem_ItemDescription ;;
#     }

#     dimension: linked_account_id {
#       group_label: "IDs"
#       type: number
#       sql: ${TABLE}.lineItem_LinkedAccountId ;;

#     }
#     dimension: operation {
#       type: string
#       sql: ${TABLE}.lineItem_Operation ;;
#     }

#     dimension: payer_account_id {
#       group_label: "IDs"
#       type: number
#       sql: ${TABLE}.lineItem_PayerAccountId ;;
#     }

#     dimension: pricing_plan_id {
#       group_label: "IDs"
#       type: number
#       sql: ${TABLE}.lineItem_PricingPlanId ;;
#     }

#     dimension: product_name {
#       type: string
#       sql: ${TABLE}.lineItem_ProductName ;;
#       drill_fields: [linked_account_id]
#     }

#     dimension: rate {
#       group_label: "Rates"
#       type: number
#       sql: ${TABLE}.lineItem_Rate ;;
#     }

#     dimension: rate_id {
#       group_label: "IDs"
#       type: number
#       sql: ${TABLE}.lineItem_RateId ;;
#     }

#     dimension: record_id {
#       group_label: "IDs"
#       type: string
#       sql: ${TABLE}.lineItem_RecordId ;;
#     }

#     dimension: record_type {
#       group_label: "IDs"
#       type: string
#       sql: ${TABLE}.lineItem_RecordType ;;
#     }

#     dimension: reserved_instance {
#       type: string
#       sql: CAST(${TABLE}.lineItem_ReservedInstance as STRING) ;;
#     }

#     dimension: resource_id {
#       group_label: "IDs"
#       type: string
#       sql: ${TABLE}.lineItem_ResourceId ;;
#     }

#     dimension: subscription_id {
#       group_label: "IDs"
#       type: number
#       sql: ${TABLE}.lineItem_SubscriptionId ;;
#     }

#     dimension_group: usage_end {
#       type: time
#       timeframes: [
#         raw,
#         time,
#         date,
#         week,
#         month,
#         quarter,
#         year
#       ]
#       convert_tz: no
#       sql: ${TABLE}.lineItem_UsageEndDate  ;;
#     }

#     dimension: usage_quantity {
#       group_label: "Usage"
#       type: number
#       sql: ${TABLE}.lineItem_UsageQuantity ;;
#     }

#     dimension_group: usage_start {
#       type: time
#       timeframes: [
#         raw,
#         time,
#         date,
#         week,
#         month,
#         quarter,
#         year,
#         month_name
#       ]
#       convert_tz: no
#       sql: ${TABLE}.lineItem_UsageStartDate  ;;
#     }

#     dimension: usage_type {
#       group_label: "Usage"
#       type: string
#       sql: ${TABLE}.lineItem_UsageType ;;
#     }

#     dimension: user_cost_category {
#       group_label: "User"
#       type:  string
#       sql:${TABLE}.lineItem_UserCostCategory ;;
#     }

#     dimension: user_name {
#       group_label: "User"
#       type:  string
#       sql:${TABLE}.lineItem_UserName ;;
#     }

#     measure: count {
#       hidden: yes
#       type: count
#       drill_fields: [product_name]
#     }

#     # REDSHIFT

#     # dimension: is_current_month {
#     #   type: yesno
#     #   # hidden: yes
#     #   sql:  ${usage_start_month} = TO_CHAR(current_date, 'YYYY-MM');;
#     # }

#     measure: count_usage_months {
#       hidden: yes
#       type: count_distinct
#       sql: ${usage_start_month} ;;
#     }


#     measure: average_cost_per_month {
#       type: number
#       sql: ${total_blended_cost}/NULLIF(${count_usage_months},0) ;;
#       drill_fields: [detail*]
#       value_format_name: usd

#     }


#     # measure: total_current_month_cost {
#     #   label: "Total Blended Cost This Month"
#     #   type: sum
#     #   sql: ${blended_cost} ;;
#     #   value_format_name: usd
#     #   drill_fields: [detail*]
#     #   filters: {
#     #     field: is_current_month
#     #     value: "yes"
#     #   }
#     # }



# ## PRODUCT-SPECIFIC MEASURES

#     measure: blended_EC2_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost};;
#       drill_fields: [detail*]

#       filters: {
#         field: product_name
#         value: "Amazon Elastic Compute Cloud"
#       }
#     }

#     measure: blended_reserved_EC2_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost};;
#       drill_fields: [detail*]

#       filters: {
#         field: product_name
#         value: "Amazon Elastic Compute Cloud"
#       }
#       filters: {
#         field: reserved_instance
#         value: "true"
#       }
#     }

#     measure: blended_non_reserved_EC2_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost};;
#       drill_fields: [detail*]

#       filters: {
#         field: product_name
#         value: "Amazon Elastic Compute Cloud"
#       }
#       filters: {
#         field: reserved_instance
#         value: "false"
#       }
#     }

#     # measure: total_current_month_ec2_cost {
#     #   label: "Current Month EC2 Cost"
#     #   type: sum
#     #   sql: ${blended_cost} ;;
#     #   value_format_name: usd
#     #   drill_fields: [detail*]
#     #   filters: {
#     #     field: is_current_month
#     #     value: "yes"

#     #     field: product_name
#     #     value: "Amazon Elastic Compute Cloud"
#     #   }
#     # }

#     # measure: current_month_reserved_ec2_cost {
#     #   label: "Current Month Reserved EC2 Cost"
#     #   type: sum
#     #   sql: ${blended_cost} ;;
#     #   value_format_name: usd
#     #   drill_fields: [detail*]
#     #   filters: {
#     #     field: is_current_month
#     #     value: "yes"

#     #     field: product_name
#     #     value: "Amazon Elastic Compute Cloud"

#     #     field: reserved_instance
#     #     value: "true"
#     #   }
#     # }

#     # measure: current_month_non_reserved_ec2_cost {
#     #   label: "Current Month Non Reserved EC2 Cost"
#     #   type: sum
#     #   sql: ${blended_cost} ;;
#     #   value_format_name: usd
#     #   drill_fields: [detail*]
#     #   filters: {
#     #     field: is_current_month
#     #     value: "yes"

#     #     field: product_name
#     #     value: "Amazon Elastic Compute Cloud"

#     #     field: reserved_instance
#     #     value: "false"
#     #   }
#     # }

#     measure: blended_rds_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost};;
#       drill_fields: [detail*]

#       filters: {
#         field: product_name
#         value: "Amazon RDS"
#       }
#     }

#     measure: blended_reserved_rds_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost};;
#       drill_fields: [detail*]

#       filters: {
#         field: product_name
#         value: "Amazon RDS"
#       }
#       filters: {
#         field: reserved_instance
#         value: "true"
#       }
#     }

#     measure: blended_non_reserved_rds_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost};;
#       drill_fields: [detail*]

#       filters: {
#         field: product_name
#         value: "Amazon RDS"
#       }
#       filters: {
#         field: reserved_instance
#         value: "false"
#       }
#     }

#     measure: blended_redshift_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost};;
#       drill_fields: [detail*]

#       filters: {
#         field: product_name
#         value: "Amazon Redshift"
#       }
#     }

#     measure: blended_reserved_redshift_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost};;
#       drill_fields: [detail*]

#       filters: {
#         field: product_name
#         value: "Amazon Redshift"
#       }
#       filters: {
#         field: reserved_instance
#         value: "true"
#       }
#     }

#     measure: blended_non_reserved_redshift_cost {
#       type: sum
#       value_format: "$#,##0.00"
#       sql: ${blended_cost};;
#       drill_fields: [detail*]

#       filters: {
#         field: product_name
#         value: "Amazon Redshift"
#       }
#       filters: {
#         field: reserved_instance
#         value: "false"
#       }
#     }


#     set: detail {
#       fields: [product_name,invoice_id,item_description,record_type,record_id,subscription_id,resource_id,total_cost,total_unblended_cost,total_blended_cost]
#     }
#   }


# #   dimension: bill_bill_type {
# #     type: string
# #     sql: ${TABLE}.bill_BillType ;;
# #   }

# #   dimension: bill_billing_entity {
# #     type: string
# #     sql: ${TABLE}.bill_BillingEntity ;;
# #   }

# #   dimension_group: bill_billing_period_end {
# #     type: time
# #     timeframes: [
# #       raw,
# #       time,
# #       date,
# #       week,
# #       month,
# #       quarter,
# #       year
# #     ]
# #     sql: ${TABLE}.bill_BillingPeriodEndDate ;;
# #   }

# #   dimension_group: bill_billing_period_start {
# #     type: time
# #     timeframes: [
# #       raw,
# #       time,
# #       date,
# #       week,
# #       month,
# #       quarter,
# #       year
# #     ]
# #     sql: ${TABLE}.bill_BillingPeriodStartDate ;;
# #   }

# #   dimension: bill_invoice_id {
# #     type: string
# #     sql: ${TABLE}.bill_InvoiceId ;;
# #   }

# #   dimension: bill_payer_account_id {
# #     type: number
# #     sql: ${TABLE}.bill_PayerAccountId ;;
# #   }

# #   dimension: identity_line_item_id {
# #     type: string
# #     sql: ${TABLE}.identity_LineItemId ;;
# #   }

# #   dimension_group: identity_time_interval_end {
# #     type: time
# #     timeframes: [
# #       raw,
# #       time,
# #       date,
# #       week,
# #       month,
# #       quarter,
# #       year
# #     ]
# #     sql: ${TABLE}.identity_TimeInterval_End ;;
# #   }

# #   dimension_group: identity_time_interval_start {
# #     type: time
# #     timeframes: [
# #       raw,
# #       time,
# #       date,
# #       week,
# #       month,
# #       quarter,
# #       year
# #     ]
# #     sql: ${TABLE}.identity_TimeInterval_Start ;;
# #   }

# #   dimension: line_item_availability_zone {
# #     type: string
# #     sql: ${TABLE}.lineItem_AvailabilityZone ;;
# #   }

# #   dimension: line_item_blended_cost {
# #     type: number
# #     sql: ${TABLE}.lineItem_BlendedCost ;;
# #   }

# #   dimension: line_item_blended_rate {
# #     type: number
# #     sql: ${TABLE}.lineItem_BlendedRate ;;
# #   }

# #   dimension: line_item_currency_code {
# #     type: string
# #     sql: ${TABLE}.lineItem_CurrencyCode ;;
# #   }

# #   dimension: line_item_legal_entity {
# #     type: string
# #     sql: ${TABLE}.lineItem_LegalEntity ;;
# #   }

# #   dimension: line_item_line_item_description {
# #     type: string
# #     sql: ${TABLE}.lineItem_LineItemDescription ;;
# #   }

# #   dimension: line_item_line_item_type {
# #     type: string
# #     sql: ${TABLE}.lineItem_LineItemType ;;
# #   }

# #   dimension: line_item_normalization_factor {
# #     type: number
# #     sql: ${TABLE}.lineItem_NormalizationFactor ;;
# #   }

# #   dimension: line_item_normalized_usage_amount {
# #     type: number
# #     sql: ${TABLE}.lineItem_NormalizedUsageAmount ;;
# #   }

# #   dimension: line_item_operation {
# #     type: string
# #     sql: ${TABLE}.lineItem_Operation ;;
# #   }

# #   dimension: line_item_product_code {
# #     type: string
# #     sql: ${TABLE}.lineItem_ProductCode ;;
# #   }

# #   dimension: line_item_resource_id {
# #     type: string
# #     sql: ${TABLE}.lineItem_ResourceId ;;
# #   }

# #   dimension: line_item_tax_type {
# #     type: string
# #     sql: ${TABLE}.lineItem_TaxType ;;
# #   }

# #   dimension: line_item_unblended_cost {
# #     type: number
# #     sql: ${TABLE}.lineItem_UnblendedCost ;;
# #   }

# #   dimension: line_item_unblended_rate {
# #     type: number
# #     sql: ${TABLE}.lineItem_UnblendedRate ;;
# #   }

# #   dimension: line_item_usage_account_id {
# #     type: number
# #     sql: ${TABLE}.lineItem_UsageAccountId ;;
# #   }

# #   dimension: line_item_usage_amount {
# #     type: number
# #     sql: ${TABLE}.lineItem_UsageAmount ;;
# #   }

# #   dimension_group: line_item_usage_end {
# #     type: time
# #     timeframes: [
# #       raw,
# #       time,
# #       date,
# #       week,
# #       month,
# #       quarter,
# #       year
# #     ]
# #     sql: ${TABLE}.lineItem_UsageEndDate ;;
# #   }

# #   dimension_group: line_item_usage_start {
# #     type: time
# #     timeframes: [
# #       raw,
# #       time,
# #       date,
# #       week,
# #       month,
# #       quarter,
# #       year
# #     ]
# #     sql: ${TABLE}.lineItem_UsageStartDate ;;
# #   }

# #   dimension: line_item_usage_type {
# #     type: string
# #     sql: ${TABLE}.lineItem_UsageType ;;
# #   }

# #   dimension: pricing_currency {
# #     type: string
# #     sql: ${TABLE}.pricing_currency ;;
# #   }

# #   dimension: pricing_public_on_demand_cost {
# #     type: number
# #     sql: ${TABLE}.pricing_publicOnDemandCost ;;
# #   }

# #   dimension: pricing_public_on_demand_rate {
# #     type: number
# #     sql: ${TABLE}.pricing_publicOnDemandRate ;;
# #   }

# #   dimension: pricing_rate_code {
# #     type: string
# #     sql: ${TABLE}.pricing_RateCode ;;
# #   }

# #   dimension: pricing_rate_id {
# #     type: string
# #     sql: ${TABLE}.pricing_RateId ;;
# #   }

# #   dimension: pricing_term {
# #     type: string
# #     sql: ${TABLE}.pricing_term ;;
# #   }

# #   dimension: pricing_unit {
# #     type: string
# #     sql: ${TABLE}.pricing_unit ;;
# #   }

# #   dimension: product_alarm_type {
# #     type: string
# #     sql: ${TABLE}.product_alarmType ;;
# #   }

# #   dimension: product_attachment_type {
# #     type: string
# #     sql: ${TABLE}.product_attachmentType ;;
# #   }

# #   dimension: product_availability {
# #     type: string
# #     sql: ${TABLE}.product_availability ;;
# #   }

# #   dimension: product_capacitystatus {
# #     type: string
# #     sql: ${TABLE}.product_capacitystatus ;;
# #   }

# #   dimension: product_category {
# #     type: string
# #     sql: ${TABLE}.product_category ;;
# #   }

# #   dimension: product_ci_type {
# #     type: string
# #     sql: ${TABLE}.product_ciType ;;
# #   }

# #   dimension: product_clock_speed {
# #     type: string
# #     sql: ${TABLE}.product_clockSpeed ;;
# #   }

# #   dimension: product_component {
# #     type: string
# #     sql: ${TABLE}.product_component ;;
# #   }

# #   dimension: product_compute_family {
# #     type: string
# #     sql: ${TABLE}.product_computeFamily ;;
# #   }

# #   dimension: product_compute_type {
# #     type: string
# #     sql: ${TABLE}.product_computeType ;;
# #   }

# #   dimension: product_current_generation {
# #     type: string
# #     sql: ${TABLE}.product_currentGeneration ;;
# #   }

# #   dimension: product_database_engine {
# #     type: string
# #     sql: ${TABLE}.product_databaseEngine ;;
# #   }

# #   dimension: product_deployment_option {
# #     type: string
# #     sql: ${TABLE}.product_deploymentOption ;;
# #   }

# #   dimension: product_description {
# #     type: string
# #     sql: ${TABLE}.product_description ;;
# #   }

# #   dimension: product_durability {
# #     type: string
# #     sql: ${TABLE}.product_durability ;;
# #   }

# #   dimension: product_ecu {
# #     type: string
# #     sql: ${TABLE}.product_ecu ;;
# #   }

# #   dimension: product_endpoint_type {
# #     type: string
# #     sql: ${TABLE}.product_endpointType ;;
# #   }

# #   dimension: product_engine_code {
# #     type: string
# #     sql: ${TABLE}.product_engineCode ;;
# #   }

# #   dimension: product_enhanced_networking_supported {
# #     type: string
# #     sql: ${TABLE}.product_enhancedNetworkingSupported ;;
# #   }

# #   dimension: product_from_location {
# #     type: string
# #     sql: ${TABLE}.product_fromLocation ;;
# #   }

# #   dimension: product_from_location_type {
# #     type: string
# #     sql: ${TABLE}.product_fromLocationType ;;
# #   }

# #   dimension: product_gpu {
# #     type: string
# #     sql: ${TABLE}.product_gpu ;;
# #   }

# #   dimension: product_gpu_memory {
# #     type: string
# #     sql: ${TABLE}.product_gpuMemory ;;
# #   }

# #   dimension: product_group {
# #     type: string
# #     sql: ${TABLE}.product_group ;;
# #   }

# #   dimension: product_group_description {
# #     type: string
# #     sql: ${TABLE}.product_groupDescription ;;
# #   }

# #   dimension: product_instance_family {
# #     type: string
# #     sql: ${TABLE}.product_instanceFamily ;;
# #   }

# #   dimension: product_instance_name {
# #     type: string
# #     sql: ${TABLE}.product_instanceName ;;
# #   }

# #   dimension: product_instance_type {
# #     type: string
# #     sql: ${TABLE}.product_instanceType ;;
# #   }

# #   dimension: product_instance_type_family {
# #     type: string
# #     sql: ${TABLE}.product_instanceTypeFamily ;;
# #   }

# #   dimension: product_intel_avx2_available {
# #     type: string
# #     sql: ${TABLE}.product_intelAvx2Available ;;
# #   }

# #   dimension: product_intel_avx_available {
# #     type: string
# #     sql: ${TABLE}.product_intelAvxAvailable ;;
# #   }

# #   dimension: product_intel_turbo_available {
# #     type: string
# #     sql: ${TABLE}.product_intelTurboAvailable ;;
# #   }

# #   dimension: product_license_model {
# #     type: string
# #     sql: ${TABLE}.product_licenseModel ;;
# #   }

# #   dimension: product_location {
# #     type: string
# #     sql: ${TABLE}.product_location ;;
# #   }

# #   dimension: product_location_type {
# #     type: string
# #     sql: ${TABLE}.product_locationType ;;
# #   }

# #   dimension: product_logs_destination {
# #     type: string
# #     sql: ${TABLE}.product_logsDestination ;;
# #   }

# #   dimension: product_max_iops_burst_performance {
# #     type: string
# #     sql: ${TABLE}.product_maxIopsBurstPerformance ;;
# #   }

# #   dimension: product_max_iopsvolume {
# #     type: string
# #     sql: ${TABLE}.product_maxIopsvolume ;;
# #   }

# #   dimension: product_max_throughputvolume {
# #     type: string
# #     sql: ${TABLE}.product_maxThroughputvolume ;;
# #   }

# #   dimension: product_max_volume_size {
# #     type: string
# #     sql: ${TABLE}.product_maxVolumeSize ;;
# #   }

# #   dimension: product_memory {
# #     type: string
# #     sql: ${TABLE}.product_memory ;;
# #   }

# #   dimension: product_memory_gib {
# #     type: string
# #     sql: ${TABLE}.product_memoryGib ;;
# #   }

# #   dimension: product_message_delivery_frequency {
# #     type: string
# #     sql: ${TABLE}.product_messageDeliveryFrequency ;;
# #   }

# #   dimension: product_message_delivery_order {
# #     type: string
# #     sql: ${TABLE}.product_messageDeliveryOrder ;;
# #   }

# #   dimension: product_min_volume_size {
# #     type: string
# #     sql: ${TABLE}.product_minVolumeSize ;;
# #   }

# #   dimension: product_network_performance {
# #     type: string
# #     sql: ${TABLE}.product_networkPerformance ;;
# #   }

# #   dimension: product_normalization_size_factor {
# #     type: string
# #     sql: ${TABLE}.product_normalizationSizeFactor ;;
# #   }

# #   dimension: product_operating_system {
# #     type: string
# #     sql: ${TABLE}.product_operatingSystem ;;
# #   }

# #   dimension: product_operation {
# #     type: string
# #     sql: ${TABLE}.product_operation ;;
# #   }

# #   dimension: product_physical_cpu {
# #     type: string
# #     sql: ${TABLE}.product_physicalCpu ;;
# #   }

# #   dimension: product_physical_gpu {
# #     type: string
# #     sql: ${TABLE}.product_physicalGpu ;;
# #   }

# #   dimension: product_physical_processor {
# #     type: string
# #     sql: ${TABLE}.product_physicalProcessor ;;
# #   }

# #   dimension: product_platoclassificationtype {
# #     type: string
# #     sql: ${TABLE}.product_platoclassificationtype ;;
# #   }

# #   dimension: product_platoinstancename {
# #     type: string
# #     sql: ${TABLE}.product_platoinstancename ;;
# #   }

# #   dimension: product_platoinstancetype {
# #     type: string
# #     sql: ${TABLE}.product_platoinstancetype ;;
# #   }

# #   dimension: product_platopricingtype {
# #     type: string
# #     sql: ${TABLE}.product_platopricingtype ;;
# #   }

# #   dimension: product_platostoragetype {
# #     type: string
# #     sql: ${TABLE}.product_platostoragetype ;;
# #   }

# #   dimension: product_platousagetype {
# #     type: string
# #     sql: ${TABLE}.product_platousagetype ;;
# #   }

# #   dimension: product_pre_installed_sw {
# #     type: string
# #     sql: ${TABLE}.product_preInstalledSw ;;
# #   }

# #   dimension: product_processor_architecture {
# #     type: string
# #     sql: ${TABLE}.product_processorArchitecture ;;
# #   }

# #   dimension: product_processor_features {
# #     type: string
# #     sql: ${TABLE}.product_processorFeatures ;;
# #   }

# #   dimension: product_product_family {
# #     type: string
# #     sql: ${TABLE}.product_productFamily ;;
# #   }

# #   dimension: product_product_name {
# #     type: string
# #     sql: ${TABLE}.product_ProductName ;;
# #   }

# #   dimension: product_queue_type {
# #     type: string
# #     sql: ${TABLE}.product_queueType ;;
# #   }

# #   dimension: product_region {
# #     type: string
# #     sql: ${TABLE}.product_region ;;
# #   }

# #   dimension: product_routing_target {
# #     type: string
# #     sql: ${TABLE}.product_routingTarget ;;
# #   }

# #   dimension: product_routing_type {
# #     type: string
# #     sql: ${TABLE}.product_routingType ;;
# #   }

# #   dimension: product_servicecode {
# #     type: string
# #     sql: ${TABLE}.product_servicecode ;;
# #   }

# #   dimension: product_servicename {
# #     type: string
# #     sql: ${TABLE}.product_servicename ;;
# #   }

# #   dimension: product_sku {
# #     type: string
# #     sql: ${TABLE}.product_sku ;;
# #   }

# #   dimension: product_storage {
# #     type: string
# #     sql: ${TABLE}.product_storage ;;
# #   }

# #   dimension: product_storage_class {
# #     type: string
# #     sql: ${TABLE}.product_storageClass ;;
# #   }

# #   dimension: product_storage_family {
# #     type: string
# #     sql: ${TABLE}.product_storageFamily ;;
# #   }

# #   dimension: product_storage_media {
# #     type: string
# #     sql: ${TABLE}.product_storageMedia ;;
# #   }

# #   dimension: product_storage_type {
# #     type: string
# #     sql: ${TABLE}.product_storageType ;;
# #   }

# #   dimension: product_tenancy {
# #     type: string
# #     sql: ${TABLE}.product_tenancy ;;
# #   }

# #   dimension: product_to_location {
# #     type: string
# #     sql: ${TABLE}.product_toLocation ;;
# #   }

# #   dimension: product_to_location_type {
# #     type: string
# #     sql: ${TABLE}.product_toLocationType ;;
# #   }

# #   dimension: product_transfer_type {
# #     type: string
# #     sql: ${TABLE}.product_transferType ;;
# #   }

# #   dimension: product_usagetype {
# #     type: string
# #     sql: ${TABLE}.product_usagetype ;;
# #   }

# #   dimension: product_vcpu {
# #     type: string
# #     sql: ${TABLE}.product_vcpu ;;
# #   }

# #   dimension: product_version {
# #     type: string
# #     sql: ${TABLE}.product_version ;;
# #   }

# #   dimension: product_volume_api_name {
# #     type: string
# #     sql: ${TABLE}.product_volumeApiName ;;
# #   }

# #   dimension: product_volume_type {
# #     type: string
# #     sql: ${TABLE}.product_volumeType ;;
# #   }

# #   dimension: reservation_amortized_upfront_cost_for_usage {
# #     type: number
# #     sql: ${TABLE}.reservation_AmortizedUpfrontCostForUsage ;;
# #   }

# #   dimension: reservation_amortized_upfront_fee_for_billing_period {
# #     type: string
# #     sql: ${TABLE}.reservation_AmortizedUpfrontFeeForBillingPeriod ;;
# #   }

# #   dimension: reservation_effective_cost {
# #     type: number
# #     sql: ${TABLE}.reservation_EffectiveCost ;;
# #   }

# #   dimension: reservation_end_time {
# #     type: string
# #     sql: ${TABLE}.reservation_EndTime ;;
# #   }

# #   dimension: reservation_modification_status {
# #     type: string
# #     sql: ${TABLE}.reservation_ModificationStatus ;;
# #   }

# #   dimension: reservation_normalized_units_per_reservation {
# #     type: string
# #     sql: ${TABLE}.reservation_NormalizedUnitsPerReservation ;;
# #   }

# #   dimension: reservation_number_of_reservations {
# #     type: number
# #     sql: ${TABLE}.reservation_NumberOfReservations ;;
# #   }

# #   dimension: reservation_recurring_fee_for_usage {
# #     type: number
# #     sql: ${TABLE}.reservation_RecurringFeeForUsage ;;
# #   }

# #   dimension: reservation_start_time {
# #     type: string
# #     sql: ${TABLE}.reservation_StartTime ;;
# #   }

# #   dimension: reservation_subscription_id {
# #     type: string
# #     sql: ${TABLE}.reservation_SubscriptionId ;;
# #   }

# #   dimension: reservation_total_reserved_normalized_units {
# #     type: number
# #     sql: ${TABLE}.reservation_TotalReservedNormalizedUnits ;;
# #   }

# #   dimension: reservation_total_reserved_units {
# #     type: number
# #     sql: ${TABLE}.reservation_TotalReservedUnits ;;
# #   }

# #   dimension: reservation_units_per_reservation {
# #     type: number
# #     sql: ${TABLE}.reservation_UnitsPerReservation ;;
# #   }

# #   dimension: reservation_unused_amortized_upfront_fee_for_billing_period {
# #     type: number
# #     sql: ${TABLE}.reservation_UnusedAmortizedUpfrontFeeForBillingPeriod ;;
# #   }

# #   dimension: reservation_unused_normalized_unit_quantity {
# #     type: number
# #     sql: ${TABLE}.reservation_UnusedNormalizedUnitQuantity ;;
# #   }

# #   dimension: reservation_unused_quantity {
# #     type: number
# #     sql: ${TABLE}.reservation_UnusedQuantity ;;
# #   }

# #   dimension: reservation_unused_recurring_fee {
# #     type: number
# #     sql: ${TABLE}.reservation_UnusedRecurringFee ;;
# #   }

# #   dimension: reservation_upfront_value {
# #     type: number
# #     sql: ${TABLE}.reservation_UpfrontValue ;;
# #   }

# #   dimension: savings_plan_amortized_upfront_commitment_for_billing_period {
# #     type: number
# #     sql: ${TABLE}.savingsPlan_AmortizedUpfrontCommitmentForBillingPeriod ;;
# #   }

# #   dimension: savings_plan_recurring_commitment_for_billing_period {
# #     type: number
# #     sql: ${TABLE}.savingsPlan_RecurringCommitmentForBillingPeriod ;;
# #   }

# #   dimension: savings_plan_savings_plan_arn {
# #     type: string
# #     sql: ${TABLE}.savingsPlan_SavingsPlanARN ;;
# #   }

# #   dimension: savings_plan_savings_plan_effective_cost {
# #     type: number
# #     sql: ${TABLE}.savingsPlan_SavingsPlanEffectiveCost ;;
# #   }

# #   dimension: savings_plan_savings_plan_rate {
# #     type: number
# #     sql: ${TABLE}.savingsPlan_SavingsPlanRate ;;
# #   }

# #   dimension: savings_plan_total_commitment_to_date {
# #     type: number
# #     sql: ${TABLE}.savingsPlan_TotalCommitmentToDate ;;
# #   }

# #   dimension: savings_plan_used_commitment {
# #     type: number
# #     sql: ${TABLE}.savingsPlan_UsedCommitment ;;
# #   }

# #   measure: count {
# #     type: count
# #     drill_fields: [product_product_name, product_volume_api_name, product_platoinstancename, product_instance_name, product_servicename]
# #   }
# # }
