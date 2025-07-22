#!/bin/bash

devcontainer up --workspace-folder . --remove-existing-container
devcontainer exec --workspace-folder . -- zsh