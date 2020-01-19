variable "do_api_token" {}
variable "do_sshkey_id" {}

provider "digitalocean" {
    token = "${var.do_api_token}"
}

locals {
  k8s_master_count = 1
  k8s_worker_count = 2
}

resource "digitalocean_droplet" "k8s_masters" {
  count = "${local.k8s_master_count}"
  name = "k8s-master-${count.index}"
  image = "ubuntu-18-04-x64"
  size = "2gb"
  region = "ams3"
  ssh_keys = ["${var.do_sshkey_id}"]
}

resource "digitalocean_droplet" "k8s_workers" {
  count = "${local.k8s_worker_count}"
  name = "k8s-worker-${count.index}"
  image = "ubuntu-18-04-x64"
  size = "2gb"
  region = "ams3"
  ssh_keys = ["${var.do_sshkey_id}"]
}


