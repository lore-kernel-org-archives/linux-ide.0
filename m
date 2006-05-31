From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] sata_sil: new interrupt handler
Date: Wed, 31 May 2006 20:11:27 +0900
Message-ID: <11490738873199-git-send-email-htejun@gmail.com>
References: <11490738873808-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:27942 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964983AbWEaLLe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:11:34 -0400
Received: by wx-out-0102.google.com with SMTP id h27so3993wxd
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:11:34 -0700 (PDT)
In-Reply-To: <11490738873808-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

The DMA complete bit of these controllers reflects ATA IRQ status
while no DMA command is in progress.  So, we can tell whether the
controller is raising an interrupt or not in deterministic manner.
This patch gives sata_sil its own interrupt handler which behaves much
better than the original one in terms of error detection and handling.
This change is also necessary for later hotplug support.

Further improvements are possible, in both 2 and 4 ports versions, we
can get all status with only one readl and using custom bmdma
operations can further cut down register accesses.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 91 insertions(+), 1 deletions(-)

cbe88fbc72d9e1aa4a6f994cb6e19fa08ae5a0ba
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index f926883..03c1d1b 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -111,6 +111,8 @@ static void sil_dev_config(struct ata_po
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void sil_post_set_mode (struct ata_port *ap);
+static irqreturn_t sil_interrupt(int irq, void *dev_instance,
+				 struct pt_regs *regs);
 static void sil_freeze(struct ata_port *ap);
 static void sil_thaw(struct ata_port *ap);
 
@@ -196,7 +198,7 @@ static const struct ata_port_operations 
 	.thaw			= sil_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.irq_handler		= ata_interrupt,
+	.irq_handler		= sil_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
@@ -336,6 +338,94 @@ static void sil_scr_write (struct ata_po
 		writel(val, mmio);
 }
 
+static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	u8 status;
+
+	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN))
+		goto freeze;
+
+	/* Check whether we are expecting interrupt in this state */
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
+		/* Some pre-ATAPI-4 devices assert INTRQ
+		 * at this state when ready to receive CDB.
+		 */
+
+		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
+		 * The flag was turned on only for atapi devices.
+		 * No need to check is_atapi_taskfile(&qc->tf) again.
+		 */
+		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+			goto err_hsm;
+		break;
+	case HSM_ST_LAST:
+		if (qc->tf.protocol == ATA_PROT_DMA ||
+		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
+			/* clear DMA-Start bit */
+			ap->ops->bmdma_stop(qc);
+
+			if (bmdma2 & SIL_DMA_ERROR) {
+				qc->err_mask |= AC_ERR_HOST_BUS;
+				ap->hsm_task_state = HSM_ST_ERR;
+			}
+		}
+		break;
+	case HSM_ST:
+		break;
+	default:
+		goto err_hsm;
+	}
+
+	/* check main status, clearing INTRQ */
+	status = ata_chk_status(ap);
+	if (unlikely(status & ATA_BUSY))
+		goto err_hsm;
+
+	/* ack bmdma irq events */
+	ata_bmdma_irq_clear(ap);
+
+	/* kick HSM in the ass */
+	ata_hsm_move(ap, qc, status, 0);
+
+	return;
+
+ err_hsm:
+	qc->err_mask |= AC_ERR_HSM;
+ freeze:
+	ata_port_freeze(ap);
+}
+
+static irqreturn_t sil_interrupt(int irq, void *dev_instance,
+				 struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	void __iomem *mmio_base = host_set->mmio_base;
+	int handled = 0;
+	int i;
+
+	spin_lock(&host_set->lock);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+		u32 bmdma2 = readl(mmio_base + sil_port[ap->port_no].bmdma2);
+
+		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
+			continue;
+
+		if (!(bmdma2 & SIL_DMA_COMPLETE))
+			continue;
+
+		sil_host_intr(ap, bmdma2);
+		handled = 1;
+	}
+
+	spin_unlock(&host_set->lock);
+
+	return IRQ_RETVAL(handled);
+}
+
 static void sil_freeze(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host_set->mmio_base;
-- 
1.3.2


