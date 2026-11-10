#!/bin/bash

verifica_ip() {

    local nume="$1"
    local ip="$2"
    local dns="$3"

    rezultat=$(nslookup "$nume" "$dns" | awk '/^Name:/ {found=1; next} found && /^Address:/ {print $2}')

    if ! echo "$rezultat" | grep -Fxq "$ip"; then
        echo "Bogus IP: $ip pentru hostul $nume"
    else
        echo "Valid IP: $ip pentru hostul $nume"
    fi
}

# Serverul DNS este transmis ca argument scriptului
dns="$1"

if [[ -z "$dns" ]]; then
    echo "Utilizare: $0 DNS_SERVER"
    exit 1
fi

cat /etc/hosts | while read ip nume; do

    if [[ "$ip" == \#* || -z "$ip" ]]; then
        continue
    fi

    verifica_ip "$nume" "$ip" "$dns"

done
