# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to get the org authenticate using secret url.
# Author : Shubham Kumar
# Date : 19th Mar 2022
# --------------------------------------------------------------------------------------------------------------
# Modification Logs :
# Date              Changes
# 19th Mar 22       Initial Version
# 9th May 23        Enhancements for SF Commands repacing sfdx
# --------------------------------------------------------------------------------------------------------------
# Executing command to authenticate the org with auth url and setting it as default.
echo ${SECRET_URL_PATH} > ./CI_SFDX_URL.txt && 
sf org login sfdx-url --sfdx-url-file ./CI_SFDX_URL.txt --set-default --alias ${SOURCE_ORG_ALIAS}
