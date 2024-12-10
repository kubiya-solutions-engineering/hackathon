package kubiya.tool_manager

# Default deny all access
default allow = false

# List of admin-only functions (functions that ONLY admin can run)
admin_only_functions = {
    "list_active_access_requests",
    "search_access_requests",
    "approve_tool_access_request"
}

# List of restricted tools (nobody can run these)
restricted_tools = {
    "list_namespaces",
    "deployment_management",
    "service_management",
    "find_resource",
    "change_replicas",
    "get_resource_events",
    "get_resource_logs",
    "node_status",
    "find_suspicious_errors",
    "network_policy_analyzer",
    "persistent_volume_usage",
    "ingress_analyzer",
    "resource_quota_usage",
    "cluster_autoscaler_status",
    "pod_disruption_budget_checker",
    "check_replicas",
    "scale_deployment",
    "deployment_rollout",
    "deployment_describe",
    "resource_usage",
    "cluster_health",
    "kubectl",
    "pod_management",
    "check_pod_restarts",
    "pv_management",
    "pv_describe",
    "pv_list",
    "pvc_management",
    "pvc_describe",
    "pvc_list",
    "service_describe"
}

# List of Slack tools
slack_tools = {
    "slack_send_message",
    "slack_delete_message",
    "slack_update_message",
    "slack_add_reaction",
    "slack_remove_reaction",
    "slack_upload_file",
    "slack_get_user_info"
}

# Allow Administrators to run admin_only functions
allow {
    group := input.user.groups[_].name
    group == "approvers"
    admin_only_functions[input.tool.name]
}

# Allow everyone to run Slack tools
allow {
    slack_tools[input.tool.name]
}

# Allow everyone to run everything except admin functions and restricted tools
allow {
    not restricted_tools[input.tool.name]
    not admin_only_functions[input.tool.name]
}
