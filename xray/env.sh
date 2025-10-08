test -d env || mkdir env; cd env;
test -z $xray_reality_target && { echo xray_reality_target NOT set; exit 1; }

export xray_reality_target
export xray_serveraddr=${xray_serveraddr:-$(test -f xray_serveraddr && cat xray_serveraddr || curl ipinfo.io | jq -r .ip | tee xray_serveraddr)}
export xray_xhttp_path=${xray_xhttp_path:-$(test -f xray_xhttp_path && cat xray_xhttp_path || uuidgen | tee xray_xhttp_path)}
export xray_clientid=${xray_clientid:-$(test -f xray_clientid && cat xray_clientid || uuidgen | tee xray_clientid)}
export xray_privatekey=${xray_privatekey:-$(test -f xray_privatekey && cat xray_privatekey || docker run --rm ghcr.io/xtls/xray-core:latest x25519 | grep PrivateKey | awk '{print $NF}' | tee xray_privatekey)}
export xray_publickey=${xray_publickey:-$(test -f xray_publickey && cat xray_publickey || docker run --rm ghcr.io/xtls/xray-core:latest x25519 -i $xray_privatekey | grep Password | awk '{print $NF}' | tee xray_publickey)}

# xhttp-reality
sed -i "s/\$xray_reality_target/$xray_reality_target/g" ../etc/xhttp-reality-server.jsonc
sed -i "s/\$xray_xhttp_path/$xray_xhttp_path/" ../etc/xhttp-reality-server.jsonc
sed -i "s/\$xray_clientid/$xray_clientid/" ../etc/xhttp-reality-server.jsonc
sed -i "s/\$xray_privatekey/$xray_privatekey/" ../etc/xhttp-reality-server.jsonc

sed -i "s/\$xray_serveraddr/$xray_serveraddr/g" ../etc/xhttp-reality-client
sed -i "s/\$xray_reality_target/$xray_reality_target/" ../etc/xhttp-reality-client
sed -i "s/\$xray_xhttp_path/$xray_xhttp_path/" ../etc/xhttp-reality-client
sed -i "s/\$xray_clientid/$xray_clientid/" ../etc/xhttp-reality-client
sed -i "s/\$xray_publickey/$xray_publickey/" ../etc/xhttp-reality-client

# xtls-vision-reality
sed -i "s/\$xray_reality_target/$xray_reality_target/g" ../etc/xtls-vision-reality-server
sed -i "s/\$xray_clientid/$xray_clientid/" ../etc/xtls-vision-reality-server
sed -i "s/\$xray_privatekey/$xray_privatekey/" ../etc/xtls-vision-reality-server

sed -i "s/\$xray_serveraddr/$xray_serveraddr/g" ../etc/xtls-vision-reality-client
sed -i "s/\$xray_reality_target/$xray_reality_target/" ../etc/xtls-vision-reality-client
sed -i "s/\$xray_clientid/$xray_clientid/" ../etc/xtls-vision-reality-client
sed -i "s/\$xray_publickey/$xray_publickey/" ../etc/xtls-vision-reality-client
