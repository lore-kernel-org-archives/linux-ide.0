From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/12] ahci: convert to new reset mechanism
Date: Tue, 24 Jan 2006 17:05:22 +0900
Message-ID: <1138089922760-git-send-email-htejun@gmail.com>
References: <1138089921565-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:54862 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932426AbWAXIZt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 03:25:49 -0500
Received: by zproxy.gmail.com with SMTP id z6so1193712nzd
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 00:25:49 -0800 (PST)
In-Reply-To: <1138089921565-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Convert ahci ->phy_reset to new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |   46 +++++++++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 17 deletions(-)

73d592b3ebb6520d3f87b1cfcd94c323be2d8889
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 66402ef..c5a1ba6 100644
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
@@ -511,28 +510,35 @@ static inline void ahci_fill_cmd_slot(st
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
@@ -542,6 +548,12 @@ static void ahci_phy_reset(struct ata_po
 	}
 }
 
+static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
+{
+	return ata_drive_probe_reset(ap, NULL, ahci_hardreset,
+				     ahci_postreset, classes);
+}
+
 static u8 ahci_check_status(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
-- 
1.1.3


