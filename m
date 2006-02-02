From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/11] ahci: convert to new reset mechanism
Date: Thu, 2 Feb 2006 18:20:00 +0900
Message-ID: <11388720001540-git-send-email-htejun@gmail.com>
References: <11388720003793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.201]:42947 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423406AbWBBJUJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 04:20:09 -0500
Received: by wproxy.gmail.com with SMTP id i27so431364wra
        for <linux-ide@vger.kernel.org>; Thu, 02 Feb 2006 01:20:09 -0800 (PST)
In-Reply-To: <11388720003793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert ahci ->phy_reset to new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |   47 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 30 insertions(+), 17 deletions(-)

bc104d8fbf1cc23220be6ae5e7a02881fe4fbfcd
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 1f81333..46dc3ae 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -190,7 +190,7 @@ static void ahci_scr_write (struct ata_p
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
-static void ahci_phy_reset(struct ata_port *ap);
+static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void ahci_irq_clear(struct ata_port *ap);
 static void ahci_eng_timeout(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
@@ -229,7 +229,7 @@ static const struct ata_port_operations 
 
 	.tf_read		= ahci_tf_read,
 
-	.phy_reset		= ahci_phy_reset,
+	.probe_reset		= ahci_probe_reset,
 
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
@@ -251,8 +251,7 @@ static const struct ata_port_info ahci_p
 	{
 		.sht		= &ahci_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
-				  ATA_FLAG_PIO_DMA,
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -515,28 +514,35 @@ static inline void ahci_fill_cmd_slot(st
 	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
 }
 
-static void ahci_phy_reset(struct ata_port *ap)
+static int ahci_hardreset(struct ata_port *ap, int verbose, unsigned int *class)
 {
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
-	struct ata_device *dev = &ap->device[0];
-	u32 new_tmp, tmp;
+	int rc;
+
+	DPRINTK("ENTER\n");
 
 	ahci_stop_engine(ap);
-	__sata_phy_reset(ap);
+	rc = sata_std_hardreset(ap, verbose, class);
 	ahci_start_engine(ap);
 
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		return;
+	if (rc == 0)
+		*class = ahci_dev_classify(ap);
+	if (*class == ATA_DEV_UNKNOWN)
+		*class = ATA_DEV_NONE;
 
-	dev->class = ahci_dev_classify(ap);
-	if (!ata_dev_present(dev)) {
-		ata_port_disable(ap);
-		return;
-	}
+	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
+	return rc;
+}
+
+static void ahci_postreset(struct ata_port *ap, unsigned int *class)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 new_tmp, tmp;
+
+	ata_std_postreset(ap, class);
 
 	/* Make sure port's ATAPI bit is set appropriately */
 	new_tmp = tmp = readl(port_mmio + PORT_CMD);
-	if (dev->class == ATA_DEV_ATAPI)
+	if (*class == ATA_DEV_ATAPI)
 		new_tmp |= PORT_CMD_ATAPI;
 	else
 		new_tmp &= ~PORT_CMD_ATAPI;
@@ -546,6 +552,13 @@ static void ahci_phy_reset(struct ata_po
 	}
 }
 
+static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
+{
+	return ata_drive_probe_reset(ap, ata_std_probeinit,
+				     NULL, ahci_hardreset,
+				     ahci_postreset, classes);
+}
+
 static u8 ahci_check_status(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
-- 
1.1.3


