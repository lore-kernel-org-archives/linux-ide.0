From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/12] ata_piix: convert pata to new reset mechanism
Date: Tue, 24 Jan 2006 17:05:22 +0900
Message-ID: <11380899221712-git-send-email-htejun@gmail.com>
References: <1138089921565-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.196]:6342 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030353AbWAXIFf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 03:05:35 -0500
Received: by xproxy.gmail.com with SMTP id s14so770397wxc
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 00:05:35 -0800 (PST)
In-Reply-To: <1138089921565-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Convert ata_piix pata ->phy_reset to new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   46 ++++++++++++++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 16 deletions(-)

3e72273956b2974ad50165c34b278164fd4094d4
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index fc3ca05..657d3f3 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -129,7 +129,7 @@ enum {
 static int piix_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent);
 
-static void piix_pata_phy_reset(struct ata_port *ap);
+static int piix_pata_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void piix_sata_phy_reset(struct ata_port *ap);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
@@ -205,7 +205,7 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= piix_pata_phy_reset,
+	.probe_reset		= piix_pata_probe_reset,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -256,8 +256,7 @@ static struct ata_port_info piix_port_in
 	/* ich5_pata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
-				  PIIX_FLAG_CHECKINTR,
+		.host_flags	= ATA_FLAG_SLAVE_POSS | PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 #if 0
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
@@ -282,7 +281,7 @@ static struct ata_port_info piix_port_in
 	/* piix4_pata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.host_flags	= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 #if 0
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
@@ -363,30 +362,45 @@ cbl40:
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
+	return ata_drive_probe_reset(ap, ata_std_softreset, NULL,
+				     piix_pata_postreset, classes);
 }
 
 /**
-- 
1.1.3


