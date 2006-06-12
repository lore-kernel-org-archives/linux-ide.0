From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil: update device hotplug handling
Date: Mon, 12 Jun 2006 14:18:22 +0900
Message-ID: <20060612051822.GE9166@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:38793 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751354AbWFLFS1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 01:18:27 -0400
Received: by py-out-1112.google.com with SMTP id x31so1575751pye
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2006 22:18:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Some flavors of 3112 cannot mask SATA_IRQ reliably and ends up
scheduling hotplug event during hardreset.  This patch makes sata_sil
simply use SError hotplug event handling in libata core layer.

This patch also makes sil_interrupt() clear interrupt before freezing.
Without this, some 3112 controllers cause interrupt storms.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

3338e8a25e5245a3aad7ad0d4d79a44faa918eb2
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 0898cbe..00906ab 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -343,12 +343,8 @@ static void sil_host_intr(struct ata_por
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	u8 status;
 
-	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
-		ata_ehi_hotplugged(&ap->eh_info);
-		goto freeze;
-	}
-
-	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN))
+	if (unlikely((bmdma2 & SIL_DMA_SATA_IRQ) ||
+		     (!qc || qc->tf.ctl & ATA_NIEN)))
 		goto freeze;
 
 	/* Check whether we are expecting interrupt in this state */
@@ -399,6 +395,7 @@ static void sil_host_intr(struct ata_por
  err_hsm:
 	qc->err_mask |= AC_ERR_HSM;
  freeze:
+	ata_bmdma_irq_clear(ap);
 	ata_port_freeze(ap);
 }
 
-- 
1.3.2

