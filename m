From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/14] ata_piix: convert pata to new reset mechanism
Date: Sun, 18 Dec 2005 22:46:13 +0900
Message-ID: <20051218134613.GI31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:61348 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965113AbVLRNqS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:46:18 -0500
Received: by zproxy.gmail.com with SMTP id 13so1084725nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:46:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Convert ata_piix pata ->phy_reset to ->soft_reset.

--

NOTE: piix patches are against upstream + piix MAPVALUE fix I posted
earlier today.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/ata_piix.c
===================================================================
--- work.orig/drivers/scsi/ata_piix.c	2005-12-18 21:11:44.000000000 +0900
+++ work/drivers/scsi/ata_piix.c	2005-12-18 21:11:58.000000000 +0900
@@ -131,7 +131,8 @@ enum {
 static int piix_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent);
 
-static void piix_pata_phy_reset(struct ata_port *ap);
+static int piix_pata_softreset(struct ata_port *ap, unsigned int *classes);
+static void piix_pata_postreset(struct ata_port *ap, const unsigned int *classes);
 static void piix_sata_phy_reset(struct ata_port *ap);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
@@ -201,7 +202,8 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= piix_pata_phy_reset,
+	.soft_reset		= piix_pata_softreset,
+	.post_reset		= piix_pata_postreset,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -252,8 +254,7 @@ static struct ata_port_info piix_port_in
 	/* ich5_pata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
-				  PIIX_FLAG_CHECKINTR,
+		.host_flags	= ATA_FLAG_SLAVE_POSS | PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 #if 0
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
@@ -278,7 +279,7 @@ static struct ata_port_info piix_port_in
 	/* piix4_pata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.host_flags	= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 #if 0
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
@@ -360,30 +361,45 @@ cbl40:
 }
 
 /**
- *	piix_pata_phy_reset - Probe specified port on PATA host controller
- *	@ap: Port to probe
+ *	piix_pata_softreset - Perform SRST softreset on PATA host controller
+ *	@ap: Port to reset
+ *	@classes: Resulting classes of attached devices
  *
- *	Probe PATA phy.
+ *	Softreset PATA phy.
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
 
-static void piix_pata_phy_reset(struct ata_port *ap)
+static int piix_pata_softreset(struct ata_port *ap, unsigned int *classes)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
-		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return;
+		classes[0] = ATA_DEV_NONE;
+		classes[1] = ATA_DEV_NONE;
+		return 0;
 	}
 
-	piix_pata_cbl_detect(ap);
+	return ata_std_softreset_srst(ap, classes);
+}
 
-	ata_port_probe(ap);
+/**
+ *	piix_pata_postreset - Postreset stuff on PATA host controller
+ *	@ap: Target port
+ *	@classes: Classes of attached devices
+ *
+ *	Postreset processing including cable detection.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
 
-	ata_bus_reset(ap);
+static void piix_pata_postreset(struct ata_port *ap, const unsigned int *classes)
+{
+	piix_pata_cbl_detect(ap);
+	ata_std_postreset(ap, classes);
 }
 
 /**
