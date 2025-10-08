
test -d env || mkdir env; cd env;
test -z $REALM && { echo REALM NOT set; exit 1; }

export REALM
export STATIC_AUTH_SECRET=${STATIC_AUTH_SECRET:-$(test -f STATIC_AUTH_SECRET && cat STATIC_AUTH_SECRET || uuidgen | tee STATIC_AUTH_SECRET)}
export EXTERNAL_IP=${EXTERNAL_IP:-$(test -f EXTERNAL_IP && cat EXTERNAL_IP || curl ipinfo.io | jq -r .ip | tee EXTERNAL_IP)}
