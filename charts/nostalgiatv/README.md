# nostalgiatv

Helm chart for [NostalgiaTV Server](https://hub.docker.com/r/purestream711/nostalgiatv-server).

Deploys the companion Docker server that generates shared 30-day schedules for the
NostalgiaTV Android / Android TV app (Docker Mode), indexes Jellyfin / Plex / Emby
libraries, and optionally exposes an HDHomeRun / M3U / XMLTV tuner.

## Install

See the [repository README](https://github.com/kgrubb/nostalgiatv-helm-chart).

## Values

| Key | Description | Default |
| --- | --- | --- |
| `image.repository` | Container image | `purestream711/nostalgiatv-server` |
| `image.tag` | Image tag (empty = `appVersion`) | `0.10.15-20260930-0305` |
| `puid` / `pgid` | Process user/group after volume chown | `1000` |
| `podSecurityContext.fsGroup` | Volume group ownership (defaults to `pgid`) | unset |
| `timezone` | `TZ` | `America/New_York` |
| `hdhr.enabled` | HDHR / IPTV tuner | `true` |
| `weather.existingSecret` | Prefer this over `weather.apiKey` in GitOps | `""` |
| `service.type` | `ClusterIP`, `NodePort`, or `LoadBalancer` | `ClusterIP` |
| `service.externalTrafficPolicy` | Use `Local` with MetalLB L2 | `""` |
| `serviceAccount.automountServiceAccountToken` | Pod API token mount | `false` |
| `networkPolicy.enabled` | Optional NetworkPolicy | `false` |
| `persistence.size` | PVC size for data+config+logos | `10Gi` |
| `ingress.enabled` | Expose Watch / Configure UI | `false` |
