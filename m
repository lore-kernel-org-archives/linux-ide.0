From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/14] ata_piix: convert sata to new reset mechanism
Date: Sun, 18 Dec 2005 22:47:17 +0900
Message-ID: <20051218134717.GJ31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:40656 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965114AbVLRNrW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:47:22 -0500
Received: by zproxy.gmail.com with SMTP id 14so1715993nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:47:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Convert ata_piix sata ->phy_reset to ->soft_reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/ata_piix.c
===================================================================
--- work.orig/drivers/scsi/ata_piix.c	2005-12-18 19:06:17.000000000 +0900
+++ work/drivers/scsi/ata_piix.c	2005-12-18 19:33:56.000000000 +0900
@@ -133,7 +133,7 @@ static int piix_init_one (struct pci_dev
 
 static int piix_pata_softreset(struct ata_port *ap, unsigned int *classes);
 static void piix_pata_postreset(struct ata_port *ap, const unsigned int *classes);
-static void piix_sata_phy_reset(struct ata_port *ap);
+static int piix_sata_softreset(struct ata_port *ap, unsigned int *classes);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 
@@ -231,7 +231,8 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= piix_sata_phy_reset,
+	.soft_reset		= piix_sata_softreset,
+	.post_reset		= ata_std_postreset,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -268,8 +269,8 @@ static struct ata_port_info piix_port_in
 	/* ich5_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR,
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED |
+				  PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -293,8 +294,7 @@ static struct ata_port_info piix_port_in
 	/* ich6_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -305,8 +305,7 @@ static struct ata_port_info piix_port_in
 	/* ich6_sata_ahci */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
@@ -450,28 +449,26 @@ static int piix_sata_probe (struct ata_p
 }
 
 /**
- *	piix_sata_phy_reset - Probe specified port on SATA host controller
- *	@ap: Port to probe
+ *	piix_sata_softreset - Perform SRST softreset on SATA host controller
+ *	@ap: Port to reset
+ *	@classes: Resulting classes of attached devices
  *
- *	Probe SATA phy.
+ *	Softreset SATA phy.
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
 
-static void piix_sata_phy_reset(struct ata_port *ap)
+static int piix_sata_softreset(struct ata_port *ap, unsigned int *classes)
 {
 	if (!piix_sata_probe(ap)) {
-		ata_port_disable(ap);
+		classes[0] = ATA_DEV_NONE;
+		classes[1] = ATA_DEV_NONE;
 		printk(KERN_INFO "ata%u: SATA port has no device.\n", ap->id);
-		return;
+		return 0;
 	}
 
-	ap->cbl = ATA_CBL_SATA;
-
-	ata_port_probe(ap);
-
-	ata_bus_reset(ap);
+	return ata_std_softreset_srst(ap, classes);
 }
 
 /**
