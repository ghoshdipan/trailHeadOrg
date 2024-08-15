# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to get the corresponding test class only for the changed 
#               apex classes so that it saves time during the deployment.
# Author : Shubham Kumar
# Date : 19th Mar 2022
# --------------------------------------------------------------------------------------------------------------
# Modification Logs :
# Date              Changes
# 19th Mar 22       Initial Version
# 9th May 23        Enhancements for SF Commands repacing sfdx
# --------------------------------------------------------------------------------------------------------------

git config --global --add safe.directory '*'
testclass="DeleteContentDocumentLinkTest"

# getting the list of changed apex classes so that we can get the corresponding test class for the same
SPECIFIED_APEX_CLASSES=$(git diff origin/$BASE_BRANCH HEAD --name-only --diff-filter=d force-app/main/default/classes)
SPECIFIED_APEX_CLASSES+=" "$(git diff origin/$BASE_BRANCH HEAD --name-only --diff-filter=d force-app/main/default/triggers)

#echo "Modified Apex Classes "$SPECIFIED_APEX_CLASSES
echo Apex Class / Trigger" || ======> || "Corresponding Test Class

# Iterating through the list to get the test class name as per CSV.
for className in $SPECIFIED_APEX_CLASSES
do   
    # Removing prefixes and postfixes from the name so that we can get corresponding test class
    className=${className#*force-app/main/default/classes/}
    className=${className#*force-app/main/default/triggers/}
    className=${className%%.*}

    # Iterating through test class CSV to get the key value.
    for row in $(cat testclass/testclass.txt)
    do 
        # Fetching the Key value pair from the rows of CSV.
        value=${row#*,}
        key=${row%,*}
        if [[ $key == $className && ( $testclass != *" $value "* || $testclass != *" $value"* || $testclass != *"$value "* ) ]]
        then
            echo $key" || ======> || "$value
            testclass+=" $value"
        fi
    done
done

# Posting the csv to the txt file so that they can be utilized in the deployment.
echo ${testclass#*,} > testclass/testclass.txt
