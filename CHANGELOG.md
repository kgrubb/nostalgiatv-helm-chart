# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.14] - 2026-10-27

### Fixed
- bump NostalgiaTV app image to 0.10.36-20261027-0039



## [0.3.13] - 2026-10-26

### Fixed
- bump NostalgiaTV app image to 0.10.35-20261025-1844



## [0.3.12] - 2026-10-24

### Fixed
- bump NostalgiaTV app image to 0.10.33-20261023-1717



## [0.3.11] - 2026-10-20

### Fixed
- bump NostalgiaTV app image to 0.10.31-20261019-1317



## [0.3.10] - 2026-10-19

### Fixed
- bump NostalgiaTV app image to 0.10.30-20261018-2349



## [0.3.9] - 2026-10-18

### Fixed
- bump NostalgiaTV app image to 0.10.29-20261017-2157



## [0.3.8] - 2026-10-17

### Fixed
- bump NostalgiaTV app image to 0.10.27-20261016-0330



## [0.3.7] - 2026-10-15

### Fixed
- bump NostalgiaTV app image to 0.10.26-20261015-0010



## [0.3.6] - 2026-10-13

### Fixed
- bump NostalgiaTV app image to 0.10.23-20261013-0105



## [0.3.5] - 2026-10-11

### Fixed
- bump NostalgiaTV app image to 0.10.22-20261010-1812



## [0.3.4] - 2026-10-05

### Fixed
- bump NostalgiaTV app image to 0.10.21-20261005-1347



## [0.3.3] - 2026-10-05

### Changed
- auto-upgrade image from Docker Hub ([#3](https://github.com/kgrubb/nostalgiatv-helm-chart/pull/3))
  - Daily cron (and `workflow_dispatch`) syncs the chart image pin from Docker Hub, same pattern as [stalwart-helm-chart](https://github.com/kgrubb/stalwart-helm-chart).
  - Upstream major/minor/patch maps to `feat!(image)` / `feat(image)` / `fix(image)` so `release.yml` bumps the chart version.
- auto-upgrade image from Docker Hub



## [0.3.2] - 2026-10-02

### Fixed
- verify Artifact Hub publisher and use app icon
- use valid Artifact Hub category



## [0.3.1] - 2026-09-30

### Fixed
- keep CHOWN/SETUID caps for upstream PUID entrypoint ([#2](https://github.com/kgrubb/nostalgiatv-helm-chart/pull/2))
  - Re-add CHOWN, FOWNER, SETUID, and SETGID after dropping ALL so the upstream entrypoint can chown volume mounts and drop to PUID.
  - Without these caps the container fails at startup when the chart hardens capabilities.
- keep CHOWN/SETUID caps for upstream PUID entrypoint



## [0.3.0] - 2026-09-30

### Added
- harden chart for general home-lab use ([#1](https://github.com/kgrubb/nostalgiatv-helm-chart/pull/1))
  - strict values schema (enums, required keys, no unknown top-level fields)
  - weather API key via Secret / existingSecret instead of plain env
  - fsGroup defaults to pgid so PUID/PGID stay in sync
  - dedicated ServiceAccount with automountServiceAccountToken false
  - startupProbe, extraVolumes/Mounts, optional NetworkPolicy and PDB
  - NOTES cover LoadBalancer / NodePort / Ingress and HDHR URLs
  - CI uses ci/values.yaml and renders LB + secret + network policy paths
- harden chart for general home-lab use



## [0.2.2] - 2026-09-30

### Changed
- drop maintainer-only GPG and Pages bootstrap notes



## [0.2.1] - 2026-09-30

### Fixed
- pin upstream image to versioned tag for kube-linter



## [0.2.0] - 2026-09-30

### Added
- support externalTrafficPolicy for MetalLB L2



## [0.1.1] - 2026-09-30

### Fixed
- bootstrap first chart release when no tags exist


