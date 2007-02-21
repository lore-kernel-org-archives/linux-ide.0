From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 1/2] sata_vsc: factor the error and normal intr paths into
	separate routines
Date: Tue, 20 Feb 2007 18:21:27 -0700
Message-ID: <20070221012127.31723.99157.stgit@dwillia2-linux.ch.intel.com>
References: <20070221012109.31723.65182.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7457 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932319AbXBUBV2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 20:21:28 -0500
In-Reply-To: <20070221012109.31723.65182.stgit@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jeremy@sgi.com

Separate sata_vsc interrupt handling into a normal (per-port) path and an
error path with the addition of vsc_port_intr and vsc_error_intr
respectively.  The error path handles interrupt based
hotplug events which requires the definition of vsc_freeze and vsc_thaw.

Note: vsc_port_intr has a workaround for unexpected interrupts that occur
during an identify command.

Cc: Jeremy Higdon <jeremy@sgi.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/ata/sata_vsc.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 2fd037b..cc73797 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -96,6 +96,7 @@ enum {
 			      VSC_SATA_INT_ERROR_P    | VSC_SATA_INT_ERROR_R | \
 			      VSC_SATA_INT_ERROR_E    | VSC_SATA_INT_ERROR_M | \
 			      VSC_SATA_INT_PHY_CHANGE),
+	VSC_SATA_SERR_INVALID_FIS	= (1 << 25),
 };
 
 #define is_vsc_sata_int_err(port_idx, int_status) \
@@ -119,6 +120,26 @@ static void vsc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
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
 static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
 {
 	void __iomem *mask_addr;
@@ -203,6 +224,61 @@ static void vsc_sata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
         }
 }
 
+static void vsc_error_intr(struct ata_port *ap)
+{
+	u32 irq_stat;
+	struct ata_eh_info *ehi = &ap->eh_info;
+	int freeze = 0;
+
+	/* clear the error interrupt */
+	irq_stat = vsc_sata_scr_read(ap, SCR_ERROR);
+	vsc_sata_scr_write(ap, SCR_ERROR, irq_stat);
+
+	/* first, analyze and record host port events */
+	ata_ehi_clear_desc(ehi);
+
+	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
+
+	if (irq_stat & SERR_PHYRDY_CHG) {
+		ata_ehi_hotplugged(ehi);
+		ata_ehi_push_desc(ehi, ", PHY RDY changed");
+		freeze = 1;
+	}
+
+	if (irq_stat & VSC_SATA_SERR_INVALID_FIS) {
+		ehi->err_mask |= AC_ERR_HSM;
+		ehi->action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(ehi , ", unknown FIS");
+		freeze = 1;
+	}
+
+	/* freeze or abort */
+	if (freeze)
+		ata_port_freeze(ap);
+	else
+		ata_port_abort(ap);
+
+}
+
+static void vsc_port_intr(u8 port_status, struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc;
+
+	if (unlikely(port_status & VSC_SATA_INT_ERROR)) {
+		vsc_error_intr(ap);
+		return;
+	}
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (qc) {
+		if(likely(!(qc->tf.flags & ATA_TFLAG_POLLING)))
+			ata_host_intr(ap, qc);
+		else if (qc->tf.command == ATA_CMD_ID_ATA) {
+			/* handle quirky interrupts during identify */
+			ata_chk_status(ap);
+		}
+	}
+}
 
 /*
  * vsc_sata_interrupt
