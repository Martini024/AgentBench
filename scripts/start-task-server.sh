
#!/usr/bin/env bash
#
# detect-docker-host.sh
# Portable helper to set DOCKER_HOST automatically across macOS/Linux/Colima/Docker Desktop
#
eval "$(conda shell.bash hook)"
set -e

# Detect Docker socket and export DOCKER_HOST accordingly
if [ -S /var/run/docker.sock ]; then
  export DOCKER_HOST=unix:///var/run/docker.sock
  echo "✅ Using system Docker socket: $DOCKER_HOST"
elif [ -S "${HOME}/.docker/run/docker.sock" ]; then
  export DOCKER_HOST=unix://${HOME}/.docker/run/docker.sock
  echo "✅ Using Docker Desktop socket: $DOCKER_HOST"
elif [ -S "${HOME}/.colima/default/docker.sock" ]; then
  export DOCKER_HOST=unix://${HOME}/.colima/default/docker.sock
  echo "✅ Using Colima socket: $DOCKER_HOST"
else
  echo "⚠️  No Docker socket found."
  echo "   Start Docker Desktop (open -a Docker) or Colima (colima start)."
  exit 1
fi

# Print summary
echo "Docker host configured to: $DOCKER_HOST"


conda activate agent-bench
python -m src.start_task -a