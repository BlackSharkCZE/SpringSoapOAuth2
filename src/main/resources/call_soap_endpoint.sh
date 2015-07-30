#!/bin/bash


PORT="9000"
END_POINT_URL="http://localhost:$PORT/ws"
CONTENT_TYPE="content-type: text/xml"
REQUEST="request.xml"
TMP_FILE="/tmp/output.xml"

ACCESS_TOKEN="eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJ0eXBlc3JlcG8iLCJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODA4MFwvbWV0YWlzaWFtXC8iLCJleHAiOjE0MzgyNTA5MDAsImlhdCI6MTQzODI0NzMwNCwianRpIjoiNTQ1NTkzMTgtODhkYy00YzEzLWEyZWEtMDNjNGYwYTg5YzlmIn0.u5Azhs86Yusld6bJf5_IDQbRfea8E75XVT8-ExKLxIshgj2pQ7epM3wHi17QfazY4EEJ3rdgV_2YJyEPRJX5DffhBTsns5q5DOQ_fVN-qxssAalUbfUq-eQDtgxB5Ur-xxvvKIk9-VaylwDZCVFC4Whxv3xe1asKV_5Sjfldc6I"

AUTHORIZATION="Authorization: Bearer $ACCESS_TOKEN"

if hash curl; then

	if [ -f "$TMP_FILE" ]; then
		rm "$TMP_FILE"
	fi


	CURL=$(whereis -b curl | awk '{print $2}')
	DIR_NAME=$(dirname "$0")
	if [ -f "$DIR_NAME/$REQUEST" ]; then
		echo "curl --header \"$AUTHORIZATION\" --header $CONTENT_TYPE -d @$REQUEST $END_POINT_URL"
		curl --header "$AUTHORIZATION" --header "$CONTENT_TYPE" -d @$REQUEST $END_POINT_URL
		#curl --verbose --header $CONTENT_TYPE -d @$REQUEST $END_POINT_URL > "$TMP_FILE"

		printf "\n"
		if [ -f "$TMP_FILE" ]; then
			if hash xmllint; then
				xmllint --format "$TMP_FILE"
			else
				cat "$TMP_FILE"
			fi
		fi


	else
		echo "$DIR_NAME/$REQUEST not found. Can not send SOAP request"
	fi
else
	echo "Aplikace curl neni nainstalovana. Nainstalujete curl nebo ho uvedte na PATH"
fi

exit 0
