#!/bin/bash

# Step 1: Check if /dev/sr0 is mounted
if mount | grep -q "/dev/sr0"; then
  echo "✅ /dev/sr0 is already mounted."
else
  echo "📀 Mounting /dev/sr0 to /mnt..."
  mount /dev/sr0 /mnt
  if [ $? -ne 0 ]; then
    echo "❌ Failed to mount /dev/sr0. Please check if ISO/DVD is attached."
    exit 1
  fi
fi

# Step 2: Backup existing repo files
echo "📁 Backing up existing repo files..."
mkdir -p /etc/yum.repos.d/backup
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup/

# Step 3: Create new repo file
echo "📝 Creating /etc/yum.repos.d/local.repo..."
cat <<EOF > /etc/yum.repos.d/local.repo
[BaseOS]
name=BaseOS
baseurl=file:///mnt/BaseOS
enabled=1
gpgcheck=0

[AppStream]
name=AppStream
baseurl=file:///mnt/AppStream
enabled=1
gpgcheck=0
EOF

# Step 4: Clean and list yum repositories
echo "🧹 Cleaning yum cache..."
yum clean all

echo "🔍 Listing available repositories..."
yum repolist

echo "✅ Local YUM repository setup completed!"
