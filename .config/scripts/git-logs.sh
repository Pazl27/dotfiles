#!/usr/bin/env bash
# Search git log with fzf and preview commits with delta

# Exit if not in a git repo
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "fzf-git-log: Not in a git repository." >&2
  exit 1
fi

# Default git log format
fzf_git_log_format='%C(bold blue)%h%C(reset) - %C(cyan)%ad%C(reset) %C(yellow)%d%C(reset) %C(normal)%s%C(reset)  %C(dim normal)[%an]%C(reset)'

# Preview command — use delta if available, otherwise fallback to plain git show
if command -v delta >/dev/null 2>&1; then
  preview_cmd='git show --color=always --stat --patch {1} | delta'
else
  preview_cmd='git show --color=always --stat --patch {1}'
fi

# Run fzf
selected=$(git log --no-show-signature --color=always \
  --format="format:$fzf_git_log_format" --date=short |
  fzf --ansi \
      --multi \
      --scheme=history \
      --prompt="Git Log> " \
      --preview="$preview_cmd" \
      $FZF_GIT_LOG_OPTS)

# If something was selected
if [[ -n "$selected" ]]; then
  commit_hashes=()
  while IFS= read -r line; do
    abbrev_hash=$(awk '{print $1}' <<<"$line")
    full_hash=$(git rev-parse "$abbrev_hash")
    commit_hashes+=("$full_hash")
  done <<< "$selected"

  # Print commit hashes (space-separated)
  printf '%s ' "${commit_hashes[@]}"
  echo
fi

