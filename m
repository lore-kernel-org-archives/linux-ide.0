From: Vivek Mahajan <vivek.mahajan@freescale.com>
Subject: [PATCH 1/1] ata/sata_sil24: MSI support, disabled by default
Date: Mon, 16 Nov 2009 11:49:22 +0530
Message-ID: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:39504 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbZKPGTk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Nov 2009 01:19:40 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Vivek Mahajan <vivek.mahajan@freescale.com>

The following patch adds MSI support. Some platforms
may have broken MSI, so those are defaulted to use
legacy PCI interrupts.

Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
---
 drivers/ata/sata_sil24.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index e6946fc..1370df6 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -417,6 +417,10 @@ static struct ata_port_operations sil24_ops = {
 #endif
 };
 
+static int sata_sil24_msi;    /* Disable MSI */
+module_param_named(msi, sata_sil24_msi, bool, S_IRUGO);
+MODULE_PARM_DESC(msi, "Enable MSI (Default: false)");
+
 /*
  * Use bits 30-31 of port_flags to encode available port numbers.
  * Current maxium is 4.
@@ -1340,6 +1344,11 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	sil24_init_controller(host);
 
+	if (sata_sil24_msi && !pci_enable_msi(pdev)) {
+		dev_printk(KERN_INFO, &pdev->dev, "Using MSI\n");
+		pci_intx(pdev, 0);
+	}
+
 	pci_set_master(pdev);
 	return ata_host_activate(host, pdev->irq, sil24_interrupt, IRQF_SHARED,
 				 &sil24_sht);
-- 
1.5.6.5

