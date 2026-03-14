echo "Applying Ubuntu specific tweaks..."

DEBIAN_FRONTEND=noninteractive sudo apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" full-upgrade build-essential

echo "Ubuntu configuration done."

# noninteractive install
# DEBIAN_FRONTEND=noninteractive sudo apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade build-essential
