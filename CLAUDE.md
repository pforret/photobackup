# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**photobackup** is a bash-based photo backup utility that uses `rsync` to backup photos from source folders (typically SD cards or external drives) to a NAS destination, with visual progress feedback via `progressbar`.

## Architecture

### Two Script Versions

The project contains two implementations of the backup tool:

1. **photobackup.sh** (v0.2.1) - Legacy version based on bashew 1.15.0
   - Older function naming (e.g., `out()`, `debug()`, `die()`)
   - Uses flags: `-s` (source), `-d` (destination), `-v` (verbose), `-q` (quiet)

2. **phackup.sh** (v0.3.1+) - Modern version based on bashew 1.22.0
   - Namespaced functions (e.g., `IO:print()`, `IO:debug()`, `IO:die()`, `Os:require()`, `Script:main()`)
   - Uses flags: `-S` (source), `-D` (destination), `-V` (verbose), `-Q` (quiet)
   - Better structured with `Option:config()`, `Script:main()`, `Script:initialize()`
   - This is the preferred/active version

### Helper Scripts

- **backup_macos_disks.sh** - Automation script that:
  - Scans all mounted disks for `Originals` folders
  - Runs `phackup.sh` for each found source
  - Uses `stdbuf -oL` to force line-buffered output from rsync

### Core Backup Mechanism

The backup uses `rsync` with these flags:
```bash
rsync --verbose --recursive --update --perms --times SOURCE/* DESTIN
```

Output is piped through `progressbar` for visual feedback:
```bash
stdbuf -oL rsync ... | tee "$tmp_file" | progressbar lines "$SOURCE"
```

**Key detail**: `stdbuf -oL` forces line buffering since rsync switches to block buffering when stdout is a pipe.

### Bashew Framework

Both scripts are built with the [bashew](https://github.com/pforret/bashew) framework which provides:
- Standardized CLI argument parsing
- Flag/option/parameter handling
- Logging and temp file management
- Environment variable support via `.env` files
- Error handling and cleanup on exit

## Development Commands

### Running Backups

```bash
# Modern version (preferred)
./phackup.sh -S /path/to/source/Originals -D /Volumes/photo/Originals backup

# Legacy version
./photobackup.sh -s /path/to/source/Originals -d /Volumes/photo/Originals backup

# Automated disk scanning
./backup_macos_disks.sh
```

### Configuration Check

```bash
./phackup.sh check           # Show current config values
./phackup.sh env > .env      # Generate example .env file
```

### Testing

```bash
cd tests
./run_tests.sh              # Run bash_unit tests
```

### Version Management

Version is stored in `VERSION.md` and managed by [pforret/setver](https://github.com/pforret/setver):
```bash
./phackup.sh update         # Update to latest git version
```

## Dependencies

Required binaries:
- `rsync` - Core backup tool
- `progressbar` - Install via: `basher install pforret/progressbar`
- `awk`, `grep`, `tee` - Standard Unix tools

## Key Implementation Notes

### Output Buffering

When piping rsync output:
- rsync uses block buffering by default when stdout is a pipe
- Use `stdbuf -oL` to force line-buffered output for real-time progress
- Alternative: `script -q /dev/null rsync ...` (creates pseudo-TTY)

### Script Structure (Modern Version)

1. `Option:config()` - Define CLI flags/options/parameters
2. `Script:main()` - Main entry point with action routing
3. Helper functions - Implement backup logic
4. Bashew library - Everything below "DO NOT MODIFY" comment

### Function Naming Conventions

Modern version uses namespace prefixes:
- `IO:*` - Input/Output functions (print, debug, log, die)
- `Os:*` - Operating system functions (require, folder, tempfile, beep)
- `Script:*` - Script lifecycle functions (main, check, exit, initialize)
- `Option:*` - CLI option parsing functions
- `Tool:*` - Utility functions (calc, time, round)
- `Str:*` - String processing functions
- `Gha:*` - GitHub Actions specific functions

## File Locations

- Scripts: Root directory (`*.sh`)
- Tests: `tests/` directory
- Version: `VERSION.md`
- Documentation: `README.md`, `CHANGELOG.md`, `CONTRIBUTING.md`