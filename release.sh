#!/bin/bash
# 새 버전 올리기: 서비스워커 캐시 번호 · 앱 버전 · 빌드 시각 · version.json 을 한꺼번에 올린다
set -e
cd "$(dirname "$0")"
cur=$(sed -n 's/.*walkie-v\([0-9]\{1,\}\).*/\1/p' sw.js | head -1)
next=$((cur+1))
built=$(TZ=Asia/Seoul date '+%Y-%m-%d %H:%M')
sed -i "s/walkie-v$cur/walkie-v$next/" sw.js
sed -i "s/var APPV = \"$cur\"/var APPV = \"$next\"/" index.html
sed -i "s/var BUILT = \"[^\"]*\"/var BUILT = \"$built\"/" index.html
printf '{"v": "%s", "built": "%s"}' "$next" "$built" > version.json
cp index.html next.html
echo "버전 $cur → $next ($built)"
