# Public IP address
resource "google_compute_address" "static" {
  for_each     = toset(var.environments)
  name = "${each.key}-vm-public-address"
#  project = var.project
#  region = var.region
#  depends_on = [ google_compute_firewall.firewall ]
}

# VM
resource "google_compute_instance" "ubuntu" {
  for_each     = toset(var.environments)
  name         = "${each.key}-ubuntu"
  machine_type = "f1-micro"
  tags         = [each.key , var.image[each.key]]

  boot_disk {
    initialize_params {
      image = var.image[each.key]
      labels = {
        environment = each.key

      }
    }
  }


  network_interface {
    network = "default"
    subnetwork = "default"
    access_config {
      nat_ip = google_compute_address.static[each.key].address
    }
  }

  provisioner "remote-exec" {
    connection {
      host        = google_compute_address.static[each.key].address
      type        = "ssh"
      user        = var.user
      timeout     = "500s"
      private_key = file(var.privatekeypath)
    }

    inline = [
      "echo 'Hello IT Academy',
    ]
  }

  # Ensure firewall rule is provisioned before server, so that SSH doesn't fail.
 # depends_on = [ google_compute_firewall.firewall]

#  service_account {
#    email  = var.email
#    scopes = ["compute-ro"]
#  }

  metadata = {
    ssh-keys = "${var.user}:${file(var.publickeypath)}"
  }
}