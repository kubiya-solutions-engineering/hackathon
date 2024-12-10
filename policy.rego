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
    "list_namespaces"
}

# Allow Administrators to run admin_only functions
allow {
    group := input.user.groups[_].name
    group == "approvers"
    admin_only_functions[input.tool.name]
}

# Allow everyone to run everything except admin functions and restricted tools
allow {
    not restricted_tools[input.tool.name]
    not admin_only_functions[input.tool.name]
}
