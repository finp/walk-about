INSTALL_TAG=release-1.2.0

curl https://raw.githubusercontent.com/integr8ly/installation/$INSTALL_TAG/evals/inventories/group_vars/all/manifest.yaml >manifest.temp


yq . manifest.temp > manifest.yaml

WEBAPP_TAG=`yq . manifest.yaml| jq .webapp_version| sed -e 's/^"//' -e 's/"$//'`

echo $WEBAPP_TAG

curl https://raw.githubusercontent.com/integr8ly/tutorial-web-app/v$WEBAPP_TAG/src/product-info.js >product-info.js

WEBAPPOP_TAG=`yq . manifest.yaml| jq .webapp_operator_release_tag| sed -e 's/^"//' -e 's/"$//'`

curl https://raw.githubusercontent.com/integr8ly/tutorial-web-app-operator/$WEBAPPOP_TAG/pkg/handlers/webhandler.go |grep WTLocationsDefault >WTLocationsDefault.txt


./asciidoc-coalescer.rb README.adoc > walkthroughs/walk-about/walkthrough.adoc
