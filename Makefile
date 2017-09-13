ANSIBLE_PARAMS=

build:
	vagrant up --provision
	vagrant ssh -- '/vagrant/scripts/force_unmount.sh; sudo /vagrant/compile.sh armbox'

destroyvm:
	vagrant destroy
