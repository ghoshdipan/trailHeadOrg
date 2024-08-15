# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to get the corresponding test class only for the changed 
#               apex classes so that it saves time during the deployment.
# Author : Shubham Kumar
# Date : 19th Apr 2023
# --------------------------------------------------------------------------------------------------------------
# Modification Logs :
# Date              Changes
# 19th Apr 23      Initial Version
# 9th May 23        Enhancements for SF Commands repacing sfdx
# --------------------------------------------------------------------------------------------------------------
# Executing command to authenticate the org with jwt token and setting it as default.
sf org login jwt -i ${CLIENT_ID} --username ${USERNAME} -r ${LOGIN_URL} -f ${SECURE_PATH} -d -a ${SOURCE_ORG_ALIAS}
sf org list