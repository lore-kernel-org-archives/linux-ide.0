From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] ata_piix: convert sata to new reset mechanism
Date: Wed, 15 Feb 2006 15:01:42 +0900
Message-ID: <11399833021578-git-send-email-htejun@gmail.com>
References: <11399833022059-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:9527 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422996AbWBOGBt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 01:01:49 -0500
Received: by pproxy.gmail.com with SMTP id x66so1439417pye
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2006 22:01:46 -0800 (PST)
In-Reply-To: <11399833022059-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert ata_piix sata ->phy_reset to new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   35 +++++++++++++++--------------------
 1 files changed, 15 insertions(+), 20 deletions(-)

97913404ed0525f85fd23e20e321fe31a9487267
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index d79c252..c662bf5 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -132,7 +132,7 @@ static int piix_init_one (struct pci_dev
 				    const struct pci_device_id *ent);
 
 static int piix_pata_probe_reset(struct ata_port *ap, unsigned int *classes);
-static void piix_sata_phy_reset(struct ata_port *ap);
+static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 
@@ -235,7 +235,7 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= piix_sata_phy_reset,
+	.probe_reset		= piix_sata_probe_reset,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -272,8 +272,8 @@ static struct ata_port_info piix_port_in
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
@@ -297,8 +297,7 @@ static struct ata_port_info piix_port_in
 	/* ich6_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -309,8 +308,7 @@ static struct ata_port_info piix_port_in
 	/* ich6_sata_ahci */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
@@ -448,28 +446,25 @@ static int piix_sata_probe (struct ata_p
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
-- 
1.1.5


