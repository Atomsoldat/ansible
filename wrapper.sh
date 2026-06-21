#!/bin/bash
set -euo pipefail

usage() {
    cat <<EOF
Usage: $(basename "$0") [--machine-type private|work] <subcommand>

Subcommands:
  repos      Set up package repositories
  software   Install all desired software
  scripts    Install custom scripts
  config     Apply configuration
  storage    Set up NAS / storage mounts
  fonts      Install fonts
  home       Set up home directory (needs SSH key in agent)

Options:
  --machine-type TYPE   Bundle profile: private (default) or work
EOF
    exit 1
}

machine_type="private"

while [[ $# -gt 0 ]]; do
    case $1 in
        --machine-type) machine_type="$2"; shift 2 ;;
        -*) usage ;;
        *)  break ;;
    esac
done

[[ $# -eq 0 ]] && usage
subcommand="$1"

extra_args=()
case "$machine_type" in
    private) ;;
    work)    extra_args=(-e '{"software_bundles":["base","development","communication"]}') ;;
    *)       echo "Unknown machine type: $machine_type" >&2; exit 1 ;;
esac

run_playbook() {
    ansible-playbook "playbooks/$1" --ask-become-pass -i inventory.yaml "${extra_args[@]}"
}


# Here is where we start executing our playbook
case "$subcommand" in
    repos)    run_playbook repo_setup.yaml ;;
    software) run_playbook software_installation.yaml ;;
    scripts)  run_playbook script_installation.yaml ;;
    config)   run_playbook config.yaml ;;
    storage)  run_playbook storage.yaml ;;
    fonts)    run_playbook fonts.yaml ;;
    home)     run_playbook homedir_setup.yaml ;;
    *) usage ;;
esac
