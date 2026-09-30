# nostalgiatv

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/nostalgiatv-helm)](https://artifacthub.io/packages/search?repo=nostalgiatv-helm)
[![CI](https://github.com/kgrubb/nostalgiatv-helm-chart/actions/workflows/ci.yml/badge.svg)](https://github.com/kgrubb/nostalgiatv-helm-chart/actions/workflows/ci.yml)

Helm chart for the [NostalgiaTV Server](https://hub.docker.com/r/purestream711/nostalgiatv-server)
companion. It generates shared schedules for the Android / Android TV app (Docker Mode),
indexes Jellyfin / Plex / Emby, and can expose HDHomeRun / M3U / XMLTV endpoints.

## Install

```bash
helm repo add kgrubb-nostalgiatv https://kgrubb.github.io/nostalgiatv-helm-chart
helm repo update
helm install nostalgiatv kgrubb-nostalgiatv/nostalgiatv -n nostalgiatv --create-namespace
```

Chart index: https://kgrubb.github.io/nostalgiatv-helm-chart/

Published charts are signed with the [public key](https://kgrubb.github.io/nostalgiatv-helm-chart/public.key) on gh-pages.

## First install

1. Open the Watch UI (`/`) and sign in with Jellyfin, Plex, or Emby.
2. Pick libraries and let indexing finish.
3. On each Android TV: Settings → Admin → Docker Mode → enter the server URL.
4. Configure channels and schedules under `/configure`.

Point the in-app media server at your library host. For in-cluster Jellyfin use the
cluster DNS name (for example `http://jellyfin.jellyfin.svc.cluster.local:8096`).

## HDHR / IPTV

When `hdhr.enabled` is true (default):

- Tuner: `http://<host>:19850`
- M3U: `http://<host>:19850/channels.m3u`
- XMLTV: `http://<host>:19850/xmltv.xml`

Those endpoints are intentionally unauthenticated. Prefer LAN exposure or a
dedicated LoadBalancer if you use them from other apps.

## Releases

Pushes to `main` that change `charts/` bump the chart version from conventional
commits (`feat:` minor, breaking major, otherwise patch), publish with
[chart-releaser](https://github.com/helm/chart-releaser-action), and host
`index.yaml` plus packages on `gh-pages`.

### Secrets and GitHub Pages

Signed releases need the repository secret `GPG_PRIVATE_KEY`. Copy the same value
from [stalwart-helm-chart](https://github.com/kgrubb/stalwart-helm-chart) settings
(Actions secrets) so packages verify against the public key on gh-pages.

GitHub Pages for the Helm repo is served from the `gh-pages` branch. Chart-releaser
creates and updates that branch on the first successful release. After that first
publish, confirm Pages is set to Deploy from branch → `gh-pages` / root if it is
not already.

## Development

```bash
helm lint charts/nostalgiatv --strict
helm template test charts/nostalgiatv
```
