From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/7] sata_nv: improve irq handler
Date: Wed, 14 Jun 2006 06:31:04 +0900
Message-ID: <1150234264940-git-send-email-htejun@gmail.com>
References: <11502342632913-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:15557 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932286AbWFMVa6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 17:30:58 -0400
Received: by wr-out-0506.google.com with SMTP id 58so243227wri
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 14:30:58 -0700 (PDT)
In-Reply-To: <11502342632913-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Improve irq handler such that it considers irq_stat if available.
Note that this patch introduces the following two behavior changes.

* if irq_stat is available and device interrupt is not reported,
  BMDMA/TF registers are never quiried.

* if irq_stat is available and device interrupt is reported, irq
  handler will return IRQ_HANDLED regardless of BMDMA/TF status.

This change also makes later hotplug change easier to integrate.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |   55 +++++++++++++++++++++++++++++++++++-------------
 1 files changed, 40 insertions(+), 15 deletions(-)

77fddbda2987defb2491ba370746daa380bb5c11
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 93e74aa..f1218e5 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -291,33 +291,58 @@ static void ck804_clr_irq_status(struct 
 	writeb(0xff, host_set->mmio_base + NV_INT_STATUS_CK804);
 }
 
+static int nv_host_intr(struct ata_port *ap, int irq_stat_valid, u8 irq_stat)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	int handled;
+
+	/* bail out if not our interrupt */
+	if (irq_stat_valid && !(irq_stat & NV_INT_DEV))
+		return 0;
+
+	/* No request pending?  Clear interrupt status anyway, in case
+	 * there's one pending.
+	 */
+	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
+		ata_check_status(ap);
+		return irq_stat_valid;
+	}
+
+	handled = ata_host_intr(ap, qc);
+	if (unlikely(!handled) && irq_stat_valid) {
+		/* spurious interrupt, clear it */
+		ata_check_status(ap);
+		handled++;
+	}
+
+	return handled;
+}
+
 static irqreturn_t nv_interrupt (int irq, void *dev_instance,
 				 struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
+	struct nv_host_desc *host_desc = host_set->private_data;
+	int irq_stat_valid = 0;
+	u8 irq_stat = 0;
 	unsigned int i;
 	unsigned int handled = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
+	if (host_desc->get_irq_status) {
+		irq_stat_valid = 1;
+		irq_stat = host_desc->get_irq_status(host_set);
+	}
+
 	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap;
-
-		ap = host_set->ports[i];
-		if (ap &&
-		    !(ap->flags & ATA_FLAG_DISABLED)) {
-			struct ata_queued_cmd *qc;
-
-			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
-				handled += ata_host_intr(ap, qc);
-			else
-				// No request pending?  Clear interrupt status
-				// anyway, in case there's one pending.
-				ap->ops->check_status(ap);
-		}
+		struct ata_port *ap = host_set->ports[i];
+
+		if (ap && !(ap->flags & ATA_FLAG_DISABLED))
+			handled += nv_host_intr(ap, irq_stat_valid, irq_stat);
 
+		irq_stat >>= NV_INT_PORT_SHIFT;
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
-- 
1.3.2


