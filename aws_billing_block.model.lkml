connection: "@{aws_looker_reports}"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/explores/*.explore"
include: "/dashboards/*"
