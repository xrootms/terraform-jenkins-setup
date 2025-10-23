# Automated Jenkins Deployment on AWS using Terraform
*This project automates the Jenkins CI/CD environment on AWS — using Terraform as Infrastructure-as-Code (IaC). It provisions all networking, security, and application components, integrating with a custom domain and SSL certificate for secure web access.*

<p align="center">
  <img src="./image/diagram-infra-img.jpg" alt="LEMP Diagram" width="600">
</p>

## *Project Overview*
*This Terraform setup builds a fully functional Jenkins environment with:*
- Scalable AWS infrastructure (VPC, subnets, security groups)
- Automated Jenkins installation via user data script
- Load balancing and HTTPS termination using AWS ALB + ACM
- Custom domain integration using Route 53

## *Prerequisites*
*Before Running Terraform, Make sure you have the following prerequisites ready:*
- **Terraform v1.3+** (recommended)  
- **AWS CLI** configured with proper IAM credentials  
- **A registered domain name** (e.g., from GoDaddy, Namecheap, etc.)  
- **Hosted Zone** created in Route 53  > Example: `hosted zone name: techsaif.gzz.io`
- **Name servers** updated at your domain registrar

## *How to Use*
#### 1. Clone the repo:
   ```bash
   git clone https://github.com/xrootms/terraform-jenkins-setup.git
   cd terraform-aws-vpc-ec2
   ```

#### 2. Copy and edit variables: (Update variable values as needed — region, VPC CIDR, domain name, etc.)
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

#### 3. Initialize Terraform:
   ```bash
   terraform init
   ```

#### 4. Plan and Apply:
   ```bash
   terraform plan
   terraform apply
   ```

#### 5. Get ssh connection for EC2:
<p align="center">
  <img src="./image/apply-copy.png" alt="LEMP Diagram" width="900">
</p>

---
## *After successful deployment:*

### 🔹*Jenkins Installation (User Data)*

- During EC2 instance creation, a user data script automatically installs and configures Jenkins and Terraform.
Script used: jenkins-runner-script/jenkins-installer.sh

### 🔹*Domain Configuration:*

- The **ALB DNS** name is mapped to **jenkins.techsaif.gzz.io** using a Route 53 **A record**.

<p align="center">
  <img src="./image/Screenshot 2025-10-23 012719.png" alt="LEMP Diagram" width="1000">
</p>

### 🔹*SSL Configuration:*
- An **ACM** Certificate is created for: **jenkins.techsaif.gzz.io** and attached to the ALB for https traffic.

<p align="center">
  <img src="./image/ACM-arn-copy.png" alt="LEMP Diagram" width="900">
</p>

  
### 🔹*Accessing Jenkins:*
- Once Terraform apply completes and DNS propagation finishes:
- Open **https://jenkins.techsaif.gzz.io** in your browser.
- 
<p align="center">
  <img src="./image/jenkins-url.png" alt="LEMP Diagram" width="700">
</p>

- Retrieve the initial Jenkins admin password from the EC2 instance:
<p align="center">
  <img src="./image/ssh.png" alt="LEMP Diagram" width="600">
</p>

- Get the initial admin password:
  
  ```bash
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword
  ```


---  
### *Notes*
- *ACM and ALB must be in the same AWS region.*
- *DNS propagation can take up to 30 minutes.*
- *Verify ACM validation status under AWS Console → Certificate Manager.*
- *To avoid incurring charges, destroy the infrastructure when no longer needed:*
```bash
terraform destroy    
```

  ⭐ If you found this project interesting, consider giving it a star!



