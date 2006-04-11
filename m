From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/16] libata-eh-fw: activate ->error_handler
Date: Tue, 11 Apr 2006 22:42:55 +0900
Message-ID: <11447629753003-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:22650 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750918AbWDKNnE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:43:04 -0400
Received: by zproxy.gmail.com with SMTP id o37so1094464nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:43:01 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_scsi_error() such that ->error_handler is invoked if
implemented.  ata_scsi_error() also takes care of merging
ATA_QCFLAG_TIMEOUT into qc->err_mask and clearing SCSI EH conditions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   56 +++++++++++++++++++++++++++++++++++++++++++---
 include/linux/libata.h   |    3 ++
 2 files changed, 55 insertions(+), 4 deletions(-)

dc24434e3e0ed074dd1f11231e9f0fc50e457d13
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 97ec527..1015f89 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -123,18 +123,66 @@ enum scsi_eh_timer_return ata_scsi_timed
 int ata_scsi_error(struct Scsi_Host *host)
 {
 	struct ata_port *ap = (struct ata_port *)&host->hostdata[0];
+	spinlock_t *hs_lock = &ap->host_set->lock;
+	int repeat_cnt = ATA_EH_MAX_REPEAT;
+	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
+ repeat:
 	/* synchronize with IRQ handler and port task */
-	spin_unlock_wait(&ap->host_set->lock);
+	spin_unlock_wait(hs_lock);
 	ata_port_flush_task(ap);
 
-	WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
+	/* invoke error handler */
+	if (ap->ops->error_handler) {
+		int i;
+
+		/* for new EH, all the qc's are ours now */
+		for (i = 0; i < ATA_MAX_QUEUE; i++) {
+			struct ata_queued_cmd *qc;
+			qc = __ata_qc_from_tag(ap, i);
+			if (qc->flags & ATA_QCFLAG_TIMEOUT)
+				qc->err_mask |= AC_ERR_TIMEOUT;;
+		}
+
+		/* invoke EH */
+		ap->ops->error_handler(ap);
 
-	ap->ops->eng_timeout(ap);
+		/* Exception might have happend after ->error_handler
+		 * recovered the port but before reaching this point.
+		 * repeat EH if that happens.
+		 */
+		spin_lock_irqsave(hs_lock, flags);
+
+		if (ap->flags & ATA_FLAG_FROZEN) {
+			if (--repeat_cnt) {
+				printk(KERN_INFO "ata%u: port is frozen after "
+				       "EH completed, repeating EH (cnt=%d)\n",
+				       ap->id, repeat_cnt);
+				spin_unlock_irqrestore(hs_lock, flags);
+				goto repeat;
+			}
+			printk(KERN_ERR "ata%u: port is frozen after %d tries, "
+			       "giving up\n", ap->id, ATA_EH_MAX_REPEAT);
+		}
+
+		/* Clear host_eh_scheduled while holding hs_lock such
+		 * that if exception occurs after this point but
+		 * before EH completion, SCSI midlayer will
+		 * re-initiate EH.
+		 */
+		host->host_eh_scheduled = 0;
+
+		spin_unlock_irqrestore(hs_lock, flags);
+	} else {
+		WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
+		ap->ops->eng_timeout(ap);
+	}
 
-	WARN_ON(host->host_failed || !list_empty(&host->eh_cmd_q));
+	/* finish or retry handled scmd's and clean up */
+	WARN_ON(host->host_failed || !list_empty(&host->eh_cmd_q) ||
+		host->host_eh_scheduled);
 
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 47fbd68..0ac5214 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -226,6 +226,9 @@ enum {
 	ATA_EH_ABORT		= (1 << 0), /* abort all active commands */
 	ATA_EH_FREEZE		= (1 << 1), /* freeze port (implies ABORT) */
 
+	/* max repeat if error condition is still set after ->error_handler */
+	ATA_EH_MAX_REPEAT	= 5,
+
 	/* how hard are we gonna try to probe/recover devices */
 	ATA_PROBE_MAX_TRIES	= 3,
 };
-- 
1.2.4


