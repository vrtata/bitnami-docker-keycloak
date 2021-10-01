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

for dir in "$KEYCLOAK_LOG_DIR" "$KEYCLOAK_TMP_DIR" "$KEYCLOAK_VOLUME_DIR" "$KEYCLOAK_DATA_DIR" "$KEYCLOAK_CONF_DIR" "$KEYCLOAK_INITSCRIPTS_DIR" "$KEYCLOAK_DEPLOYMENTS_DIR" "$KEYCLOAK_DOMAIN_TMP_DIR" "$KEYCLOAK_DOMAIN_CONF_DIR" "${KEYCLOAK_BASE_DIR}/.installation" "${KEYCLOAK_MYSQL_DRIVER_DIR}"; do
    ensure_dir_exists "$dir"
    chmod -R g+rwX "$dir"
done

cp "$KEYCLOAK_CONF_DIR"/"$KEYCLOAK_CONF_FILE" "$KEYCLOAK_CONF_DIR"/"$KEYCLOAK_DEFAULT_CONF_FILE"

cp "${BITNAMI_ROOT_DIR}/"*.jar "${KEYCLOAK_MYSQL_DRIVER_DIR}"
cp "${BITNAMI_ROOT_DIR}/module.xml" "${KEYCLOAK_MYSQL_DRIVER_DIR}"

rm "${BITNAMI_ROOT_DIR}/"*.jar
rm "${BITNAMI_ROOT_DIR}/module.xml"

keycloak_clean_from_restart
