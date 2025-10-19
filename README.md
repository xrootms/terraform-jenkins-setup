# 🚀 Jenkins Server on AWS (Terraform Deployment)

This project automates the deployment of a Jenkins server behind an **Application Load Balancer (ALB)** with a valid **SSL certificate (ACM)**, using Terraform
It provisions all networking, security, and application components, integrating with a custom domain and SSL certificate for secure web access.

---
## 🏗️ Infrastructure Components
### Created Manually
Route 53 Hosted Zone: techsaif.gzz.io
Added manually in AWS Route 53
Name servers (NS) updated at the domain registrar (where the domain is purchased)

### Created via Terraform
Component	Directory	Description
Networking	networking/main.tf	Creates VPC, subnets, route tables, and Internet Gateway
Security Groups	security-groups/main.tf	Defines inbound/outbound rules for Jenkins and ALB
Load Balancer	load-balancer/main.tf	Creates ALB, target groups, and listeners
Target Group Attachment	load-balancer-target-group/main.tf	Attaches EC2 instance to the target group
Certificate Manager	certificate-manager/main.tf	Issues and validates ACM SSL certificate via DNS
Hosted Zone Records	hosted-zone/main.tf	Creates DNS records for domain and subdomain (e.g., jenkins.techsaif.gzz.io)
EC2 Instance (Jenkins)	jenkins/main.tf	Launches EC2 instance and runs Jenkins installer script
Jenkins Setup Script	jenkins-runner-script/jenkins-installer.sh	Installs Jenkins and dependencies automatically on EC2 startup


---

## 🌐 Domain Configuration

- A hosted zone named **`techsaif.gzz.io`** was **created manually** in Route 53.  
- The **4 name servers (NS)** provided by Route 53 were **updated at the domain registrar** (the domain provider where the domain was purchased).  
- This ensures that traffic to `jenkins.techsaif.gzz.io` is correctly routed to AWS.

---

## 🏗️ Terraform Infrastructure

The Terraform module provisions all AWS resources automatically.

### Created via Terraform:
- **VPC** with CIDR and subnets  
- **Internet Gateway** and **Route Tables**  
- **Security Groups** (for ALB and EC2 access)  
- **EC2 Instance** (Ubuntu-based) with **user data** to install Jenkins automatically  
- **Target Group** and **Listener Rule** for the ALB  
- **Application Load Balancer (ALB)** configured for port `80` and `443`  
- **ACM Certificate** (validated via Route 53 DNS record)  

---

## ⚙️ Jenkins Installation (User Data)

The EC2 instance runs a shell script at startup (via `userdata`) that:
1. Installs Java and Jenkins.  
2. Enables and starts the Jenkins service.  
3. Opens required ports (`8080`, etc.).  
4. Configures Jenkins to run at boot.

---

## 🔒 SSL Certificate (ACM)

- An **AWS Certificate Manager (ACM)** certificate is issued for `techsaif.gzz.io` and `jenkins.techsaif.gzz.io`.  
- DNS validation records are automatically created in the Route 53 hosted zone.  
- The ALB uses the validated certificate to serve traffic over **HTTPS (port 443)**.

---

## 🌍 Accessing Jenkins

Once Terraform apply completes and DNS propagation finishes:
- Open **https://jenkins.techsaif.gzz.io** in your browser.  
- Retrieve the initial Jenkins admin password from the EC2 instance:
  ```bash
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword
  ```

---

## 🧾 Prerequisites

Before running Terraform:
- Terraform v1.5+  
- AWS CLI configured with proper IAM credentials  
- A registered domain name (e.g., from GoDaddy, Namecheap, etc.)  
- Hosted Zone created in Route 53 (`techsaif.gzz.io`)  
- Name servers updated at the domain registrar  

---

## 🚀 Terraform Commands

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Preview changes
terraform plan

# Apply changes
terraform apply -auto-approve

# Destroy infrastructure
terraform destroy -auto-approve
```

---

## 📁 Project Structure (Example)

```
terraform-jenkins/
├── certificate-manager/
│   └── main.tf
├── hosted-zone/
│   └── main.tf
├── jenkins/
│   └── main.tf
├── jenkins-runner-script/
│   └── jenkins-installer.sh
├── load-balancer/
│   └── main.tf
├── load-balancer-target-group/
│   └── main.tf
├── networking/
│   └── main.tf
├── security-groups/
│   └── main.tf
├── main.tf
├── outputs.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── README.md
└── .gitignore

```

---

## 🧹 Cleanup

To avoid incurring charges, destroy the infrastructure when no longer needed:
```bash
terraform destroy
```

---

## 💡 Notes

- DNS propagation may take up to 30 minutes after updating name servers.  
- You can manually verify DNS records using:
  ```bash
  dig ns techsaif.gzz.io
  dig jenkins.techsaif.gzz.io
  ```
- Ensure that the ACM certificate is issued **in the same region** as the ALB.  

---

## 👨‍💻 Author
**Saif Uddin**  
AWS Cloud Engineer | Terraform | Jenkins | DevOps  
📧 your-email@example.com  
🌐 https://techsaif.gzz.io
