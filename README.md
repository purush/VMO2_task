# VMO2_task

## Task 1

Kubernetes cluster created on private subnet and cloud NAT is used for outbound internet connection . Firewall rules created to allow SSH for source IP 35.235.240.0/20 using IAP to connect using browser and gcloud command to run kubectl . 

1. Enable Compute Engine API and Kubernetes Engine API on the project

2. Set project ID :   gcloud config set core/project <Project ID>

3. export TF_VAR_project_id=$(gcloud config get-value project)

4. gcloud auth login ; export GOOGLE_OAUTH_ACCESS_TOKEN=$(gcloud auth print-access-token)  [ Acccess token valid for 1 hr]

5. run Terraform init, plan and apply to provision the cluster , run terraform destroy for cleanup.

Note : To SSH to control plane nodes use gcloud or browser shell using on one of the nodes , Firewall rules added to allow  SSH.

e.g: gcloud compute ssh INSTANCE-NAME  --zone europe-west2-c --tunnel-through-iap

  
## Task 2

1.SA account created with Data Editor role and user can impersonate the service account for bq Data Editor role.

To Impersonate service account by principal the ACCESS TOKEN can be set using below command.
export GOOGLE_OAUTH_ACCESS_TOKEN=$(gcloud auth print-access-token --impersonate-service-account=bq-editor-sa@<Project ID>.iam.gserviceaccount.com
)
2.Module create as explained on Task2



