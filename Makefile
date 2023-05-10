ANSIBLE_PARAMS=

build-docker:
	./compile.sh docker armbox

build:
	vagrant up --provision
	vagrant ssh -- '/vagrant/scripts/force_unmount.sh; sudo /vagrant/compile.sh armbox'

destroyvm:
	vagrant destroy

routerbox-split-latest:
	support/git-subtree-split-latest.sh userpatches/routerbox

routerbox-pull-latest:
	support/git-subtree-pull-latest.sh userpatches/routerbox

routerbox-push-origin:
	support/git-subtree-push-origin-master.sh userpatches/routerbox

setup-running-machine:
	source ./armbox.config; \
	cd userpatches/routerbox; \
	ansible-playbook $(ANSIBLE_PARAMS) -e board=$$BOARD -i inventory.running-machine setup.yml
