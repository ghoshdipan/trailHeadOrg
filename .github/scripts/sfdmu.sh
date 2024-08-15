# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to get the data changes deployed to higher environments
# Author : Shubham Kumar
# Date : 19th Mar 2023
# --------------------------------------------------------------------------------------------------------------
# Modification Logs :
# Date              Changes
# 19th Mar 22       Initial Version
# 9th May 23        Enhancements for SF Commands repacing sfdx
# --------------------------------------------------------------------------------------------------------------

# Changing the home so that it points to root where docker has loaded the dependencies.
# export HOME=/.
# sf plugins install sfdmu

cd sfdmu/firstrun

if [ "$SOURCE_ORG_ALIAS" = "Production" ]; 
then
    echo $PRODUCTION_DOMAIN | sf sfdmu:run --sourceusername csvfile --targetusername $SOURCE_ORG_ALIAS --usesf
else
    yes y  | sf sfdmu:run --sourceusername csvfile --targetusername $SOURCE_ORG_ALIAS --usesf
fi

#This will print the MissingParentRecordsReport csv file in console
if [ -f MissingParentRecordsReport.csv ];
then
    cat MissingParentRecordsReport.csv
    cp MissingParentRecordsReport.csv ../../pipeline-artifacts
fi

if [ -f CSVIssuesReport.csv ];
then
    cat CSVIssuesReport.csv
    cp CSVIssuesReport.csv ../../pipeline-artifacts
fi
