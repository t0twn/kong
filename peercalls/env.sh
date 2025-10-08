REALM=`find .. -name REALM -exec cat {} \;` || { echo REALM NOT set; exit 1; }
STATIC_AUTH_SECRET=`find .. -name STATIC_AUTH_SECRET -exec cat {} \;` || { echo STATIC_AUTH_SECRET NOT set; exit 1; }
export PEERCALLS_ICE_SERVER_SECRET=$STATIC_AUTH_SECRET
export PEERCALLS_ICE_SERVER_URLS=turn:$REALM:3478?transport=udp
