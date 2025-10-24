# Automated Jenkins Deployment on AWS using Terraform
*This project automates the Jenkins CI/CD environment on AWS — using Terraform as Infrastructure-as-Code (IaC). It provisions all networking, security, and application components, integrating with a custom domain and SSL certificate for secure web access.*

<p align="center">
  <img src="./image/01-diagram-infra-img.jpg" alt="LEMP Diagram" width="600">
</p>

## Project Overview
The setup automates the deployment of a Jenkins server behind an Application Load Balancer (ALB) with a valid SSL certificate (ACM), using Terraform Infrastructure as Code (IaC).

#### Main components:

- ➡️ Custom VPC with public subnets, Internet Gateway, and route tables
- ➡️ Security Groups for Jenkins and ALB
- ➡️ EC2 Instance for Jenkins (with User Data installation script)
- ➡️ Target Group and Application Load Balancer (ALB) setup
- ➡️ ACM Certificate for HTTPS
- ➡️ DNS Integration with Route 53

## Prerequisites
Before Running Terraform, Make sure you have the following prerequisites ready:

- ➡️ Terraform v1.3+ (recommended)
- ➡️ AWS CLI configured with proper IAM credentials
- ➡️ A registered domain name (e.g., from GoDaddy, Namecheap, etc.)
- ➡️ Hosted Zone created in Route 53 — Example: hosted zone name: techsaif.gzz.io
- ➡️ Name Servers updated at your domain registrar
- ➡️ Public and Private Key

## *Step 1:* 
### Setup Hosted Zone :
To work with this whole setup we need to setup  Route53 and in Route53 we first need to setup our hosted zone.

- 1️⃣  Navigate to Route 53 → Hosted zones → Create hosted zone
- 2️⃣  In the Domain name field, enter the exact domain name you own (e.g., techsaif.gzz.io)
- 3️⃣  Select Type → Public hosted zone
- 4️⃣  Click Create hosted zone
 <p align="center">
  <img src="./image/02-hostedzoneimage.png" alt="LEMP Diagram" width="400">
</p>

- 5️⃣ Once you created you will get these four records which is "ns records".
 <p align="center">
  <img src="./image/03-hostedzoneimage2.png" alt="LEMP Diagram" width="600">
</p>

- 6️⃣ Update these ns recode over your domine register's ns recode.
<p align="center">
  <img src="./image/04-registarupdateimage.png" alt="LEMP Diagram" width="600">
</p>


## *Step 2:*
#### 1. Clone the repo:
   ```bash
   git clone https://github.com/xrootms/terraform-jenkins-setup.git
   cd terraform-aws-vpc-ec2
   ```

#### 2. Copy and edit variables: (Update variable values as needed — VPC, CIDR, public key, region, etc.)
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

🔹**Hosted zone:**

   The ALB DNS name is mapped to jenkins.techsaif.gzz.io using a Route 53 A record.

<p align="center">
  <img src="./image/06-Hoted-zone-img.jpg" alt="LEMP Diagram" width="900">
</p>


🔹**SSL Configuration:**

  An ACM Certificate is created for: jenkins.techsaif.gzz.io and attached to the ALB for https traffic.

<p align="center">
  <img src="./image/07-ACMimage.png" alt="LEMP Diagram" width="900">
</p>


🔹**Jenkins Installation (User Data):**
 During EC2 instance creation, a user data script automatically installs and configures Jenkins    and Terraform. Script used: jenkins-runner-script/jenkins-installer.sh


🔹**Accessing Jenkins:**

  *Once Terraform apply completes and DNS propagation finishes:*
  *Open https://jenkins.techsaif.gzz.io in your browser.*

<p align="center">
  <img src="./image/08-jenkins-url.png" alt="LEMP Diagram" width="900">
</p>


  *Retrieve the initial Jenkins admin password from the EC2 instance:*
  
<p align="center">
  <img src="./image/09-Screenshot 2025-10-20 233210.png" alt="LEMP Diagram" width="900">
</p>
  
- Get the initial admin password:
  
  ```bash
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword
  ```


---  
**Notes**
➡️ ACM and ALB must be in the same AWS region
➡️ DNS propagation may take up to 30 minutes
➡️ Check ACM validation status in AWS Console → Certificate Manager
➡️ To avoid unnecessary costs, destroy the infrastructure when no longer needed

```bash
terraform destroy    
```

  ⭐ If you found this project interesting, consider giving it a star!



