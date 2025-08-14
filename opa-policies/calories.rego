package users

import rego.v1

# Allow read access
allow if {
    input.action == "read"
    input.resource.type == "user"
}

# Allow user creation
allow if {
    input.action == "create"
    input.resource.type == "user"
}

# Allow update only for the owner
allow if {
    input.action == "update"
    input.resource.type == "user"
    input.subject.username == input.resource.username
}

# Allow deletion only for the owner
allow if {
    input.action == "delete"
    input.resource.type == "user"
    input.subject.username == input.resource.username
}

# Deny calorie consumption exceeding authorized limit for users over 30
deny if {
    input.action == "update"
    input.resource.type == "user"
    input.resource.age > 30
    input.resource.kcal_consumed > input.resource.kcal_authorized
}