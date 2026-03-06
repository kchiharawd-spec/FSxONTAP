# AWS ハンズオン：

## ⚠ 注意事項（必ずお読みください）

このハンズオンでは AWS の有料サービスを利用します。

特に **Amazon FSx for NetApp ONTAP** は作成している間、継続して料金が発生します。

学習が終了したら、必ず CloudFormation スタックを削除してください。

削除対象スタック

- network-stack
- compute-stack
- storage-stack

スタック削除により以下のリソースが削除されます。

- VPC
- Subnet
- EC2
- FSx for ONTAP

削除を忘れると料金が発生し続ける可能性があります。

スタック削除後、以下も確認してください

- Elastic IP が残っていないか

## このハンズオンで学習できること

このハンズオンでは、Amazon FSx for NetApp ONTAP を利用して  
AWS上にNAS環境を構築する方法を学習します。

主に以下の内容を理解することを目的とします。

### ストレージ基礎

- Amazon FSx for NetApp ONTAP の基本構成
- ONTAPにおけるストレージ構造（SVM / Volume）
- AWS上でNASを構築する仕組み

### 接続方法

- EC2からNFSでマウントする方法
- LinuxからのNFSマウント手順

### 運用機能

- Snapshotによる高速バックアップの仕組み

### インフラ構築

- CloudFormationによるインフラのIaC化
- VPC / Subnet / EC2 / FSxの構築
- スタック分割によるインフラ管理

## 構成図

VPC
└ Private Subnet

    ├ EC2 (Amazon Linux)
    │     └ NFS Client
    │
    └ FSx for NetApp ONTAP
          └ Storage Virtual Machine (SVM)
                └ NFS Volume

EC2からNFSプロトコルを利用して、
FSx for NetApp ONTAP上のVolumeをマウントする構成です。


## 今回構築するリソース

Network
- VPC
- Subnet
- Route Table

Compute
- EC2

Storage
- FSx for ONTAP
- SVM
- Volume

