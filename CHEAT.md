# fzf

| Example                                   | Description                                      |
| ----------------------------------------- | ------------------------------------------------ |
| CTRL-t                                    | Look for files and directories                   |
| CTRL-r                                    | Look through command history                     |
| Enter                                     | Select the item                                  |
| Ctrl-j or Ctrl-n or Down arrow            | Go down one result                               |
| Ctrl-k or Ctrl-p or Up arrow              | Go up one result                                 |
| Tab                                       | Mark a result                                    |
| Shift-Tab                                 | Unmark a result                                  |
| cd \*\*Tab                                | Open up fzf to find directory                    |
| export \*\*Tab                            | Look for env variable to export                  |
| unset \*\*Tab                             | Look for env variable to unset                   |
| unalias \*\*Tab                           | Look for alias to unalias                        |
| ssh \*\*Tab                               | Look for recently visited host names             |
| kill -9 \*\*Tab                           | Look for process name to kill to get pid         |
| any command (like nvim or code) + \*\*Tab | Look for files & directories to complete command |

# fzf-git

| Keybind | Description                         |
| ------- | ----------------------------------- |
| CTRL-GF | Look for git files with fzf         |
| CTRL-GB | Look for git branches with fzf      |
| CTRL-GT | Look for git tags with fzf          |
| CTRL-GR | Look for git remotes with fzf       |
| CTRL-GH | Look for git commit hashes with fzf |
| CTRL-GS | Look for git stashes with fzf       |
| CTRL-GL | Look for git reflogs with fzf       |
| CTRL-GW | Look for git worktrees with fzf     |
| CTRL-GE | Look for git for-each-ref with fzf  |

# Tmux Cheat Sheet

## Prefix Key

| Action | Key                                    |
| ------ | -------------------------------------- |
| Prefix | `Ctrl-a` (instead of default `Ctrl-b`) |

---

## Pane Management

### Split Panes

| Action             | Key               |
| ------------------ | ----------------- | --- |
| Split vertically   | `Ctrl-a` then `   | `   |
| Split horizontally | `Ctrl-a` then `-` |

### Resize Panes

| Action       | Key               |
| ------------ | ----------------- |
| Resize left  | `Ctrl-a` then `h` |
| Resize right | `Ctrl-a` then `l` |
| Resize up    | `Ctrl-a` then `k` |
| Resize down  | `Ctrl-a` then `j` |

### Maximize/Minimize Pane

| Action      | Key               |
| ----------- | ----------------- |
| Toggle zoom | `Ctrl-a` then `m` |

---

## Pane Navigation (With Vim Navigator Plugin)

| Action     | Key      |
| ---------- | -------- |
| Move left  | `Ctrl-h` |
| Move right | `Ctrl-l` |
| Move up    | `Ctrl-k` |
| Move down  | `Ctrl-j` |

---

## Mouse Support

| Feature    | Behavior                                    |
| ---------- | ------------------------------------------- |
| Mouse mode | Enabled (`click`, `resize`, `scroll`, etc.) |

---

## Copy Mode (Vim Style)

| Action               | Key                                |
| -------------------- | ---------------------------------- |
| Enter copy mode      | `Ctrl-a` then `[`                  |
| Move in copy mode    | `h`, `j`, `k`, `l`                 |
| Start selection      | `v`                                |
| Copy selection       | `y`                                |
| Mouse drag to select | Supported (doesn't exit copy mode) |

---

## Config Reload

| Action             | Key               |
| ------------------ | ----------------- |
| Reload tmux config | `Ctrl-a` then `r` |

---

## Theme

| Plugin | Value                    |
| ------ | ------------------------ |
| Theme  | `powerline/default/cyan` |

---

## TPM (Tmux Plugin Manager)

| Action               | Key                   |
| -------------------- | --------------------- |
| Install plugins      | `Ctrl-a` then `I`     |
| Update plugins       | `Ctrl-a` then `U`     |
| Remove unused plugin | `Ctrl-a` then `Alt-u` |

---

## Session Persistence

### Tmux Resurrect

| Action          | Key                    |
| --------------- | ---------------------- |
| Save session    | `Ctrl-a` then `Ctrl-s` |
| Restore session | `Ctrl-a` then `Ctrl-r` |

### Tmux Continuum

| Feature      | Behavior         |
| ------------ | ---------------- |
| Auto-save    | Every 15 minutes |
| Auto-restore | On tmux start    |

