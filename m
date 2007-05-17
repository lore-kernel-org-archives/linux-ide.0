From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_nv: fix fallout of devres conversion
Date: Thu, 17 May 2007 13:13:57 +0200
Message-ID: <464C38F5.3060802@gmail.com>
References: <15F501D1A78BD343BE8F4D8DB854566B13CD8F45@hkemmail01.nvidia.com> <464A94D7.30300@garzik.org> <15F501D1A78BD343BE8F4D8DB854566B13DEF520@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:52818 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbXEQLOU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 07:14:20 -0400
Received: by nz-out-0506.google.com with SMTP id r28so909328nza
        for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 04:14:19 -0700 (PDT)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B13DEF520@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, IDE/ATA development list <linux-ide@vger.kernel.org>


As with all other drivers, sata_nv's hpriv is allocated with
devm_kzalloc() and there's no need to free it explicitly.  Kill
nv_remove_one() which incorrectly used kfree() instead of devm_kfree()
and use ata_pci_remove_one() directly.

Original fix is from Peer Chen.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Peer Chen <pchen@nvidia.com>
---

I think it's prettier this way.  :-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 4cea3ef..5be4e28 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -229,7 +229,6 @@ struct nv_host_priv {
 #define NV_ADMA_CHECK_INTR(GCTL, PORT) ((GCTL) & ( 1 << (19 + (12 * (PORT)))))
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void nv_remove_one (struct pci_dev *pdev);
 #ifdef CONFIG_PM
 static int nv_pci_device_resume(struct pci_dev *pdev);
 #endif
@@ -306,7 +305,7 @@ static struct pci_driver nv_pci_driver =
 	.suspend		= ata_pci_device_suspend,
 	.resume			= nv_pci_device_resume,
 #endif
-	.remove			= nv_remove_one,
+	.remove			= ata_pci_remove_one,
 };
 
 static struct scsi_host_template nv_sht = {
@@ -1613,15 +1612,6 @@ static int nv_init_one (struct pci_dev *
 				 IRQF_SHARED, ppi[0]->sht);
 }
 
-static void nv_remove_one (struct pci_dev *pdev)
-{
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	struct nv_host_priv *hpriv = host->private_data;
-
-	ata_pci_remove_one(pdev);
-	kfree(hpriv);
-}
-
 #ifdef CONFIG_PM
 static int nv_pci_device_resume(struct pci_dev *pdev)
 {
