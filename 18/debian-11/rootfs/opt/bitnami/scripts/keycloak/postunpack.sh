#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose

# Load libraries
. /opt/bitnami/scripts/libkeycloak.sh
. /opt/bitnami/scripts/libfs.sh
. /opt/bitnami/scripts/libos.sh

# Load keycloak environment variables
. /opt/bitnami/scripts/keycloak-env.sh

ensure_user_exists "$KEYCLOAK_ADMIN"
ensure_user_exists "$KEYCLOAK_DAEMON_USER" --group "$KEYCLOAK_DAEMON_GROUP"

for dir in "$KEYCLOAK_LOG_DIR" "$KEYCLOAK_TMP_DIR" "$KEYCLOAK_VOLUME_DIR" "$KEYCLOAK_CONF_DIR" "$KEYCLOAK_INITSCRIPTS_DIR" "${KEYCLOAK_BASE_DIR}/.installation" "${KEYCLOAK_BASE_DIR}/lib" "$KEYCLOAK_BASE_DIR" "$KEYCLOAK_PROVIDERS_DIR"; do
    ensure_dir_exists "$dir"
    chmod -R g+rwX "$dir"
    chown -R "$KEYCLOAK_DAEMON_USER" "$dir"
done
