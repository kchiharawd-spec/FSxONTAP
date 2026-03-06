# Network Stack 詳細設計

## 1. 概要

FSx for NetApp ONTAP の検証環境として利用するネットワークを構築する。

EC2からNFSマウントを行い、AWS上でNAS構成を検証する。

---

## 2. 構成図

VPC (10.0.0.0/16)

└ Private Subnet (10.0.1.0/24)

├ EC2 (Amazon Linux)
│ └ NFS Client
│
└ FSx for NetApp ONTAP
└ Storage Virtual Machine
└ NFS Volume


---

## 3. リソース一覧

| No | リソース | 論理名 | 設定 |
|---|---|---|---|
| 1 | VPC | MainVPC | 10.0.0.0/16 |
| 2 | Subnet | PrivateSubnetA | 10.0.1.0/24 |
| 3 | RouteTable | PrivateRouteTable | Local |
| 4 | SecurityGroup | Ec2SecurityGroup | SSH / NFS |
| 5 | SecurityGroup | FsxSecurityGroup | NFS |

---

## 4. VPC

| 項目 | 値 |
|---|---|
| Name | fsx-lab-vpc |
| CIDR | 10.0.0.0/16 |

---

## 5. Subnet

| 項目 | 値 |
|---|---|
| Name | private-subnet-a |
| CIDR | 10.0.1.0/24 |
| AZ | ap-northeast-1a |

---

## 6. Security Group

### EC2

| Type | Port | Source |
|---|---|---|
| SSH | 22 | 自分のIP |
| NFS | 2049 | 10.0.0.0/16 |

### FSx

| Type | Port | Source |
|---|---|---|
| NFS | 2049 | EC2 SecurityGroup |

---

## 7. 設計方針

今回の環境では以下の理由から NAT Gateway は作成しない。

- 検証環境のため最小構成
- FSx接続確認が目的
- コスト削減

将来的には以下の構成へ拡張可能とする。

VPC
├ Public Subnet
│ └ Bastion
│
└ Private Subnet
├ EC2
└ FSx