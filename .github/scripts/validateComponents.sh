cat scripts/cklogo.txt
echo "Delta Check-Only"
sfdx force:source:deploy -c -u $SOURCE_ORG_ALIAS -x package/package.xml -l RunSpecifiedTests -r $(cat ./testclass/testclass.txt) --verbose | tee ./DEPLOY_ORG.txt
DEPLOY_EXIT_CODE=${PIPESTATUS[0]}
if [ $DEPLOY_EXIT_CODE != 0 ]
then
    exit $DEPLOY_EXIT_CODE;
fi
set -o pipefail
# cat ./DEPLOY_ORG.txt
# FILE=package/package.xml
#if [ -f "$FILE" ]; then
# echo $(sfdx force:source:deploy -c -u $SOURCE_ORG_ALIAS -x package/package.xml -l RunSpecifiedTests -r $(cat ./testclass/testclass.txt)) > ./DEPLOY_ORG.txt
#fi