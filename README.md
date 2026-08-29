# dotfiles

Managed with [dotbare](https://github.com/kazhala/dotbare) (git bare repository).

## Restore on a new machine

```sh
# install dotbare, then:
dotbare finit -u git@github.com:Mnichus3142/dotfiles.git -y
```

## Daily use

```sh
dotbare fadd -f              # stage files interactively
dotbare add PATH             # stage a specific file or directory
dotbare commit -m "message"
dotbare push
dotbare status
```

The bare repo lives in `~/.cfg` and tracks `$HOME`. Untracked files are hidden by default (`status.showUntrackedFiles=no`), so only explicitly added paths are versioned.
