# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to retrieve the skuid page changes so that it can be 
#               pushed to Github.
# Author : Shubham Kumar
# Date : 19th Mar 2022
# --------------------------------------------------------------------------------------------------------------
# Modification Logs :
# Date              Changes
# 19th Mar 22       Initial Version
# --------------------------------------------------------------------------------------------------------------
SPECIFIED_SKUID_PAGES=$(cat skuidpages/skuidpages.txt) &&  for i in $SPECIFIED_SKUID_PAGES
do
    echo "Pulled $i page"
    sfdx skuid:page:pull --page $i
done