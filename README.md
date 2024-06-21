# aws-s3.nvim

[![Luacheck](https://img.shields.io/github/actions/workflow/status/oguzhancoskun/aws-s3.nvim/luacheck.yml?branch=main&label=Luacheck&logo=Lua)](https://github.com/oguzhancoskun/aws-s3.nvim/actions?workflow=Luacheck)
![language](https://img.shields.io/badge/language-lua-yellow)
![version](https://img.shields.io/badge/version-0.1.0-blue)
![author](https://img.shields.io/badge/author-oguzhancoskun-blue)
![neovim](https://img.shields.io/badge/neovim-0.5%2B-green)
![license](https://img.shields.io/github/license/oguzhancoskun/aws-s3.nvim)
![GitHub stars](https://img.shields.io/github/stars/oguzhancoskun/aws-s3.nvim)

`aws-s3.nvim` is a Lua module for NeoVim or Vim that facilitates the use of
AWS S3 services. It allows you to create new object or update existing object.

## Requirements

- [aws-cli](https://aws.amazon.com/cli/)
- [fidget](https://github.com/j-hui/fidget.nvim) (optional)

## Installation

### Using vim-plug

```vim
Plug 'oguzhancoskun/aws-s3.nvim'
```

## Configuration

```lua
requre('aws-s3').setup{
  fidget = true, -- if you want to see the outputs on fidget
}
```

## Commands

- `:S3Create` - Add object to AWS S3
- `:S3Update` - Update object in AWS S3

## Features

- [x] Add object to AWS S3
- [x] Update object in AWS S3


