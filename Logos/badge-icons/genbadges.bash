#!/usr/bin/env bash

REPO=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function logo () {
    echo -n 'data%3Aimage%2Fsvg%2Bxml%3Bbase64%2C'
    basenc --base64 --wrap=0 "${REPO}/logo-${1}.svg" | sed -E -e 's/\+/%2B/g' -e 's/=/%3D/g'
}

curl -o "${REPO}/../../static/images/discordchat.svg" \
     "https://img.shields.io/discord/431917998102675485?style=plastic&color=%238f8fff&logo=$(logo discord)"

curl -o "${REPO}/../../static/images/mitlicense.svg" \
     "https://img.shields.io/badge/license-MIT-skyblue?style=plastic&logo=$(logo mitlicense)"

curl -o "${REPO}/../../static/images/readthedocs.svg" \
     "https://img.shields.io/badge/read_the-docs-2196f3?style=plastic&labelColor=gray&logo=$(logo readthedocs)"

curl -o "${REPO}/../../static/images/swift57up.svg" \
     "https://img.shields.io/badge/swift-5.7%2B-white?style=plastic&logoColor=%23f07158&labelColor=gray&color=%23f07158&logo=$(logo swift57up)"

curl -o "${REPO}/../../static/images/sswg-graduated.svg" \
     "https://img.shields.io/badge/sswg-graduated-white?style=plastic&labelColor=gray&color=%23e01595&logo=$(logo sswg)"

curl -o "${REPO}/../../static/images/sswg-incubating.svg" \
     "https://img.shields.io/badge/sswg-incubating-white?style=plastic&labelColor=gray&color=%23f8c5e6&logo=$(logo sswg)"

curl -o "${REPO}/../../static/images/sswg-sandbox.svg" \
     "https://img.shields.io/badge/sswg-sandbox-white?style=plastic&labelColor=gray&color=%23fff2fa&logo=$(logo sswg)"
