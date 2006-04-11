From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 16/16] libata-eh-fw: update ata_interrupt() to handle frozen port properly
Date: Tue, 11 Apr 2006 22:42:55 +0900
Message-ID: <1144762975582-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.227]:18071 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750904AbWDKNnJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:43:09 -0400
Received: by wproxy.gmail.com with SMTP id i11so925428wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:43:09 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update the stock interrupt handler such that it unconditionally clears
interrupts from a frozen port.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

07f4b12b7a523dc928576fd5a2f18f40969a47ee
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index c7b7de9..d4c75cb 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4517,12 +4517,20 @@ irqreturn_t ata_interrupt (int irq, void
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap;
+		struct ata_queued_cmd *qc;
 
 		ap = host_set->ports[i];
-		if (ap &&
-		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
-			struct ata_queued_cmd *qc;
+		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
+			continue;
 
+		if (unlikely(ap->flags & ATA_FLAG_FROZEN)) {
+			/* port frozen, ack unconditionally */
+			ata_irq_ack(ap, 0);
+			handled = 1;
+			continue;
+		}
+
+		if (!(ap->flags & ATA_FLAG_NOINTR)) {
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (qc && (!(qc->tf.ctl & ATA_NIEN)) &&
 			    (qc->flags & ATA_QCFLAG_ACTIVE))
-- 
1.2.4


