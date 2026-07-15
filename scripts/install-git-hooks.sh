#!/bin/sh
# Enable the EVE NeuroSystems LLC authorship-guard git hooks for THIS clone/worktree.
# core.hooksPath is per-clone local config (NOT cloned), so every fresh clone/worktree
# must run this once:   sh scripts/install-git-hooks.sh
set -e
git config core.hooksPath .githooks
chmod +x .githooks/* 2>/dev/null || true
git config user.name  "Jamaurice Holt"
git config user.email "admin@eveaicore.com"
echo "EVE authorship guard enabled: core.hooksPath=.githooks, identity=Jamaurice Holt <admin@eveaicore.com>"
