/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  int_required_project_roles = [
    "roles/owner",
    "roles/compute.admin",
    "roles/cloudkms.cryptoKeyEncrypterDecrypter",
    "roles/container.admin",
    "roles/container.clusterAdmin",
    "roles/container.developer",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/compute.networkAdmin",
    "roles/compute.viewer",
    "roles/resourcemanager.projectIamAdmin",
    "roles/composer.worker"
  ]

  int_required_folder_roles = [
    "roles/compute.admin",
    "roles/compute.networkAdmin",
    "roles/owner",
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.folderIamAdmin",
    "roles/billing.projectManager",
    "roles/compute.xpnAdmin",
    "roles/resourcemanager.projectIamAdmin"
  ]
}


resource "random_id" "random_suffix" {
  byte_length = 2
}

resource "google_service_account" "int_test" {
  project      = module.gke-project.project_id
  account_id   = "gke-int-test-${random_id.random_suffix.hex}"
  display_name = "gke-int-test"
}

resource "google_service_account" "gke_sa" {
  project      = module.gke-project.project_id
  account_id   = "gke-sa-int-test-${random_id.random_suffix.hex}"
  display_name = "gke-sa-int-test"
}

resource "google_project_iam_member" "int_test" {
  count = length(local.int_required_project_roles)

  project = module.gke-project.project_id
  role    = local.int_required_project_roles[count.index]
  member  = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_folder_iam_member" "int_test_folder" {
  count = length(local.int_required_folder_roles)

  folder = google_folder.ci_gke_folder.name
  role   = local.int_required_folder_roles[count.index]
  member = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_service_account_key" "int_test" {
  service_account_id = google_service_account.int_test.id
}

resource "google_billing_account_iam_member" "int_billing_user" {
  billing_account_id = var.billing_account
  role               = "roles/billing.user"
  member             = "serviceAccount:${google_service_account.int_test.email}"
}
