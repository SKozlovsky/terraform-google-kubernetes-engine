/**
 * Copyright 2018 Google LLC
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

variable "org_id" {
  description = "The organization ID"
}

variable "billing_account" {
  description = "The billing account ID to attach to created service account"
}

variable "gke_service_project" {
  description = "The service project ID to host the cluster in"
  default     = "ci-gke-svpc-service"
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "us-central1"
}

variable "gke_shared_host_project" {
  description = "The GCP project housing the VPC network to host the cluster in"
  default     = "ci-gke-svpc-host"
}




