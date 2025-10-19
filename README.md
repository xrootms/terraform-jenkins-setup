# 🚀 Jenkins Server on AWS (Terraform Deployment)

This project provisions a **Jenkins CI/CD server** on **AWS EC2** using **Terraform**.  
It includes complete infrastructure setup — from networking to domain configuration — ensuring a production-ready environment accessible via a custom domain.

---

## 🧩 Project Overview

The setup automates the deployment of a Jenkins server behind an **Application Load Balancer (ALB)** with a valid **SSL certificate (ACM)**, using Terraform Infrastructure as Code (IaC).  

**Main components:**
- Custom VPC with public and private subnets  
- Internet Gateway and route tables  
- Security Groups for Jenkins and ALB  
- EC2 instance for Jenkins (with `userdata` installation script)  
- Target Group and ALB setup  
- ACM certificate for HTTPS  
- DNS integration with Route 53  

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
├── main.tf
├── variables.tf
├── outputs.tf
├── userdata.sh
├── modules/
│   ├── vpc/
│   ├── ec2/
│   ├── alb/
│   ├── acm/
│   └── route53/
└── README.md
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
