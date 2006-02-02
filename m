From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/11] ata_piix: convert pata to new reset mechanism
Date: Thu, 2 Feb 2006 18:20:00 +0900
Message-ID: <11388720002922-git-send-email-htejun@gmail.com>
References: <11388720003793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:50372 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423403AbWBBJUK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 04:20:10 -0500
Received: by wproxy.gmail.com with SMTP id i23so356487wra
        for <linux-ide@vger.kernel.org>; Thu, 02 Feb 2006 01:20:09 -0800 (PST)
In-Reply-To: <11388720003793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert ata_piix pata ->phy_reset to new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   47 +++++++++++++++++++++++++++++++----------------
 1 files changed, 31 insertions(+), 16 deletions(-)

4c83a0664401bd8a04813e810eb1a828f0aeafb2
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 49cc420..f4215c9 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -131,7 +131,7 @@ enum {
 static int piix_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent);
 
-static void piix_pata_phy_reset(struct ata_port *ap);
+static int piix_pata_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void piix_sata_phy_reset(struct ata_port *ap);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
@@ -207,7 +207,7 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= piix_pata_phy_reset,
+	.probe_reset		= piix_pata_probe_reset,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -258,8 +258,7 @@ static struct ata_port_info piix_port_in
 	/* ich5_pata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
-				  PIIX_FLAG_CHECKINTR,
+		.host_flags	= ATA_FLAG_SLAVE_POSS | PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 #if 0
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
@@ -284,7 +283,7 @@ static struct ata_port_info piix_port_in
 	/* piix4_pata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.host_flags	= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 #if 0
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
@@ -366,30 +365,46 @@ cbl40:
 }
 
 /**
- *	piix_pata_phy_reset - Probe specified port on PATA host controller
- *	@ap: Port to probe
+ *	piix_pata_postreset - Postreset stuff on PATA host controller
+ *	@ap: Target port
+ *	@classes: Classes of attached devices
  *
- *	Probe PATA phy.
+ *	Postreset processing including cable detection.
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
+static void piix_pata_postreset(struct ata_port *ap, unsigned int *classes)
+{
+	piix_pata_cbl_detect(ap);
+	ata_std_postreset(ap, classes);
+}
 
-static void piix_pata_phy_reset(struct ata_port *ap)
+/**
+ *	piix_pata_probe_reset - Perform reset on PATA port and classify
+ *	@ap: Port to reset
+ *	@classes: Resulting classes of attached devices
+ *
+ *	Reset PATA phy and classify attached devices.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+static int piix_pata_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	int i;
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
-		ata_port_disable(ap);
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			classes[i] = ATA_DEV_NONE;
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return;
+		return 0;
 	}
 
-	piix_pata_cbl_detect(ap);
-
-	ata_port_probe(ap);
-
-	ata_bus_reset(ap);
+	return ata_drive_probe_reset(ap, ata_std_probeinit,
+				     ata_std_softreset, NULL,
+				     piix_pata_postreset, classes);
 }
 
 /**
-- 
1.1.3


