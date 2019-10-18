#!/bin/bash
#Define Console Output Color
RED='\033[0;31m'    # For error
GREEN='\033[0;32m'  # For crucial check success
NC='\033[0m'        # No color, back to normal

helmClientVer="$(helm version --client | egrep -o "([0-9]{1,}\.)+[0-9]{1,}")"
helmServerVer="$(helm version --server | egrep -o "([0-9]{1,}\.)+[0-9]{1,}")"

echo -e "Helm is client version is ${helmClientVer}"
echo -e "Helm is server version is ${helmServerVer}"

if [ $helmClientVer != $helmServerVer ]; then
    echo -e "${RED}Helm client and server versions do not match${NC}"
    echo -e "Downgrading client Helm version..."
    curl -LO https://git.io/get_helm.sh
    chmod 700 get_helm.sh
    ./get_helm.sh -v "v${helmServerVer}"
    helm version --client
    rm -f -v get_helm.sh
else
    echo -e "${GREEN}Helm client and server versions match!${NC}"
fi
