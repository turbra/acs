CENTRAL=central.example.com
CENTRAL_PASS="AdminPassForCentral"

# Get an API token
POLICY_JSON='{ "name": "mytoken", "role":"Admin"}'
APIURL="https://$CENTRAL/v1/apitokens/generate"
ROX_API_TOKEN=$(curl -s -k -u admin:$CENTRAL_PASS -H 'Content-Type: application/json' -X POST -d "$POLICY_JSON" "$APIURL" | jq -r '.token')


# Fetch the ID of existing OpenShift auth provider
EXISTING_AUTH_ID=$(curl -s -k -H "Authorization: Bearer ${ROX_API_TOKEN}" "https://${CENTRAL}/v1/authProviders" | jq -r '.authProviders[] | select(.name == "OpenShift") .id')


# Check if the ID was retrieved
if [ -z "$EXISTING_AUTH_ID" ] || [ "$EXISTING_AUTH_ID" == "null" ]; then
    echo "Error: Could not retrieve the OpenShift auth provider ID."
    exit 1
else
    AUTH_ID=$EXISTING_AUTH_ID
fi

# Continue with your custom rule creation using $AUTH_ID

# Custom rule for ocp-admins
RULE_PAYLOAD='{
    "previous_groups": [],
    "required_groups": [
        {
            "props": {
                "authProviderId": "'${AUTH_ID}'",
                "key": "groups",
                "value": "dev-group"
            },
            "roleName": "Analyst"
        }
    ]
}'
curl -k -H "Authorization: Bearer ${ROX_API_TOKEN}" --header "Content-Type: application/json" -X POST "https://${CENTRAL}/v1/groupsbatch" -d "$RULE_PAYLOAD"
