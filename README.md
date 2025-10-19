# Jenkins Server on AWS (Terraform Deployment)

This project automates the deployment of a Jenkins server behind an **Application Load Balancer (ALB)** with a valid **SSL certificate (ACM)**, using Terraform.
It provisions all networking, security, and application components, integrating with a custom domain and SSL certificate for secure web access.

## Prerequisites
Before running Terraform:
- Terraform v1.3+ recommended
- AWS CLI configured with proper IAM credentials  
- A registered domain name (e.g., from GoDaddy, Namecheap, etc.)  
- Hosted Zone created in Route 53 (`ex:- hosted zone name: techsaif.gzz.io`)  
- Name servers updated at the domain registrar 

## Infrastructure Components
- The Terraform module provisions all AWS resources automatically.
  
| Component                       | Directory                                    | Description                                                                      |
| ------------------------------- | -------------------------------------------- | -------------------------------------------------------------------------------- |
| **Networking**                  | `networking/main.tf`                         | Creates VPC, subnets, route tables, and Internet Gateway                         |
| **Security Groups**             | `security-groups/main.tf`                    | Defines inbound/outbound rules for Jenkins and ALB                               |
| **Load Balancer**               | `load-balancer/main.tf`                      | Creates ALB, target groups, and listeners                                        |
| **Target Group**                | `load-balancer-target-group/main.tf`         | Attaches EC2 instance to the target group                                        |
| **Certificate Manager**         | `certificate-manager/main.tf`                | Issues and validates ACM SSL certificate via DNS                                 |
| **Hosted Zone Records**         | `hosted-zone/main.tf`                        | Creates DNS records for domain and subdomain (e.g., jenkins.techsaif.gzz.io)     |
| **EC2 Instance (Jenkins)**      | `jenkins/main.tf`                            | Launches EC2 instance and runs Jenkins installer script                          |
| **Jenkins Setup Script**        | `jenkins-runner-script/jenkins-installer.sh` | Installs Jenkins and dependencies automatically on EC2 startup                   |


---
## After successful deployment:

### 🌐 Domain Configuration:

- The ALB DNS name is mapped to jenkins.techsaif.gzz.io using a Route 53 A record.
- DNS propagation may take up to 30 minutes after updating name servers.
  
To verify:
```bash
dig ns techsaif.gzz.io
dig jenkins.techsaif.gzz.io
```
### 🔒 SSL Configuration
An ACM Certificate is created for: jenkins.techsaif.gzz.io

- Validation is done automatically via Route 53 DNS records.
- The certificate is attached to the Application Load Balancer (ALB) for HTTPS traffic.

### ⚙️ Jenkins Installation (User Data)

- During EC2 instance creation, user data script automatically installs and configures Jenkins and Terraform.
  
### 🌍 Accessing Jenkins

Once Terraform apply completes and DNS propagation finishes:
- Open **https://jenkins.techsaif.gzz.io** in your browser.  
- Retrieve the initial Jenkins admin password from the EC2 instance:
  ```bash
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword
  ```
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
