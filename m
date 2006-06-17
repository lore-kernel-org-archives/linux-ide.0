From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/6] sata_nv: convert to new EH
Date: Sat, 17 Jun 2006 15:49:56 +0900
Message-ID: <11505269962838-git-send-email-htejun@gmail.com>
References: <11505269953650-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:23604 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932464AbWFQGuE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 02:50:04 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1303342nze
        for <linux-ide@vger.kernel.org>; Fri, 16 Jun 2006 23:50:04 -0700 (PDT)
In-Reply-To: <11505269953650-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert to new EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |  115 +++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 89 insertions(+), 26 deletions(-)

2f2aa6fb450c5bbd2cbf3f1aea1f66e6cd6c5f3e
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 94cb179..2a1bd85 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -68,6 +68,9 @@ enum {
 
 	NV_INT_PORT_SHIFT		= 4,	/* each port occupies 4 bits */
 
+	NV_INT_ALL			= 0x0f,
+	NV_INT_MASK			= NV_INT_DEV,
+
 	/* INT_CONFIG */
 	NV_INT_CONFIG			= 0x12,
 	NV_INT_CONFIG_METHD		= 0x01, // 0 = INT, 1 = SMI
@@ -88,6 +91,12 @@ static irqreturn_t nv_ck804_interrupt(in
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
+static void nv_nf2_freeze(struct ata_port *ap);
+static void nv_nf2_thaw(struct ata_port *ap);
+static void nv_ck804_freeze(struct ata_port *ap);
+static void nv_ck804_thaw(struct ata_port *ap);
+static void nv_error_handler(struct ata_port *ap);
+
 enum nv_host_type
 {
 	GENERIC,
@@ -166,14 +175,16 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.check_status		= ata_check_status,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= nv_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_generic_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -191,14 +202,16 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.check_status		= ata_check_status,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= nv_nf2_freeze,
+	.thaw			= nv_nf2_thaw,
+	.error_handler		= nv_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_nf2_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -216,14 +229,16 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.check_status		= ata_check_status,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= nv_ck804_freeze,
+	.thaw			= nv_ck804_thaw,
+	.error_handler		= nv_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_ck804_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -234,22 +249,11 @@ static const struct ata_port_operations 
 	.host_stop		= nv_ck804_host_stop,
 };
 
-/* FIXME: The hardware provides the necessary SATA PHY controls
- * to support ATA_FLAG_SATA_RESET.  However, it is currently
- * necessary to disable that flag, to solve misdetection problems.
- * See http://bugme.osdl.org/show_bug.cgi?id=3352 for more info.
- *
- * This problem really needs to be investigated further.  But in the
- * meantime, we avoid ATA_FLAG_SATA_RESET to get people working.
- */
 static struct ata_port_info nv_port_info[] = {
 	/* generic */
 	{
 		.sht		= &nv_sht,
-		.host_flags	= ATA_FLAG_SATA |
-				  /* ATA_FLAG_SATA_RESET | */
-				  ATA_FLAG_SRST |
-				  ATA_FLAG_NO_LEGACY,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -258,10 +262,7 @@ static struct ata_port_info nv_port_info
 	/* nforce2/3 */
 	{
 		.sht		= &nv_sht,
-		.host_flags	= ATA_FLAG_SATA |
-				  /* ATA_FLAG_SATA_RESET | */
-				  ATA_FLAG_SRST |
-				  ATA_FLAG_NO_LEGACY,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -270,10 +271,7 @@ static struct ata_port_info nv_port_info
 	/* ck804 */
 	{
 		.sht		= &nv_sht,
-		.host_flags	= ATA_FLAG_SATA |
-				  /* ATA_FLAG_SATA_RESET | */
-				  ATA_FLAG_SRST |
-				  ATA_FLAG_NO_LEGACY,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -410,6 +408,71 @@ static void nv_scr_write (struct ata_por
 	iowrite32(val, (void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
+static void nv_nf2_freeze(struct ata_port *ap)
+{
+	unsigned long scr_addr = ap->host_set->ports[0]->ioaddr.scr_addr;
+	int shift = ap->port_no * NV_INT_PORT_SHIFT;
+	u8 mask;
+
+	mask = inb(scr_addr + NV_INT_ENABLE);
+	mask &= ~(NV_INT_ALL << shift);
+	outb(mask, scr_addr + NV_INT_ENABLE);
+}
+
+static void nv_nf2_thaw(struct ata_port *ap)
+{
+	unsigned long scr_addr = ap->host_set->ports[0]->ioaddr.scr_addr;
+	int shift = ap->port_no * NV_INT_PORT_SHIFT;
+	u8 mask;
+
+	outb(NV_INT_ALL << shift, scr_addr + NV_INT_STATUS);
+
+	mask = inb(scr_addr + NV_INT_ENABLE);
+	mask |= (NV_INT_MASK << shift);
+	outb(mask, scr_addr + NV_INT_ENABLE);
+}
+
+static void nv_ck804_freeze(struct ata_port *ap)
+{
+	void __iomem *mmio_base = ap->host_set->mmio_base;
+	int shift = ap->port_no * NV_INT_PORT_SHIFT;
+	u8 mask;
+
+	mask = readb(mmio_base + NV_INT_ENABLE_CK804);
+	mask &= ~(NV_INT_ALL << shift);
+	writeb(mask, mmio_base + NV_INT_ENABLE_CK804);
+}
+
+static void nv_ck804_thaw(struct ata_port *ap)
+{
+	void __iomem *mmio_base = ap->host_set->mmio_base;
+	int shift = ap->port_no * NV_INT_PORT_SHIFT;
+	u8 mask;
+
+	writeb(NV_INT_ALL << shift, mmio_base + NV_INT_STATUS_CK804);
+
+	mask = readb(mmio_base + NV_INT_ENABLE_CK804);
+	mask |= (NV_INT_MASK << shift);
+	writeb(mask, mmio_base + NV_INT_ENABLE_CK804);
+}
+
+static int nv_hardreset(struct ata_port *ap, unsigned int *class)
+{
+	unsigned int dummy;
+
+	/* SATA hardreset fails to retrieve proper device signature on
+	 * some controllers.  Don't classify on hardreset.  For more
+	 * info, see http://bugme.osdl.org/show_bug.cgi?id=3352
+	 */
+	return sata_std_hardreset(ap, &dummy);
+}
+
+static void nv_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
+			   nv_hardreset, ata_std_postreset);
+}
+
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
-- 
1.3.2


