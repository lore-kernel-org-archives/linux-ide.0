From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2.6.21-rc1 2/2] sata_vsc: clean up vsc_sata_interrupt
Date: Wed, 21 Feb 2007 10:56:52 -0700
Message-ID: <20070221175652.21231.18391.stgit@dwillia2-linux.ch.intel.com>
References: <20070221175354.21231.15372.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47437 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422743AbXBUR4x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Feb 2007 12:56:53 -0500
In-Reply-To: <20070221175354.21231.15372.stgit@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jeremy@sgi.com

1/ Clean up vsc_sata_interrupt and have it call vsc_port_intr to handle the
   interrupt.
2/ Hook up vsc_freeze and vsc_thaw in vsc_sata_ops
3/ Remove the now unnecessary is_vsc_sata_int_err

Tested with an iq3124h PCI-X add-in card on an iop13xx.

Changes in take2
* revert changes to vsc_intr_mask_update (vsc_thaw enables all interrupts)
* use unlikely() for the pci-abort and not-our-interrupt cases in
  vsc_sata_interrupt
* move vsc_freeze and vsc_thaw into this patch

Cc: Jeremy Higdon <jeremy@sgi.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/ata/sata_vsc.c |   91 ++++++++++++++++++++++--------------------------
 1 files changed, 42 insertions(+), 49 deletions(-)

diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 6a0c9cf..0c68740 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -98,10 +98,6 @@ enum {
 			      VSC_SATA_INT_PHY_CHANGE),
 };
 
-#define is_vsc_sata_int_err(port_idx, int_status) \
-	 (int_status & (VSC_SATA_INT_ERROR << (8 * port_idx)))
-
-
 static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)
@@ -119,6 +115,28 @@ static void vsc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
 }
 
 
+static void vsc_freeze(struct ata_port *ap)
+{
+	void __iomem *mask_addr;
+
+	mask_addr = ap->host->iomap[VSC_MMIO_BAR] +
+		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
+
+	writeb(0, mask_addr);
+}
+
+
+static void vsc_thaw(struct ata_port *ap)
+{
+	void __iomem *mask_addr;
+
+	mask_addr = ap->host->iomap[VSC_MMIO_BAR] +
+		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
+
+	writeb(0xff, mask_addr);
+}
+
+
 static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
 {
 	void __iomem *mask_addr;
@@ -244,59 +262,34 @@ static irqreturn_t vsc_sata_interrupt (int irq, void *dev_instance)
 	struct ata_host *host = dev_instance;
 	unsigned int i;
 	unsigned int handled = 0;
-	u32 int_status;
-
-	spin_lock(&host->lock);
+	u32 status;
 
-	int_status = readl(host->iomap[VSC_MMIO_BAR] +
-			   VSC_SATA_INT_STAT_OFFSET);
+	status = readl(host->iomap[VSC_MMIO_BAR] + VSC_SATA_INT_STAT_OFFSET);
 
-	for (i = 0; i < host->n_ports; i++) {
-		if (int_status & ((u32) 0xFF << (8 * i))) {
-			struct ata_port *ap;
+	if (unlikely(status == 0xffffffff || status == 0)) {
+		status && printk(KERN_ERR DRV_NAME ": IRQ status == 0xffffffff, "
+			"PCI fault or device removal?\n");
+		goto out;
+	}
 
-			ap = host->ports[i];
+	spin_lock(&host->lock);
 
-			if (is_vsc_sata_int_err(i, int_status)) {
-				u32 err_status;
-				printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
-				err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
-				vsc_sata_scr_write(ap, SCR_ERROR, err_status);
-				handled++;
-			}
+	for (i = 0; i < host->n_ports; i++) {
+		u8 port_status = (status >> (8 * i)) & 0xff;
+		if (port_status) {
+			struct ata_port *ap = host->ports[i];
 
 			if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
-				struct ata_queued_cmd *qc;
-
-				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
-					handled += ata_host_intr(ap, qc);
-				else if (is_vsc_sata_int_err(i, int_status)) {
-					/*
-					 * On some chips (i.e. Intel 31244), an error
-					 * interrupt will sneak in at initialization
-					 * time (phy state changes).  Clearing the SCR
-					 * error register is not required, but it prevents
-					 * the phy state change interrupts from recurring
-					 * later.
-					 */
-					u32 err_status;
-					err_status = vsc_sata_scr_read(ap, SCR_ERROR);
-					printk(KERN_DEBUG "%s: clearing interrupt, "
-					       "status %x; sata err status %x\n",
-					       __FUNCTION__,
-					       int_status, err_status);
-					vsc_sata_scr_write(ap, SCR_ERROR, err_status);
-					/* Clear interrupt status */
-					ata_chk_status(ap);
-					handled++;
-				}
-			}
+				vsc_port_intr(port_status, ap);
+				handled++;
+			} else
+				printk(KERN_ERR DRV_NAME
+					": interrupt from disabled port %d\n", i);
 		}
 	}
 
 	spin_unlock(&host->lock);
-
+out:
 	return IRQ_RETVAL(handled);
 }
 
@@ -334,8 +327,8 @@ static const struct ata_port_operations vsc_sata_ops = {
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
+	.freeze			= vsc_freeze,
+	.thaw			= vsc_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= vsc_sata_interrupt,
