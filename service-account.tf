# resource "google_project_iam_custom_role" "my-node-role" {
#   role_id     = "myNodeRole"
#   title       = "node-role"
#   permissions = ["resourcemanager.projects.get","storage.objects.get","storage.objects.list"]
# }
# data "google_iam_role" "instance-role" {
#   name = "roles/container.admin"
# }
# resource "google_project_iam_custom_role" "my-instance-role" {
#   role_id     = "myInstanceRole"
#   title       = "instance-role"
#   permissions = ["container.clusters.get","container.nodes.list","container.pods.list","container.pods.get","container.pods.delete","container.ingresses.list","container.ingresses.get","container.services.list","container.services.get","container.services.delete"]
# }
#####################service account to access private cluster from private instance#############
resource "google_service_account" "cluster-service" {
  account_id   = "service-cluster"
  display_name = "cluster"
}

resource "google_project_iam_binding" "admin-account-iam" {
  project = "mostafa-salah-377213"
  role               = "roles/container.admin"           
  members = [
    "serviceAccount:service-cluster@mostafa-salah-377213.iam.gserviceaccount.com",
  ]
}

##############cluster-nodes-service account########################3
resource "google_service_account" "gcr-service" {
  account_id   = "gcr-service"
  display_name = "gcr-pull-image"

}

resource "google_project_iam_binding" "admin-gcr-iam" {
  project = "mostafa-salah-377213"
  role               = "roles/storage.objectViewer"
  members = [
    "serviceAccount:gcr-service@mostafa-salah-377213.iam.gserviceaccount.com",
  ]
}