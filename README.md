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

TODO: Add a short summary of this module.

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
- `p6df::modules::azure::external::brews()`
- `p6df::modules::azure::home::symlinks()`
- `p6df::modules::azure::langs()`
- `p6df::modules::azure::mcp()`
- `str str = p6df::modules::azure::prompt::context()`

#### p6df-azure/lib

##### p6df-azure/lib/auth.sh

- `p6df::modules::azure::auth::login(email)`
  - Args:
    - email
- `str {token} = p6df::modules::azure::auth::sp::token(client_id, client_secret, tenant_id, scopes)`
  - Args:
    - client_id
    - client_secret
    - tenant_id
    - scopes
- `str {token} = p6df::modules::azure::oauth::token(email, scopes)`
  - Args:
    - email
    - scopes

## Hierarchy

```text
.
├── init.zsh
├── lib
│   └── auth.sh
└── README.md

2 directories, 3 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>
