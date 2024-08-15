# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to retrieve the custom settings changes to higher orgs.
# Author : Shubham Kumar
# Date : 19th Mar 2022
# --------------------------------------------------------------------------------------------------------------
# Modification Logs :
# Date              Changes
# 19th Mar 22       Initial Version
# 9th May 23        Enhancements for SF Commands repacing sfdx
# --------------------------------------------------------------------------------------------------------------
cd sfdmu/firstrun
sfdx sfdmu:run --sourceusername BPDevSandbox --targetusername csvfile
cd -