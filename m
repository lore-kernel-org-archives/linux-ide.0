From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: cosmetic, replace ap_lock w/ ap->lock in ata_scsi_error()
Date: Mon, 3 Jul 2006 03:02:15 +0900
Message-ID: <20060702180215.GB6027@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.203]:59989 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964786AbWGBSBk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Jul 2006 14:01:40 -0400
Received: by wx-out-0102.google.com with SMTP id t10so447360wxc
        for <linux-ide@vger.kernel.org>; Sun, 02 Jul 2006 11:01:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

ap_lock was used because &ap->host_set->lock was too long and used a
lot.  Now that &ap->host_set->lock is replaced with ap->lock, there's
no reason to keep ap_lock.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch is against

  upstream (2154cfa6ba560401d25f6cc083fe3fb996cbb571)
  + add-ATA_PFLAG-patch (http://article.gmane.org/gmane.linux.ide/11717)

Thanks.

 drivers/scsi/libata-eh.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

5752d2157f6c362d4305e24f5bbabd37422c76e4
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 4a670db..d19666c 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -190,7 +190,6 @@ enum scsi_eh_timer_return ata_scsi_timed
 void ata_scsi_error(struct Scsi_Host *host)
 {
 	struct ata_port *ap = ata_shost_to_port(host);
-	spinlock_t *ap_lock = ap->lock;
 	int i, repeat_cnt = ATA_EH_MAX_REPEAT;
 	unsigned long flags;
 
@@ -217,7 +216,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 		struct scsi_cmnd *scmd, *tmp;
 		int nr_timedout = 0;
 
-		spin_lock_irqsave(ap_lock, flags);
+		spin_lock_irqsave(ap->lock, flags);
 
 		list_for_each_entry_safe(scmd, tmp, &host->eh_cmd_q, eh_entry) {
 			struct ata_queued_cmd *qc;
@@ -256,15 +255,15 @@ void ata_scsi_error(struct Scsi_Host *ho
 		if (nr_timedout)
 			__ata_port_freeze(ap);
 
-		spin_unlock_irqrestore(ap_lock, flags);
+		spin_unlock_irqrestore(ap->lock, flags);
 	} else
-		spin_unlock_wait(ap_lock);
+		spin_unlock_wait(ap->lock);
 
  repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
 		/* fetch & clear EH info */
-		spin_lock_irqsave(ap_lock, flags);
+		spin_lock_irqsave(ap->lock, flags);
 
 		memset(&ap->eh_context, 0, sizeof(ap->eh_context));
 		ap->eh_context.i = ap->eh_info;
@@ -273,7 +272,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
 		ap->pflags &= ~ATA_PFLAG_EH_PENDING;
 
-		spin_unlock_irqrestore(ap_lock, flags);
+		spin_unlock_irqrestore(ap->lock, flags);
 
 		/* invoke EH.  if unloading, just finish failed qcs */
 		if (!(ap->pflags & ATA_PFLAG_UNLOADING))
@@ -285,14 +284,14 @@ void ata_scsi_error(struct Scsi_Host *ho
 		 * recovered the port but before this point.  Repeat
 		 * EH in such case.
 		 */
-		spin_lock_irqsave(ap_lock, flags);
+		spin_lock_irqsave(ap->lock, flags);
 
 		if (ap->pflags & ATA_PFLAG_EH_PENDING) {
 			if (--repeat_cnt) {
 				ata_port_printk(ap, KERN_INFO,
 					"EH pending after completion, "
 					"repeating EH (cnt=%d)\n", repeat_cnt);
-				spin_unlock_irqrestore(ap_lock, flags);
+				spin_unlock_irqrestore(ap->lock, flags);
 				goto repeat;
 			}
 			ata_port_printk(ap, KERN_ERR, "EH pending after %d "
@@ -302,14 +301,14 @@ void ata_scsi_error(struct Scsi_Host *ho
 		/* this run is complete, make sure EH info is clear */
 		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
 
-		/* Clear host_eh_scheduled while holding ap_lock such
+		/* Clear host_eh_scheduled while holding ap->lock such
 		 * that if exception occurs after this point but
 		 * before EH completion, SCSI midlayer will
 		 * re-initiate EH.
 		 */
 		host->host_eh_scheduled = 0;
 
-		spin_unlock_irqrestore(ap_lock, flags);
+		spin_unlock_irqrestore(ap->lock, flags);
 	} else {
 		WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
 		ap->ops->eng_timeout(ap);
@@ -321,7 +320,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
 	/* clean up */
-	spin_lock_irqsave(ap_lock, flags);
+	spin_lock_irqsave(ap->lock, flags);
 
 	if (ap->pflags & ATA_PFLAG_LOADING) {
 		ap->pflags &= ~ATA_PFLAG_LOADING;
@@ -338,7 +337,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 	ap->pflags &= ~ATA_PFLAG_EH_IN_PROGRESS;
 	wake_up_all(&ap->eh_wait_q);
 
-	spin_unlock_irqrestore(ap_lock, flags);
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	DPRINTK("EXIT\n");
 }
-- 
1.3.2

