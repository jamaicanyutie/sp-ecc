# Skill Sources & Attribution

Superpower-ECC merges curated skills from multiple MIT-licensed projects. Each
skill directory retains its upstream license and authorship in its SKILL.md
frontmatter where present. This file documents the sourcing for the skill sets
merged into `skills/`.

| Skill set | Source | License | Notes |
|-----------|--------|---------|-------|
| `docker-core-*`, `docker-syntax-*`, `docker-impl-*`, `docker-errors-*`, `docker-agents-*`, `docker-buildkit` | [todi975/Docker-Claude-Skill-Package](https://github.com/todi975/Docker-Claude-Skill-Package) | MIT | Preserved verbatim from `skills/source/` |
| `docker-installation`, `docker-configuration`, `docker-registry`, `docker-single-host`, `docker-swarm`, `docker-health-check`, `docker-upgrades`, `docker-backup-restore`, `docker-troubleshooting`, `docker-cli-reference`, `docker-known-issues`, `docker-compatibility`, `docker-decision-guides` | [agentic-stacks/docker](https://github.com/agentic-stacks/docker) | MIT | Original `README.md` files converted to `SKILL.md` with frontmatter; content unmodified |
| `git-advanced-workflows` | [wshobson/agents · developer-essentials](https://github.com/wshobson/agents) | MIT | `SKILL.md` + `references/details.md` |
| `github-actions-hardened` | [arash77/github-actions-skill](https://github.com/arash77/github-actions-skill) | MIT | `SKILL.md` + `references/` |
| `playwright-skill` | [testdino-hq/playwright-skill](https://github.com/testdino-hq/playwright-skill) | MIT | Full tree preserved (SKILL.md + `core/`, `ci/`, `playwright-cli/`, `migration/`, `pom/`, LICENSE) |
| `binlog-*`, `build-*`, `check-bin-obj-clash`, `copy-to-output-directory`, `directory-build-organization`, `eval-performance`, `extension-points`, `including-generated-files`, `incremental-build`, `item-management`, `msbuild-*`, `property-patterns`, `resolve-project-references`, `target-authoring` | [dotnet/skills · dotnet-msbuild](https://github.com/dotnet/skills) | MIT | Microsoft .NET Skills; merged from `plugins/dotnet-msbuild/skills/` |

## Conflicts resolved

Where `todi975` and `agentic-stacks` both covered a Docker topic (architecture,
Dockerfile authoring, Compose, build optimization, production deploy,
networking, storage, security), the `todi975` version was kept and the
`agentic-stacks` one was dropped to avoid duplication:

- `agentic-stacks` `concepts` → `docker-core-architecture`
- `agentic-stacks` `dockerfile` → `docker-syntax-dockerfile`
- `agentic-stacks` `compose` → `docker-syntax-compose-services` / `docker-syntax-compose-resources`
- `agentic-stacks` `build-optimization` → `docker-impl-build-optimization`
- `agentic-stacks` `production` → `docker-impl-production`
- `agentic-stacks` `networking` → `docker-core-networking`
- `agentic-stacks` `storage` → `docker-impl-storage`
- `agentic-stacks` `security` → `docker-core-security`