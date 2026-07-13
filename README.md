# Spigot.conf

Phate Minecraft Server Spigot configurations.

## Layout

- **`default/`** — the pristine config files a *freshly initialised* Paper server
  produces for the version currently in use. Its git history is the change track
  of vanilla defaults across Minecraft/Paper versions.
- **top level** (`bukkit.yml`, `spigot.yml`, `server.properties`, `config/…`, …)
  — the configs this server actually runs, i.e. the customised versions. Their
  git history is the change track of this server's own settings.

See what this server changes relative to vanilla:

```sh
diff -u default/spigot.yml spigot.yml
```

## Regenerating `default/`

`default/` is refreshed whenever the server's Paper version changes: a throwaway,
resource-capped run of the current paper jar boots once in an empty directory,
captures the generated defaults, and stops before world generation (the real
`../server` is only read, never modified). `server.properties`/`eula.txt`
timestamp headers are stripped and the `rcon.password` / `management-server-secret`
keys are blanked, so `default/` diffs stay meaningful and never carry secrets.

## Privacy

Player-identifying data is never published: `banned-*.json`, `ops.json`,
`whitelist.json` are kept empty, and secrets in `server.properties` are cleared.
