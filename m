From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 78/86] pata_sis: Power Management fix
Date: Wed, 25 Nov 2009 18:11:47 +0100
Message-ID: <20091125171147.5446.15532.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:30269 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933637AbZKYRMZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:12:25 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_sis: Power Management fix

Call sis_fixup() on resume.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_sis.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_sis.c
===================================================================
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -2,7 +2,7 @@
  *    pata_sis.c - SiS ATA driver
  *
  *	(C) 2005 Red Hat
- *	(C) 2007 Bartlomiej Zolnierkiewicz
+ *	(C) 2007,2009 Bartlomiej Zolnierkiewicz
  *
  *    Based upon linux/drivers/ide/pci/sis5513.c
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
@@ -829,6 +829,23 @@ static int sis_init_one (struct pci_dev 
 	return ata_pci_sff_init_one(pdev, ppi, &sis_sht, chipset);
 }
 
+#ifdef CONFIG_PM
+static int sis_reinit_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
+	sis_fixup(pdev, host->private_data);
+
+	ata_host_resume(host);
+	return 0;
+}
+#endif
+
 static const struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VDEVICE(SI, 0x5513), },	/* SiS 5513 */
 	{ PCI_VDEVICE(SI, 0x5518), },	/* SiS 5518 */
@@ -844,7 +861,7 @@ static struct pci_driver sis_pci_driver 
 	.remove			= ata_pci_remove_one,
 #ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
+	.resume			= sis_reinit_one,
 #endif
 };
 
