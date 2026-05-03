#!/bin/bash

cp /config/tmux.conf "$HOME/.tmux.conf"

exec "$@"
