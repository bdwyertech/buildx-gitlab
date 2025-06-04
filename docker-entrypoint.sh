#!/bin/sh
# Magic to Provision the Container
# Brian Dwyer - Intelligent Digital Services

# Workaround for GitLab ENTRYPOINT double execution (issue: 1380)
if [ ! -e '/buildx/.gitlab-runner.lock' ]; then
	touch /buildx/.gitlab-runner.lock
	# Docker Configuration Helper Utility
	helper-utility
fi

# Passthrough
exec "$@"
