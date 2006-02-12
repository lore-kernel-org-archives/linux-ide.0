From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: convert sata to new reset mechanism
Date: Sun, 12 Feb 2006 15:08:03 +0900
Message-ID: <20060212060803.GC20025@htj.dyndns.org>
References: <20060212060637.GB20025@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:35719 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964819AbWBLGIH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 01:08:07 -0500
Received: by zproxy.gmail.com with SMTP id 4so768656nzn
        for <linux-ide@vger.kernel.org>; Sat, 11 Feb 2006 22:08:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20060212060637.GB20025@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

[PATCH] ata_piix: convert sata to new reset mechanism

Convert ata_piix sata ->phy_reset to new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

 ata_piix.c |   35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

Index: work1/drivers/scsi/ata_piix.c
===================================================================
--- work1.orig/drivers/scsi/ata_piix.c	2006-02-12 14:35:06.000000000 +0900
+++ work1/drivers/scsi/ata_piix.c	2006-02-12 14:35:44.000000000 +0900
@@ -132,7 +132,7 @@ static int piix_init_one (struct pci_dev
 				    const struct pci_device_id *ent);
 
 static int piix_pata_probe_reset(struct ata_port *ap, unsigned int *classes);
-static void piix_sata_phy_reset(struct ata_port *ap);
+static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 
@@ -236,7 +236,7 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= piix_sata_phy_reset,
+	.probe_reset		= piix_sata_probe_reset,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -273,8 +273,8 @@ static struct ata_port_info piix_port_in
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
@@ -298,8 +298,7 @@ static struct ata_port_info piix_port_in
 	/* ich6_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -310,8 +309,7 @@ static struct ata_port_info piix_port_in
 	/* ich6_sata_ahci */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
@@ -453,28 +451,25 @@ static int piix_sata_probe (struct ata_p
 }
 
 /**
- *	piix_sata_phy_reset - Probe specified port on SATA host controller
- *	@ap: Port to probe
+ *	piix_sata_probe_reset - Perform reset on SATA port and classify
+ *	@ap: Port to reset
+ *	@classes: Resulting classes of attached devices
  *
- *	Probe SATA phy.
+ *	Reset SATA phy and classify attached devices.
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
-
-static void piix_sata_phy_reset(struct ata_port *ap)
+static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
 	if (!piix_sata_probe(ap)) {
-		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: SATA port has no device.\n", ap->id);
-		return;
+		return 0;
 	}
 
-	ap->cbl = ATA_CBL_SATA;
-
-	ata_port_probe(ap);
-
-	ata_bus_reset(ap);
+	return ata_drive_probe_reset(ap, ata_std_probeinit,
+				     ata_std_softreset, NULL,
+				     ata_std_postreset, classes);
 }
 
 /**
