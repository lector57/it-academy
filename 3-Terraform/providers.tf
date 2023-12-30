provider "google" {
  credentials = file("gcloud.json")
  project     = "alert-inquiry-405920"
  region      = "europe-central2"
  zone      = "europe-central2-a"
}


