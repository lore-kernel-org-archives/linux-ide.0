From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: convert pata_pdc2027x to the new reset mechanism
Date: Thu, 30 Mar 2006 11:12:01 +0800
Message-ID: <442B4C81.4010305@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:59020 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751235AbWC3DMR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Mar 2006 22:12:17 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k2U3CBCW020562
	for <linux-ide@vger.kernel.org>; Wed, 29 Mar 2006 22:12:11 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2U3FHMk071764
	for <linux-ide@vger.kernel.org>; Wed, 29 Mar 2006 20:15:18 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2U3C9Wv019431
	for <linux-ide@vger.kernel.org>; Wed, 29 Mar 2006 20:12:10 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

- Convert pata_pdc2027x to the new reset mechanism (->probe_reset)
- Increased the version to 0.74

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Patch against the pata_drivers branch
(bbbd62abb51c5804e113859e5bdccb0c9e84250a).
For your review, thanks.

--- pdc074-0/drivers/scsi/pata_pdc2027x.c	2006-03-27 15:03:50.000000000 +0800
+++ pdc074/drivers/scsi/pata_pdc2027x.c	2006-03-27 15:19:05.000000000 +0800
@@ -36,7 +36,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.73"
+#define DRV_VERSION	"0.74"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -63,7 +63,7 @@ enum {
 
 static int pdc2027x_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static void pdc2027x_remove_one(struct pci_dev *pdev);
-static void pdc2027x_phy_reset(struct ata_port *ap);
+static int pdc2027x_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_post_set_mode(struct ata_port *ap);
@@ -155,7 +155,7 @@ static struct ata_port_operations pdc202
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= pdc2027x_phy_reset,
+	.probe_reset		= pdc2027x_probe_reset,
 
 	.check_atapi_dma	= pdc2027x_check_atapi_dma,
 	.bmdma_setup		= ata_bmdma_setup,
@@ -185,7 +185,7 @@ static struct ata_port_operations pdc202
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= pdc2027x_phy_reset,
+	.probe_reset		= pdc2027x_probe_reset,
 	.post_set_mode		= pdc2027x_post_set_mode,
 
 	.check_atapi_dma	= pdc2027x_check_atapi_dma,
@@ -210,7 +210,7 @@ static struct ata_port_info pdc2027x_por
 	{
 		.sht		= &pdc2027x_sht,
 		.host_flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
-		                  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		                  ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5, /* udma0-5 */
@@ -220,7 +220,7 @@ static struct ata_port_info pdc2027x_por
 	{
 		.sht		= &pdc2027x_sht,
 		.host_flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
-                        	  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+                        	  ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6, /* udma0-6 */
@@ -296,26 +296,43 @@ static inline int pdc2027x_port_enabled(
 }
 
 /**
- *	pdc2027x_phy_reset - Probe specified port on PATA host controller
- *	@ap: Port to probe
+ *	pdc2027x_probeinit - probeinit for PATA host controller
+ *	@ap: Target port
  *
- *	Probe PATA phy.
+ *	Probeinit including cable detection.
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
-static void pdc2027x_phy_reset(struct ata_port *ap)
+
+static void pdc2027x_probeinit(struct ata_port *ap)
+{
+	pdc2027x_cbl_detect(ap);
+	ata_std_probeinit(ap);
+}
+
+/**
+ *	pdc2027x_probe_reset - Perform reset on PATA port and classify
+ *	@ap: Port to reset
+ *	@classes: Resulting classes of attached devices
+ *
+ *	Reset PATA phy and classify attached devices.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static int pdc2027x_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
 	/* Check whether port enabled */
 	if (!pdc2027x_port_enabled(ap)) {
-		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return;
+		return 0;
 	}
 
-	pdc2027x_cbl_detect(ap);
-	ata_port_probe(ap);
-	ata_bus_reset(ap);
+	return ata_drive_probe_reset(ap, pdc2027x_probeinit,
+				     ata_std_softreset, NULL,
+				     ata_std_postreset, classes);
 }
 
 /**

