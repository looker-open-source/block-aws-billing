- dashboard: aws_summary
  title: AWS Summary
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: YEAR OVER YEAR SPEND
    name: YEAR OVER YEAR SPEND
    model: aws_billing_block
    explore: aws_billing
    type: looker_line
    fields: [aws_billing.usage_start_month_name, aws_billing.usage_start_year, aws_billing.total_blended_cost]
    pivots: [aws_billing.usage_start_year]
    filters:
      aws_billing.usage_start_month: before 0 months from now
      aws_billing.usage_start_year: 3 years ago for 3 years,1 years
      aws_billing.total_blended_cost: NOT NULL
    sorts: [aws_billing.usage_start_year, aws_billing.usage_start_month_name]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: monotone
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      custom:
        id: 3ecc4891-ba14-1878-929a-6e2cc7d6a7de
        label: Custom
        type: discrete
        colors:
        - "#ff9900"
        - "#146EB4"
        - "#e47911"
        - "#23223e"
        - "#111111"
        - "#48a3c6"
        - "#007eb9"
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: aws_billing.total_blended_cost,
            id: 2018 - aws_billing.total_blended_cost, name: 2018 - Aws Billing Total
              Blended Cost}, {axisId: aws_billing.total_blended_cost, id: 2019 - aws_billing.total_blended_cost,
            name: 2019 - Aws Billing Total Blended Cost}, {axisId: aws_billing.total_blended_cost,
            id: 2020 - aws_billing.total_blended_cost, name: 2020 - Aws Billing Total
              Blended Cost}, {axisId: aws_billing.total_blended_cost, id: 2021 - aws_billing.total_blended_cost,
            name: 2021 - Aws Billing Total Blended Cost}], showLabels: true, showValues: true,
        valueFormat: '[>=1000000]$0.0,,"M";$0.0,"K"', unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 13, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: year_end, id: 2018 - year_end, name: 2018 - Year End}, {
            axisId: year_end, id: 2019 - year_end, name: 2019 - Year End}, {axisId: year_end,
            id: 2020 - year_end, name: 2020 - Year End}, {axisId: year_end, id: 2021
              - year_end, name: 2021 - Year End}], showLabels: true, showValues: true,
        valueFormat: '[>=1000000]$0.0,,"M";$0.0,"K"', unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 13, type: linear}]
    series_types: {}
    series_colors: {}
    label_color: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 2
    col: 4
    width: 20
    height: 8
  - title: YTD Costs
    name: YTD Costs
    model: aws_billing_block
    explore: aws_billing
    type: single_value
    fields: [aws_billing.period_selected, aws_billing.total_blended_cost]
    filters:
      aws_billing.period: Year
      aws_billing.period_selected: "-NULL"
    sorts: [aws_billing.period_selected desc]
    limit: 500
    dynamic_fields: [{_kind_hint: measure, table_calculation: change, _type_hint: number,
        category: table_calculation, expression: "${aws_billing.total_blended_cost}/offset(${aws_billing.total_blended_cost},1)-1",
        label: Change, value_format: !!null '', value_format_name: percent_1}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#FF9900"
    single_value_title: YTD Costs
    value_format: '[>=1000000]$0.00,,"M";$0.00,"K"'
    conditional_formatting: [{type: equal to, value: !!null '', background_color: '',
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 2
    col: 0
    width: 4
    height: 2
  - title: MTD Costs
    name: MTD Costs
    model: aws_billing_block
    explore: aws_billing
    type: single_value
    fields: [aws_billing.period_selected, aws_billing.total_blended_cost]
    filters:
      aws_billing.period: Month
      aws_billing.period_selected: "-NULL"
    sorts: [aws_billing.period_selected desc]
    limit: 500
    dynamic_fields: [{_kind_hint: measure, table_calculation: change, _type_hint: number,
        category: table_calculation, expression: "${aws_billing.total_blended_cost}/offset(${aws_billing.total_blended_cost},1)-1",
        label: Change, value_format: !!null '', value_format_name: percent_1}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#FF9900"
    single_value_title: MTD Costs
    value_format: '[>=1000000]$0.00,,"M";$0.00,"K"'
    conditional_formatting: [{type: equal to, value: !!null '', background_color: '',
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 6
    col: 0
    width: 4
    height: 2
  - title: WTD Costs
    name: WTD Costs
    model: aws_billing_block
    explore: aws_billing
    type: single_value
    fields: [aws_billing.period_selected, aws_billing.total_blended_cost]
    filters:
      aws_billing.period: Week
      aws_billing.period_selected: "-NULL"
    sorts: [aws_billing.period_selected desc]
    limit: 500
    dynamic_fields: [{_kind_hint: measure, table_calculation: change, _type_hint: number,
        category: table_calculation, expression: "${aws_billing.total_blended_cost}/offset(${aws_billing.total_blended_cost},1)-1",
        label: Change, value_format: !!null '', value_format_name: percent_1}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#FF9900"
    single_value_title: WTD Costs
    value_format: '[>=1000000]$0.00,,"M";$0.00,"K"'
    conditional_formatting: [{type: equal to, value: !!null '', background_color: '',
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 8
    col: 0
    width: 4
    height: 2
  - title: QTD Costs
    name: QTD Costs
    model: aws_billing_block
    explore: aws_billing
    type: single_value
    fields: [aws_billing.period_selected, aws_billing.total_blended_cost]
    filters:
      aws_billing.period: Quarter
      aws_billing.period_selected: "-NULL"
    sorts: [aws_billing.period_selected desc]
    limit: 500
    dynamic_fields: [{_kind_hint: measure, table_calculation: change, _type_hint: number,
        category: table_calculation, expression: "${aws_billing.total_blended_cost}/offset(${aws_billing.total_blended_cost},1)-1",
        label: Change, value_format: !!null '', value_format_name: percent_1}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#FF9900"
    single_value_title: QTD Costs
    value_format: '[>=1000000]$0.00,,"M";$0.00,"K"'
    conditional_formatting: [{type: equal to, value: !!null '', background_color: '',
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 4
    col: 0
    width: 4
    height: 2
  - name: "<b>SPEND TO DATE</b>"
    type: text
    title_text: "<b>SPEND TO DATE</b>"
    subtitle_text: ''
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 2
  - title: RESERVED VS ONDEMAND INSTANCES
    name: RESERVED VS ONDEMAND INSTANCES
    model: aws_billing_block
    explore: aws_billing
    type: looker_pie
    fields: [aws_billing.reserved_instance, aws_billing.total_blended_cost]
    sorts: [aws_billing.total_blended_cost desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    inner_radius: 55
    color_application:
      collection_id: billing
      palette_id: billing-categorical-0
      options:
        steps: 5
    series_colors:
      'false': "#FF9900"
      'true': "#E8EAED"
    series_labels:
      'false': OnDemand Instances
      'true': Reserved Instances
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Usage Start Date: aws_billing.usage_start_date
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 12
    col: 0
    width: 8
    height: 7
  - title: USAGE TYPE
    name: USAGE TYPE
    model: aws_billing_block
    explore: aws_billing
    type: looker_grid
    fields: [aws_billing.total_blended_cost, aws_billing.total_unblended_cost, aws_billing.average_cost_per_month,
      aws_billing.usage_type, aws_billing.period_selected]
    pivots: [aws_billing.period_selected]
    filters:
      aws_billing.period: Quarter
      aws_billing.period_selected: "-NULL"
    sorts: [aws_billing.total_blended_cost desc 0, aws_billing.period_selected]
    limit: 10
    dynamic_fields: [{_kind_hint: supermeasure, table_calculation: change, _type_hint: number,
        category: table_calculation, expression: 'pivot_index(${aws_billing.total_blended_cost},
          2)/pivot_index(${aws_billing.total_blended_cost}, 1)-1', label: Change,
        value_format: !!null '', value_format_name: percent_1}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '10'
    rows_font_size: '10'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google
      palette_id: google-categorical-0
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      aws_billing.linked_account_id: Linked Account ID
      aws_billing.total_blended_cost: Total Cost
      aws_billing.total_unblended_cost: Total Unblended Cost
      aws_billing.average_cost_per_month: Monthly Avg.
    series_column_widths: {}
    series_cell_visualizations:
      aws_billing.total_blended_cost:
        is_active: true
        palette:
          palette_id: fd01fd1a-7713-dbe1-266f-9d58b0e32fc3
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
      aws_billing.average_cost_per_month:
        is_active: false
        palette:
          palette_id: 3e14b15c-8956-7fcc-99f7-cc5d904acb01
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
      aws_billing.total_unblended_cost:
        is_active: true
        palette:
          palette_id: 111a0970-bbea-4ba8-795e-c9a726d409c8
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
    series_value_format:
      aws_billing.total_blended_cost: '[<=1000000]$0.0,"K";$0.0,,"M"'
      aws_billing.average_cost_per_month: '[<=1000000]$0.0,"K";$0.0,,"M"'
    defaults_version: 1
    series_types: {}
    hidden_fields: [aws_billing.total_unblended_cost]
    listen:
      Usage Start Date: aws_billing.usage_start_date
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 28
    col: 0
    width: 12
    height: 5
  - name: "<b>RESERVED INSTANCE ANALYSIS</b>"
    type: text
    title_text: "<b>RESERVED INSTANCE ANALYSIS</b>"
    subtitle_text: ''
    body_text: ''
    row: 10
    col: 0
    width: 24
    height: 2
  - name: "<b>COST BREAKDOWN DETAILS</b>"
    type: text
    title_text: "<b>COST BREAKDOWN DETAILS</b>"
    subtitle_text: ''
    body_text: ''
    row: 19
    col: 0
    width: 24
    height: 2
  - title: RESERVED VS ONDEMAND INSTANCES BY MONTH
    name: RESERVED VS ONDEMAND INSTANCES BY MONTH
    model: aws_billing_block
    explore: aws_billing
    type: looker_column
    fields: [aws_billing.usage_start_month, aws_billing.total_blended_cost, aws_billing.total_blended_cost_non_reserved,
      aws_billing.total_blended_cost_reserved]
    filters: {}
    sorts: [aws_billing.usage_start_month desc]
    limit: 500
    dynamic_fields: [{_kind_hint: measure, table_calculation: percent_of_spend_reserved_instance,
        _type_hint: number, category: table_calculation, expression: "${aws_billing.total_blended_cost_reserved}/${aws_billing.total_blended_cost}",
        label: Percent of Spend Reserved Instance, value_format: !!null '', value_format_name: percent_1},
      {_kind_hint: measure, table_calculation: percent_of_spend_ondemand_instance,
        _type_hint: number, category: table_calculation, expression: "${aws_billing.total_blended_cost_non_reserved}/${aws_billing.total_blended_cost}",
        label: Percent of Spend OnDemand Instance, value_format: !!null '', value_format_name: percent_1}]
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: billing
      palette_id: billing-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: aws_billing.total_blended_cost_non_reserved,
            id: aws_billing.total_blended_cost_non_reserved, name: Total Cost (OnDemand)},
          {axisId: aws_billing.total_blended_cost_reserved, id: aws_billing.total_blended_cost_reserved,
            name: Total Cost (Reserved)}], showLabels: true, showValues: true, valueFormat: '$0,"K"',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: Percent of Spend, orientation: right, series: [{axisId: percent_of_spend_reserved_instance,
            id: percent_of_spend_reserved_instance, name: "% of Spend Reserved"},
          {axisId: percent_of_spend_ondemand_instance, id: percent_of_spend_ondemand_instance,
            name: "% of Spend OnDemand"}], showLabels: true, showValues: true, valueFormat: 0%,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types:
      percent_of_spend_reserved_instance: line
      percent_of_spend_ondemand_instance: line
    series_colors:
      aws_billing.total_blended_cost_non_reserved: "#FF9900"
      aws_billing.total_blended_cost_reserved: "#E8EAED"
      percent_of_spend_reserved_instance: "#4285F4"
      percent_of_spend_ondemand_instance: "#23223e"
    series_labels:
      aws_billing.total_blended_cost_non_reserved: Total Cost (OnDemand)
      aws_billing.total_blended_cost_reserved: Total Cost (Reserved)
      percent_of_spend_reserved_instance: "% of Spend Reserved"
      percent_of_spend_ondemand_instance: "% of Spend OnDemand"
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [aws_billing.total_blended_cost]
    listen:
      Usage Start Date: aws_billing.usage_start_date
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 12
    col: 8
    width: 16
    height: 7
  - title: TOP BILLED RESOURCES
    name: TOP BILLED RESOURCES
    model: aws_billing_block
    explore: aws_billing
    type: looker_waterfall
    fields: [aws_billing.total_blended_cost, aws_billing.resource_id]
    filters: {}
    sorts: [aws_billing.total_blended_cost desc]
    limit: 10
    column_limit: 50
    dynamic_fields: [{dimension: linked_account_region, _kind_hint: dimension, _type_hint: string,
        category: dimension, expression: 'concat(${aws_billing.linked_account_id},"
          - ",if(is_null(${aws_billing.availability_zone}),"no-region",${aws_billing.availability_zone}))',
        label: Linked Account - Region, value_format: !!null '', value_format_name: !!null ''},
      {_kind_hint: measure, table_calculation: total_cost, _type_hint: number, category: table_calculation,
        expression: "${aws_billing.total_blended_cost}+0", label: Total Cost, value_format: '[>=1000000]$0.0,,"M";$0.0,"K"',
        value_format_name: !!null ''}]
    up_color: "#FF9900"
    down_color: false
    total_color: "#9AA0A6"
    show_value_labels: true
    show_x_axis_ticks: true
    show_x_axis_label: true
    x_axis_scale: auto
    show_y_axis_labels: false
    show_y_axis_ticks: false
    y_axis_gridlines: false
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
    label_color: [white]
    x_axis_gridlines: false
    show_view_names: false
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    label_density: 25
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [aws_billing.total_blended_cost]
    listen:
      Usage Start Date: aws_billing.usage_start_date
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 21
    col: 4
    width: 20
    height: 7
  - title: NON AFFILIATED COSTS
    name: NON AFFILIATED COSTS
    model: aws_billing_block
    explore: aws_billing
    type: single_value
    fields: [aws_billing.total_blended_cost, aws_billing.resource_id]
    filters: {}
    sorts: [aws_billing.total_blended_cost desc]
    limit: 20
    column_limit: 50
    dynamic_fields: [{dimension: linked_account_region, _kind_hint: dimension, _type_hint: string,
        category: dimension, expression: 'concat(${aws_billing.linked_account_id},"
          - ",if(is_null(${aws_billing.availability_zone}),"no-region",${aws_billing.availability_zone}))',
        label: Linked Account - Region, value_format: !!null '', value_format_name: !!null ''},
      {_kind_hint: measure, table_calculation: total_cost, _type_hint: number, category: table_calculation,
        expression: "${aws_billing.total_blended_cost}+0", label: Total Cost, value_format: '[>=1000000]$0.0,,"M";$0.0,"K"',
        value_format_name: !!null ''}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    up_color: "#FF9900"
    down_color: false
    total_color: "#9AA0A6"
    show_value_labels: true
    show_x_axis_ticks: true
    show_x_axis_label: true
    x_axis_scale: auto
    show_y_axis_labels: false
    show_y_axis_ticks: false
    y_axis_gridlines: false
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
    label_color: [white]
    x_axis_gridlines: false
    show_view_names: false
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    label_density: 25
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [aws_billing.total_blended_cost]
    listen:
      Usage Start Date: aws_billing.usage_start_date
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 21
    col: 0
    width: 4
    height: 7
  - title: AVAILABILITY REGION
    name: AVAILABILITY REGION
    model: aws_billing_block
    explore: aws_billing
    type: looker_grid
    fields: [aws_billing.total_blended_cost, aws_billing.total_unblended_cost, aws_billing.average_cost_per_month,
      aws_billing.period_selected, aws_billing.availability_zone]
    pivots: [aws_billing.period_selected]
    filters:
      aws_billing.period: Quarter
      aws_billing.period_selected: "-NULL"
      aws_billing.availability_zone: "-NULL"
    sorts: [aws_billing.total_blended_cost desc 0, aws_billing.period_selected]
    limit: 10
    dynamic_fields: [{_kind_hint: supermeasure, table_calculation: change, _type_hint: number,
        category: table_calculation, expression: 'pivot_index(${aws_billing.total_blended_cost},
          2)/pivot_index(${aws_billing.total_blended_cost}, 1)-1', label: Change,
        value_format: !!null '', value_format_name: percent_1}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '10'
    rows_font_size: '10'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google
      palette_id: google-categorical-0
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      aws_billing.linked_account_id: Linked Account ID
      aws_billing.total_blended_cost: Total Cost
      aws_billing.total_unblended_cost: Total Unblended Cost
      aws_billing.average_cost_per_month: Monthly Avg.
    series_column_widths: {}
    series_cell_visualizations:
      aws_billing.total_blended_cost:
        is_active: true
        palette:
          palette_id: fd01fd1a-7713-dbe1-266f-9d58b0e32fc3
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
      aws_billing.average_cost_per_month:
        is_active: false
        palette:
          palette_id: 3e14b15c-8956-7fcc-99f7-cc5d904acb01
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
      aws_billing.total_unblended_cost:
        is_active: true
        palette:
          palette_id: 111a0970-bbea-4ba8-795e-c9a726d409c8
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
    series_value_format:
      aws_billing.total_blended_cost: '[<=1000000]$0.0,"K";$0.0,,"M"'
      aws_billing.average_cost_per_month: '[<=1000000]$0.0,"K";$0.0,,"M"'
    defaults_version: 1
    series_types: {}
    hidden_fields: [aws_billing.total_unblended_cost]
    listen:
      Usage Start Date: aws_billing.usage_start_date
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 33
    col: 0
    width: 12
    height: 5
  - title: LINKED ACCOUNTS
    name: LINKED ACCOUNTS
    model: aws_billing_block
    explore: aws_billing
    type: looker_grid
    fields: [aws_billing.total_blended_cost, aws_billing.total_unblended_cost, aws_billing.average_cost_per_month,
      aws_billing.period_selected, aws_billing.linked_account_id]
    pivots: [aws_billing.period_selected]
    filters:
      aws_billing.period: Quarter
      aws_billing.period_selected: "-NULL"
    sorts: [aws_billing.total_blended_cost desc 0, aws_billing.period_selected]
    limit: 10
    dynamic_fields: [{_kind_hint: supermeasure, table_calculation: change, _type_hint: number,
        category: table_calculation, expression: 'pivot_index(${aws_billing.total_blended_cost},
          2)/pivot_index(${aws_billing.total_blended_cost}, 1)-1', label: Change,
        value_format: !!null '', value_format_name: percent_1}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '10'
    rows_font_size: '10'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google
      palette_id: google-categorical-0
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      aws_billing.linked_account_id: Linked Account ID
      aws_billing.total_blended_cost: Total Cost
      aws_billing.total_unblended_cost: Total Unblended Cost
      aws_billing.average_cost_per_month: Monthly Avg.
    series_column_widths: {}
    series_cell_visualizations:
      aws_billing.total_blended_cost:
        is_active: true
        palette:
          palette_id: fd01fd1a-7713-dbe1-266f-9d58b0e32fc3
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
      aws_billing.average_cost_per_month:
        is_active: false
        palette:
          palette_id: 3e14b15c-8956-7fcc-99f7-cc5d904acb01
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
      aws_billing.total_unblended_cost:
        is_active: true
        palette:
          palette_id: 111a0970-bbea-4ba8-795e-c9a726d409c8
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
    series_value_format:
      aws_billing.total_blended_cost: '[<=1000000]$0.0,"K";$0.0,,"M"'
      aws_billing.average_cost_per_month: '[<=1000000]$0.0,"K";$0.0,,"M"'
    defaults_version: 1
    series_types: {}
    hidden_fields: [aws_billing.total_unblended_cost]
    listen:
      Usage Start Date: aws_billing.usage_start_date
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 28
    col: 12
    width: 12
    height: 5
  - title: SERVICE AREA
    name: SERVICE AREA
    model: aws_billing_block
    explore: aws_billing
    type: looker_grid
    fields: [aws_billing.total_blended_cost, aws_billing.total_unblended_cost, aws_billing.average_cost_per_month,
      aws_billing.period_selected, aws_billing.product_name]
    pivots: [aws_billing.period_selected]
    filters:
      aws_billing.period: Quarter
      aws_billing.period_selected: "-NULL"
    sorts: [aws_billing.total_blended_cost desc 0, aws_billing.period_selected]
    limit: 10
    dynamic_fields: [{_kind_hint: supermeasure, table_calculation: change, _type_hint: number,
        category: table_calculation, expression: 'pivot_index(${aws_billing.total_blended_cost},
          2)/pivot_index(${aws_billing.total_blended_cost}, 1)-1', label: Change,
        value_format: !!null '', value_format_name: percent_1}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '10'
    rows_font_size: '10'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google
      palette_id: google-categorical-0
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      aws_billing.linked_account_id: Linked Account ID
      aws_billing.total_blended_cost: Total Cost
      aws_billing.total_unblended_cost: Total Unblended Cost
      aws_billing.average_cost_per_month: Monthly Avg.
    series_column_widths: {}
    series_cell_visualizations:
      aws_billing.total_blended_cost:
        is_active: true
        palette:
          palette_id: fd01fd1a-7713-dbe1-266f-9d58b0e32fc3
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
      aws_billing.average_cost_per_month:
        is_active: false
        palette:
          palette_id: 3e14b15c-8956-7fcc-99f7-cc5d904acb01
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
      aws_billing.total_unblended_cost:
        is_active: true
        palette:
          palette_id: 111a0970-bbea-4ba8-795e-c9a726d409c8
          collection_id: google
          custom_colors:
          - "#ff9900"
          - "#146EB4"
          - "#e47911"
    series_value_format:
      aws_billing.total_blended_cost: '[<=1000000]$0.0,"K";$0.0,,"M"'
      aws_billing.average_cost_per_month: '[<=1000000]$0.0,"K";$0.0,,"M"'
    defaults_version: 1
    series_types: {}
    hidden_fields: [aws_billing.total_unblended_cost]
    listen:
      Usage Start Date: aws_billing.usage_start_date
      Product Name: aws_billing.product_name
      Resource ID: aws_billing.resource_id
    row: 33
    col: 12
    width: 12
    height: 5
  filters:
  - name: Usage Start Date
    title: Usage Start Date
    type: field_filter
    default_value: 365 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: aws_billing_block
    explore: aws_billing
    listens_to_filters: []
    field: aws_billing.usage_start_date
  - name: Product Name
    title: Product Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: aws_billing_block
    explore: aws_billing
    listens_to_filters: []
    field: aws_billing.product_name
  - name: Resource ID
    title: Resource ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: aws_billing_block
    explore: aws_billing
    listens_to_filters: []
    field: aws_billing.resource_id