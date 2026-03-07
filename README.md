# P6's POSIX.2: p6df-azure

## Table of Contents

- [Badges](#badges)
- [Summary](#summary)
- [Contributing](#contributing)
- [Code of Conduct](#code-of-conduct)
- [Usage](#usage)
  - [Functions](#functions)
- [Hierarchy](#hierarchy)
- [Author](#author)

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## Summary

p6df module for Microsoft Azure: CLI tools (`azure-cli`), extensions, prompt
integration, and MCP server (`@azure/mcp` via npm) for AI-driven Azure
resource and subscription management.

## Contributing

- [How to Contribute](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Functions

#### p6df-azure

##### p6df-azure/init.zsh

- `p6df::modules::azure::completions::init(_module, dir)`
  - Args:
    - _module
    - dir
- `p6df::modules::azure::deps()`
- `p6df::modules::azure::external::brew()`
- `p6df::modules::azure::home::symlink()`
- `p6df::modules::azure::langs()`
- `p6df::modules::azure::mcp()`
- `str str = p6df::modules::azure::prompt::mod()`

## Hierarchy

```text
.
├── init.zsh
└── README.md

1 directory, 2 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>
