# Set up 
## Necessary softwares
- VScode

# Install zsh
# Install zsh if not installed
sudo apt update && sudo apt install -y zsh curl

# Set zsh as the default shell
chsh -s $(which zsh)

# Optional: Install Oh My Zsh for themes and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# (Optional fallback) If the shell still starts as bash, add this to end of .bashrc
echo 'exec zsh' >> ~/.bashrc

# Install conda
mkdir -p ~/apps/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/apps/miniconda3/miniconda.sh
bash ~/apps/miniconda3/miniconda.sh -b -u -p ~/apps/miniconda3
rm -rf ~/apps/miniconda3/miniconda.sh


# Install Docker
https://docs.docker.com/engine/install/ubuntu/
# allow non-prelivage user to run docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

### Install Quarto
## Website https://quarto.org/docs/download/
TODO


### Set up singularity
https://docs.sylabs.io/guides/latest/admin-guide/installation.html#installation-on-linux
# Ensure repositories are up-to-date
sudo apt-get update
# Install debian packages for dependencies
sudo apt-get install -y \
   autoconf \
   automake \
   cryptsetup \
   fuse2fs \
   git \
   fuse \
   libfuse-dev \
   libseccomp-dev \
   libtool \
   pkg-config \
   runc \
   squashfs-tools \
   squashfs-tools-ng \
   uidmap \
   wget \
   zlib1g-dev \
   libsubid-dev

# Download the latest release of Singularity https://github.com/sylabs/singularity/releases
sudo dpkg -i singularity-ce_4.3.0-noble_amd64.deb