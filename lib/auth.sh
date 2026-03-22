# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::azure::auth::login(email)
#
#  Args:
#	email -
#
#>
######################################################################
p6df::modules::azure::auth::login() {
  local email="${1:?requires email address}"

  az login --username "${email}"

  p6_return_void
}

######################################################################
#<
#
# Function: str {token} = p6df::modules::azure::oauth::token(email, scopes)
#
#  Args:
#	email -
#	scopes -
#
#  Returns:
#	str - {token}
#
#>
######################################################################
p6df::modules::azure::oauth::token() {
  local email="${1:?requires email address}"
  local scopes="${2:?requires space-separated scopes}"

  local token
  if ! token=$(az account get-access-token \
    --scope "${scopes}" \
    --query accessToken \
    --output tsv 2>/dev/null); then
    p6df::modules::azure::auth::login "${email}"
    token=$(az account get-access-token \
      --scope "${scopes}" \
      --query accessToken \
      --output tsv)
  fi

  p6_return_str "${token}"
}

######################################################################
#<
#
# Function: str {token} = p6df::modules::azure::auth::sp::token(client_id, client_secret, tenant_id, scopes)
#
#  Args:
#	client_id -
#	client_secret -
#	tenant_id -
#	scopes -
#
#  Returns:
#	str - {token}
#
#  Notes:
#	Service principal equivalent of GWS Domain-Wide Delegation.
#	Uses MSAL (installed via msgraph-sdk-python) to acquire a
#	client-credentials token for application permissions.
#
#>
######################################################################
p6df::modules::azure::auth::sp::token() {
  local client_id="${1:?requires client ID}"
  local client_secret="${2:?requires client secret}"
  local tenant_id="${3:?requires tenant ID}"
  local scopes="${4:?requires space-separated scopes}"

  local token
  token=$(python3 - <<PYEOF
import msal, sys
app = msal.ConfidentialClientApplication(
    "${client_id}",
    authority="https://login.microsoftonline.com/${tenant_id}",
    client_credential="${client_secret}",
)
result = app.acquire_token_for_client(scopes=["${scopes}"])
if "access_token" not in result:
    print(result.get("error_description", "unknown error"), file=sys.stderr)
    sys.exit(1)
print(result["access_token"])
PYEOF
)

  p6_return_str "${token}"
}
