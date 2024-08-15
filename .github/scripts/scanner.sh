# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to get the pmd executed for code quality validation
# Author : Shubham Kumar
# Date : 19th Mar 2023
# --------------------------------------------------------------------------------------------------------------
# Modification Logs :
# Date              Changes
# 19th Mar 22       Initial Version
# 9th May 23        Enhancements for SF Commands repacing sfdx
# --------------------------------------------------------------------------------------------------------------

# Changing the home so that it points to root where docker has loaded the dependencies.
# export HOME=/root

# Executing Scanner command to get the violations tracked.
sf scanner:run --format csv --pmdconfig pmd-rule-sets/rule-set.xml --outfile pipeline-artifacts/pmd-results.csv --target changed-sources/force-app/main --normalize-severity
cat pipeline-artifacts/pmd-results.csv
