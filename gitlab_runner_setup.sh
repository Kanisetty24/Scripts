#!/bin/bash

# Update package list and install GitLab Runner repository
echo "Adding GitLab Runner repository..."
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash

# Start GitLab Runner service
echo "Starting GitLab Runner..."
sudo gitlab-runner start

# Fix broken dependencies (if any)
echo "Fixing broken dependencies..."
sudo apt --fix-broken install

# Check the installed version of GitLab Runner
echo "Checking GitLab Runner version..."
gitlab-runner --version

# Register GitLab Runner with your GitLab instance
echo "Registering GitLab Runner with GitLab instance..."
# NOTE: Replace 'glrt-t3_x_uG933YV-xSvgszSEZ1' with your own GitLab Runner registration token.
gitlab-runner register --url https://gitlab.com --token glrt-t3_x_uG933YV-xSvgszSEZ1

# Executor selection (This part requires manual interaction)
echo "Please choose an executor when prompted (e.g., shell, docker, etc.)"

# Run the GitLab Runner
echo "Running GitLab Runner..."
gitlab-runner run
