# Minecraft Server
## Get Started
2GB RAM required at least

```sh
source setup.sh

# build spigot
build

# run server
run_server
# in background
nohup run_server &
```

## Deploy
```sh
ansible-playbook vagrant/ansible/playbook-deploy.yml -i vagrant/ansible/inventory
```
