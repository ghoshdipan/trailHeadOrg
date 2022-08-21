cat scripts/cklogo.txt
echo y | sfdx plugins:install @salesforce/sfdx-scanner
sfdx scanner --help
sfdx scanner:run --format table --target force-app/main --normalize-severity -c "Security,Best Practices,Performance,Code Style,Design,Error Prone,ECMAScript 6,Possible Errors,Variables,Stylistic Issues"