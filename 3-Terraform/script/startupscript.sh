USER_NAME=ansible
useradd -m -d /home/$USER_NAME $USER_NAME
usermod -aG sudo $USER_NAME
mkdir -p /etc/sudoers.d
echo 'ansible ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/$USER_NAME
mkdir -p /home/$USER_NAME/.ssh
echo "THE PUB RSA KEY" > /home/$USER_NAME/.ssh/authorized_keys
chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/