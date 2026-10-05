#!/usr/bin/env bash
set -euo pipefail

chart="charts/nostalgiatv/Chart.yaml"
values="charts/nostalgiatv/values.yaml"
readme="charts/nostalgiatv/README.md"
repo="purestream711/nostalgiatv-server"
tag_re='^[0-9]+\.[0-9]+\.[0-9]+-[0-9]{8}-[0-9]{4}$'

current=$(awk '/^appVersion:/ { gsub(/"/, "", $2); print $2 }' "$chart")

latest=""
url="https://hub.docker.com/v2/repositories/${repo}/tags?page_size=100&ordering=last_updated"
while [[ -n "$url" ]]; do
  page=$(curl -fsSL "$url")
  page_latest=$(jq -r --arg re "$tag_re" '.results[].name | select(test($re))' <<<"$page" | sort -V | tail -1)
  if [[ -n "$page_latest" ]]; then
    latest="$page_latest"
    break
  fi
  url=$(jq -r '.next // empty' <<<"$page")
done

[[ -n "$latest" ]] || { echo "No dated tags found for ${repo}" >&2; exit 1; }
[[ "$(printf '%s\n%s\n' "$current" "$latest" | sort -V | tail -1)" != "$current" ]] || exit 0

IFS='.' read -r cur_maj cur_min _ <<<"${current%%-*}"
IFS='.' read -r new_maj new_min _ <<<"${latest%%-*}"

if ((new_maj > cur_maj)); then
  prefix="feat!(image)"
elif ((new_min > cur_min)); then
  prefix="feat(image)"
else
  prefix="fix(image)"
fi

subject="${prefix}: bump NostalgiaTV app image to ${latest}"
sed -i "s/^appVersion: .*/appVersion: \"${latest}\"/" "$chart"
sed -i "s|${repo}:${current}|${repo}:${latest}|" "$chart"
sed -i "s|^  tag: .*|  tag: \"${latest}\"|" "$values"
sed -i "s/\`${current}\`/\`${latest}\`/g" "$readme"

if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  {
    echo "upgraded=true"
    echo "nostalgiatv_version=${latest}"
    echo "commit_subject=${subject}"
  } >>"$GITHUB_OUTPUT"
fi
