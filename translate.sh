#!/bin/zsh
# access translate.google.com from terminal

help='translate <text> [[<source language>] <target language>]
if target missing, use DEFAULT_TARGET_LANG
if source missing, use auto'

DEFAULT_TARGET_LANG=es

if [[ $1 = -h || $1 = --help ]]
then
    echo "$help"
    exit
fi

if [ $3 ]; then
    source="$2"
    target="$3"
elif [ $2 ]; then
    source=auto
    target="$2"
else
    source=auto
    target="$DEFAULT_TARGET_LANG"
fi

result=$(curl -s -i --user-agent "" -d "sl=$source" -d "tl=$target" --data-urlencode "text=$1" https://translate.google.com)
encoding=$(awk '/Content-Type: .* charset=/ {sub(/^.*charset=["'\'']?/,""); sub(/[ "'\''].*$/,""); print}' <<<"$result")
#iconv -f $encoding <<<"$result" | awk 'BEGIN {RS="<div"};/<span[^>]* id=["'\'']?result_box["'\'']?/ {sub(/^.*id=["'\'']?result_box["'\'']?(>| [^>]*>)([ \n\t]*<[^>]*>)*/,"");sub(/<.*$/,"");print}' | html2text -utf8
red='\e[1;31m'
NC='\033[0m'
output=$(iconv -f $encoding <<<"$result" |  awk 'BEGIN {RS="</div>"};/<span[^>]* id=["'\'']?result_box["'\'']?/' | html2text -utf8)
echo -e "${red}${output}${NC}"
exit
