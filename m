From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/13] libata: update ata_interrupt() to handle frozen port properly
Date: Mon, 3 Apr 2006 03:31:10 +0900
Message-ID: <1144002670221-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:27419 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751329AbWDBSbV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:21 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550553nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:20 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update the stock interrupt handler such that it unconditionally clears
interrupts from a frozen port.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

c14f71dfb9bbaca1e2308436b0fda06b5ae9901d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 2e80930..fc9ae17 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4502,12 +4502,20 @@ irqreturn_t ata_interrupt (int irq, void
 
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


