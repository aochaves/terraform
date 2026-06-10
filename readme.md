# AWS High Availability Infrastructure with Terraform

Este projeto implementa uma infraestrutura altamente disponível e escalável na AWS para uma aplicação web, distribuída entre duas zonas de disponibilidade (Zone A e Zone B). A implementação segue os princípios de SRE (Site Reliability Engineering) para garantir resiliência e elasticidade.

## 👥 Integrantes do Projeto

| Nome | RA |
|--------|--------|
| Fabio Fumio Wada | 10741479 |
| Sweeli Suzuki | 10423319 |
| Alberto Oliveira | 10743782 |


## 🏗️ Arquitetura

A solução provisiona os seguintes componentes:

- **Amazon Route 53**: Serviço de DNS que resolve o nome do domínio e direciona as requisições para o Load Balancer.
- **Elastic Load Balancing (ELB)**: Distribui automaticamente o tráfego de entrada entre as instâncias EC2 nas duas zonas de disponibilidade.
- **Auto Scaling Group**: Monitora a carga das instâncias e realiza escalabilidade horizontal automática (ex.: CPU > 80%) para garantir eficiência de custo e desempenho.
- **Zonas de Disponibilidade (AZs)**: Sub-redes públicas em duas zonas distintas para suportar falhas de datacenter.

---

## 📂 Estrutura do Projeto

O código Terraform foi organizado de forma modular para facilitar a manutenção:

| Arquivo | Descrição |
|----------|------------|
| `main.tf` | Configuração do provedor AWS |
| `network_vpc.tf` | Criação da VPC e sub-redes nas Zone A e Zone B |
| `security.tf` | Definição dos Security Groups para o Load Balancer e instâncias |
| `compute.tf` | Launch Template (AMI `ami-0b6c6ebed2801a5cb`) e Auto Scaling Group |
| `loadbalancer.tf` | Configuração do Application Load Balancer e Target Groups |
| `dns.tf` | Registros DNS no Route 53 |
| `variables.tf` | Declaração de variáveis utilizadas pelo projeto |
| `outputs.tf` | Exibe o DNS final do Load Balancer após o provisionamento |

---

## 🚀 Como Utilizar

Siga o fluxo padrão do Terraform para gerenciar a infraestrutura:

### 1. Inicialização

Baixe os providers e dependências necessárias.

```bash
terraform init
```

### 2. Planejamento

Revise as alterações que serão aplicadas.

```bash
terraform plan
```

### 3. Provisionamento

Crie a infraestrutura na AWS.

```bash
terraform apply
```

### 4. Destruição

Remova todos os recursos para evitar custos após os testes.

```bash
terraform destroy
```

---

## 🧠 Conceitos Aplicados

### Idempotência

O Terraform utiliza o arquivo `terraform.tfstate` para garantir que múltiplas execuções do mesmo código não criem recursos duplicados desnecessariamente.

### Infraestrutura como Código (IaC)

Permite o provisionamento rápido, padronizado e auditável da infraestrutura através de código.

### Alta Disponibilidade

A distribuição dos recursos entre duas sub-redes públicas em diferentes zonas de disponibilidade garante maior resiliência e continuidade do serviço mesmo diante da falha de uma zona.

### Escalabilidade

O Auto Scaling Group ajusta automaticamente a quantidade de instâncias de acordo com a demanda da aplicação.

---

## 📚 Bibliografia de Referência

Este projeto foi baseado nas diretrizes e boas práticas apresentadas em:

- **Terraform: Up & Running** — Yevgeniy Brikman
- **The DevOps Handbook (Manual de DevOps)** — Gene Kim, Jez Humble, Patrick Debois e John Willis
- **Site Reliability Engineering (SRE)** — Google

---

## 📌 Objetivo

Demonstrar a implementação de uma arquitetura resiliente, escalável e automatizada utilizando Terraform e serviços gerenciados da AWS, seguindo práticas modernas de Infraestrutura como Código (IaC), DevOps e SRE.

