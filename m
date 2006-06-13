From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/7] sata_nv: implement new EH
Date: Wed, 14 Jun 2006 06:31:04 +0900
Message-ID: <11502342643505-git-send-email-htejun@gmail.com>
References: <11502342632913-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:15545 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932321AbWFMVbA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 17:31:00 -0400
Received: by py-out-1112.google.com with SMTP id i49so160763pye
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 14:31:00 -0700 (PDT)
In-Reply-To: <11502342632913-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement new EH.  freeze/thaw are performed by manipulating irq
enable on supported controllers.  On controllers which don't have irq
registers, stock BMDMA routines are used.

As SATA phy reset on some controllers fails to report proper device
signature, this patch defines nv_hardreset() which performs standard
SATA phy reset but doesn't perform classification.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |   78 +++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 64 insertions(+), 14 deletions(-)

da96be7f2eec90ebd3944b8106e4b351a7f311d8
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index f1218e5..b041c13 100644
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
@@ -90,6 +93,9 @@ static void ck804_clr_irq_status(struct 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t nv_interrupt (int irq, void *dev_instance,
 				 struct pt_regs *regs);
+static void nv_freeze (struct ata_port *ap);
+static void nv_thaw (struct ata_port *ap);
+static void nv_error_handler (struct ata_port *ap);
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void nv_host_stop (struct ata_host_set *host_set);
@@ -207,14 +213,16 @@ static const struct ata_port_operations 
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
+	.freeze			= nv_freeze,
+	.thaw			= nv_thaw,
+	.error_handler		= nv_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -225,20 +233,9 @@ static const struct ata_port_operations 
 	.host_stop		= nv_host_stop,
 };
 
-/* FIXME: The hardware provides the necessary SATA PHY controls
- * to support ATA_FLAG_SATA_RESET.  However, it is currently
- * necessary to disable that flag, to solve misdetection problems.
- * See http://bugme.osdl.org/show_bug.cgi?id=3352 for more info.
- *
- * This problem really needs to be investigated further.  But in the
- * meantime, we avoid ATA_FLAG_SATA_RESET to get people working.
- */
 static struct ata_port_info nv_port_info = {
 	.sht		= &nv_sht,
-	.host_flags	= ATA_FLAG_SATA |
-			  /* ATA_FLAG_SATA_RESET | */
-			  ATA_FLAG_SRST |
-			  ATA_FLAG_NO_LEGACY,
+	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask	= NV_PIO_MASK,
 	.mwdma_mask	= NV_MWDMA_MASK,
 	.udma_mask	= NV_UDMA_MASK,
@@ -350,6 +347,59 @@ static irqreturn_t nv_interrupt (int irq
 	return IRQ_RETVAL(handled);
 }
 
+static void nv_freeze (struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host_desc *host_desc = host_set->private_data;
+	int shift = ap->port_no * NV_INT_PORT_SHIFT;
+	u8 mask;
+
+	if (!host_desc->get_irq_mask) {
+		ata_bmdma_freeze(ap);
+		return;
+	}
+
+	mask = host_desc->get_irq_mask(host_set);
+	mask &= ~(NV_INT_ALL << shift);
+	host_desc->set_irq_mask(host_set, mask);
+}
+
+static void nv_thaw (struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host_desc *host_desc = host_set->private_data;
+	int shift = ap->port_no * NV_INT_PORT_SHIFT;
+	u8 mask;
+
+	if (!host_desc->get_irq_mask) {
+		ata_bmdma_thaw(ap);
+		return;
+	}
+
+	host_desc->clr_irq_status(host_set);
+
+	mask = host_desc->get_irq_mask(host_set);
+	mask |= (NV_INT_MASK << shift);
+	host_desc->set_irq_mask(host_set, mask);
+}
+
+static int nv_hardreset (struct ata_port *ap, unsigned int *class)
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
+static void nv_error_handler (struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
+			   nv_hardreset, ata_std_postreset);
+}
+
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)
-- 
1.3.2


