#!/bin/sh

# Process environment variables for React
/app/frontend/build/env.sh

# Execute the main command
exec "$@"