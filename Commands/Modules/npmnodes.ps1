function installAllModules{
cls
write-host "Updating npm"
. npm update npm -g

write-host "nodejs version"
. node --version 

write-host "Installing/Updating npm modules"

. npm install -g karma 
. npm install -g karma-jasmine karma-ng-html2js-preprocessor karma-ng-scenario karma-cli karma-coverage
. npm install -g karma-chrome-launcher karma-ie-launcher karma-safari-launcher karma-opera-launcher karma-firefox-launcher 
. npm install -g yo 
. npm install -g grunt-cli bower
. npm install -g generator-webapp
. npm install -g generator-angular
. npm install -g node-sass

write-host ""
write-host "-----------------------------------------------"
write-host ""
write-host "Installing/Updating Ruby"
. gem update --system
. gem install compass
}