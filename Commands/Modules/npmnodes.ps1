function Invoke-InstallNpmModules{
cls
write-host "Updating npm"
. npm cache clear
. npm cache clean
. npm update npm -g

write-host "nodejs version"
. node --version 

write-host "Installing/Updating npm modules"

. npm install -g karma 
. npm cache clear
. npm install -g karma-jasmine 
. npm install -g karma-ng-html2js-preprocessor 
. npm install -g karma-ng-scenario 
. npm install -g karma-cli karma-coverage
. npm cache clear
. npm install -g karma-chrome-launcher 
. npm install -g karma-ie-launcher 
. npm install -g karma-safari-launcher 
. npm install -g karma-opera-launcher 
. npm install -g karma-firefox-launcher 
. npm cache clear
. npm install -g yo 
. npm cache clear
. npm install -g grunt-cli bower
. npm cache clear
. npm install -g generator-webapp
. npm cache clear
. npm install -g express
. npm install -g jade
. npm cache clear
. npm install -g meanio
. npm install -g generator-angular 
. npm install -g generator-keystone
. npm install -g generator-meanjs
. npm cache clear
. npm install -g node-sass
. npm cache clear
#https://github.com/DaftMonk/generator-angular-fullstack
#yo angular-fullstack
. npm install -g generator-angular-fullstack

write-host ""
write-host "-----------------------------------------------"
write-host ""
write-host "Installing/Updating Ruby"
. gem update --system
. gem install compass
}