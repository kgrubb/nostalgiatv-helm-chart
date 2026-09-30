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
| `timezone` | `TZ` | `America/New_York` |
| `hdhr.enabled` | HDHR / IPTV tuner | `true` |
| `persistence.size` | PVC size for data+config+logos | `10Gi` |
| `ingress.enabled` | Expose Watch / Configure UI | `false` |
