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

output "folder_id" {
  value = google_folder.ci_gke_folder.id
}

output "project_ids" {
  value = [module.gke-project-1.project_id, module.gke-project-2.project_id]
}

output "sa_key" {
  value     = google_service_account_key.int_test.private_key
  sensitive = true
}

output "compute_engine_service_accounts" {
  value = [google_service_account.gke_sa_1.email, google_service_account.gke_sa_2.email]
}

output "registry_project_id" {
  value = module.gke-project-1.project_id
}

output "billing_account" {
  value = var.billing_account
}
