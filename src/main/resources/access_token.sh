#!/bin/bash

dirn=$(dirname $0)

#GRANT_TYPE="implicit"
GRANT_TYPE="client_credentials"

CLIENT_ID="typesrepo"
SECRET="Tyc5kF0FDtxrvqlsrA2DKMExvUyWDspvtJnaf9rBGpeYofI1MuI_JL4rXaBulSZQuRNSzozo9pexelrhiDDVDg"
#CLIENT_ID="monitoring"
#SECRET="AKD1lodQMxQul1uJ7LPYuYfg1kavwbTNy3y0eXopRcbheK_Z3vxpPPSNMyLZpN-sNP-goopkawJAKnQ70ikKvqg"


SERVER_PORT="8080"
TOKEN_ENDPOINT="http://localhost:$SERVER_PORT/metaisiam/token"

DATA="grant_type=$GRANT_TYPE&client_id=$CLIENT_ID&client_secret=$SECRET"
URL="$TOKEN_ENDPOINT"



if [ "$1" = "--silent" ]; then
	REFRESH_TOKEN=$(curl --silent -X POST -d "$DATA" -H "Content-Type: application/x-www-form-urlencoded" "$URL")
	echo $REFRESH_TOKEN | jq '.access_token' | cut -f 2 -d \"
else
	REFRESH_TOKEN=$(curl -v -X POST -d "$DATA" -H "Content-Type: application/x-www-form-urlencoded" "$URL")
	if [ "$1" = "--pretty" ]; then
		echo $REFRESH_TOKEN | jq '.'
	else
		echo $REFRESH_TOKEN
	fi
fi
exit 0
