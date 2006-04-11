From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/15] sata_sil: new interrupt handler
Date: Tue, 11 Apr 2006 23:14:08 +0900
Message-ID: <11447648483027-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:19875 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751294AbWDKOOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:14 -0400
Received: by zproxy.gmail.com with SMTP id o37so1102564nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:14 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
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

 drivers/scsi/sata_sil.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 81 insertions(+), 1 deletions(-)

cae31a3e780bd2cef46e299e6bf681af88d7f51d
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index e46c044..0b72585 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -112,6 +112,8 @@ static u32 sil_scr_read (struct ata_port
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int sil_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void sil_post_set_mode (struct ata_port *ap);
+static irqreturn_t sil_interrupt(int irq, void *dev_instance,
+				 struct pt_regs *regs);
 static void sil_freeze(struct ata_port *ap);
 static void sil_error_handler(struct ata_port *ap);
 
@@ -197,7 +199,7 @@ static const struct ata_port_operations 
 	.freeze			= sil_freeze,
 	.error_handler		= sil_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.irq_handler		= ata_interrupt,
+	.irq_handler		= sil_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
@@ -357,6 +359,84 @@ static int sil_probe_reset(struct ata_po
 				     sil_postreset, classes);
 }
 
+static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	u8 status;
+
+	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN))
+		goto freeze;
+
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+	case ATA_PROT_ATAPI_DMA:
+	case ATA_PROT_ATAPI:
+		if (bmdma2 & SIL_DMA_ERROR) {
+			qc->err_mask |= AC_ERR_HOST_BUS;
+			goto freeze;
+		}
+
+		/* clear DMA-Start bit */
+		ap->ops->bmdma_stop(qc);
+
+		/* fall through */
+	case ATA_PROT_ATAPI_NODATA:
+	case ATA_PROT_NODATA:
+		/* check main status, clearing INTRQ */
+		status = ata_chk_status(ap);
+		if (unlikely(status & ATA_BUSY)) {
+			qc->err_mask |= AC_ERR_HSM;
+			goto freeze;
+		}
+
+		/* ack bmdma irq events */
+		ap->ops->irq_clear(ap);
+
+		/* complete taskfile transaction */
+		qc->err_mask |= ac_err_mask(status);
+		ata_qc_complete(qc);
+		break;
+
+	default:
+		goto freeze;
+	}
+	return;
+
+ freeze:
+	ata_eh_schedule_port(ap, ATA_EH_FREEZE);
+}
+
+static irqreturn_t sil_interrupt(int irq, void *dev_instance,
+				 struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	void __iomem *mmio_base = host_set->mmio_base;
+	int handled = 0;
+	unsigned long flags;
+	int i;
+
+	/* TODO: make _irqsave conditional on x86 PCI IDE legacy mode */
+	spin_lock_irqsave(&host_set->lock, flags);
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
+	spin_unlock_irqrestore(&host_set->lock, flags);
+
+	return IRQ_RETVAL(handled);
+}
+
 static void sil_freeze(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host_set->mmio_base;
-- 
1.2.4


