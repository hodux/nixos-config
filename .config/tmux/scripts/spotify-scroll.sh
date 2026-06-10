#!/usr/bin/env bash

text=$(playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}' 2>/dev/null)

[ -z "$text" ] && exit 0

width=25
padding="     "
marquee="${text}${padding}"

len=${#marquee}
offset=$(( $(date +%s) % len ))

output="${marquee:$offset}${marquee:0:$offset}"
printf "%s" "${output:0:$width}"
