![bash_unit CI](https://github.com/pforret/photobackup/workflows/bash_unit%20CI/badge.svg)
![Shellcheck CI](https://github.com/pforret/photobackup/workflows/Shellcheck%20CI/badge.svg)
![GH Language](https://img.shields.io/github/languages/top/pforret/photobackup)
![GH stars](https://img.shields.io/github/stars/pforret/photobackup)
![GH tag](https://img.shields.io/github/v/tag/pforret/photobackup)
![GH License](https://img.shields.io/github/license/pforret/photobackup)
[![basher install](https://img.shields.io/badge/basher-install-white?logo=gnu-bash&style=flat)](https://basher.gitparade.com/package/)

# photobackup

Backup photos to NAS

## 🔥 Usage
```
Program: photobackup 0.1.0 by peter@forret.com
Updated: Feb 25 15:48:16 2021
Description: Backup photos to NAS
Usage: photobackup [-h] [-q] [-v] [-f] [-l <log_dir>] [-t <tmp_dir>] <action> <source?> <destin?>
    Flags, options and parameters:
    -h|--help        : [flag] show usage [default: off]
    -q|--quiet       : [flag] no output [default: off]
    -v|--verbose     : [flag] output more [default: off]
    -f|--force       : [flag] do not ask for confirmation (always yes) [default: off]
    -l|--log_dir <?> : [option] folder for log files   [default: /Users/pforret/log/photobackup]
    -t|--tmp_dir <?> : [option] folder for temp files  [default: .tmp]
    <action>         : [parameter] action to perform: backup/check
    <source>         : [parameter] source folder (optional)
    <destin>         : [parameter] destination folder (optional)
```

## 🚀 Installation

with [basher](https://github.com/basherpm/basher)

	$ basher install pforret/photobackup

or with `git`

	$ git clone https://github.com/pforret/photobackup.git
	$ cd photobackup

## 📝 Acknowledgements

* script created with [bashew](https://github.com/pforret/bashew)

&copy; 2021 Peter Forret
