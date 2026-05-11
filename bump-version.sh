#!/bin/bash

set -e

PUBSPEC="pubspec.yaml"

current=$(grep '^version:' "$PUBSPEC" | sed 's/version: //')
semver="${current%+*}"
build="${current#*+}"

new_version="${semver}+$((build + 1))"

sed -i '' "s/^version: .*/version: $new_version/" "$PUBSPEC"

echo "Version bumped: $current → $new_version"
