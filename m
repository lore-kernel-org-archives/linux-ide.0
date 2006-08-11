From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] CONFIG_PM=n slim: drivers/scsi/sata_sil*
Date: Sat, 12 Aug 2006 02:52:13 +0400
Message-ID: <20060811225213.GK6847@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:57065 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750804AbWHKWwP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Aug 2006 18:52:15 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1009515ugc
        for <linux-ide@vger.kernel.org>; Fri, 11 Aug 2006 15:52:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/scsi/sata_sil.c   |    6 ++++++
 drivers/scsi/sata_sil24.c |    6 ++++++
 2 files changed, 12 insertions(+)

--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -339,7 +339,9 @@ static int sil24_port_start(struct ata_p
 static void sil24_port_stop(struct ata_port *ap);
 static void sil24_host_stop(struct ata_host_set *host_set);
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+#ifdef CONFIG_PM
 static int sil24_pci_device_resume(struct pci_dev *pdev);
+#endif
 
 static const struct pci_device_id sil24_pci_tbl[] = {
 	{ 0x1095, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
@@ -355,8 +357,10 @@ static struct pci_driver sil24_pci_drive
 	.id_table		= sil24_pci_tbl,
 	.probe			= sil24_init_one,
 	.remove			= ata_pci_remove_one, /* safe? */
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= sil24_pci_device_resume,
+#endif
 };
 
 static struct scsi_host_template sil24_sht = {
@@ -1185,6 +1189,7 @@ static int sil24_init_one(struct pci_dev
 	return rc;
 }
 
+#ifdef CONFIG_PM
 static int sil24_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
@@ -1203,6 +1208,7 @@ static int sil24_pci_device_resume(struc
 
 	return 0;
 }
+#endif
 
 static int __init sil24_init(void)
 {
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -109,7 +109,9 @@ enum {
 };
 
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+#ifdef CONFIG_PM
 static int sil_pci_device_resume(struct pci_dev *pdev);
+#endif
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
@@ -161,8 +163,10 @@ static struct pci_driver sil_pci_driver 
 	.id_table		= sil_pci_tbl,
 	.probe			= sil_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= sil_pci_device_resume,
+#endif
 };
 
 static struct scsi_host_template sil_sht = {
@@ -700,6 +704,7 @@ err_out:
 	return rc;
 }
 
+#ifdef CONFIG_PM
 static int sil_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
@@ -711,6 +716,7 @@ static int sil_pci_device_resume(struct 
 
 	return 0;
 }
+#endif
 
 static int __init sil_init(void)
 {

