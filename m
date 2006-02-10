From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/9] ata_piix: convert sata to new reset mechanism
Date: Fri, 10 Feb 2006 23:58:48 +0900
Message-ID: <11395835282018-git-send-email-htejun@gmail.com>
References: <11395835282719-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:12008 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932110AbWBJO7B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 09:59:01 -0500
Received: by pproxy.gmail.com with SMTP id o67so262866pye
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 06:58:58 -0800 (PST)
In-Reply-To: <11395835282719-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert ata_piix sata ->phy_reset to new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)

9314defd1d310a822bf491b60cddbf9d652ab6e0
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 650c687..0da8076 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
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
@@ -456,28 +454,29 @@ static int piix_sata_probe (struct ata_p
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
+	int i;
+
 	if (!piix_sata_probe(ap)) {
-		ata_port_disable(ap);
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			classes[i] = ATA_DEV_NONE;
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
-- 
1.1.5


