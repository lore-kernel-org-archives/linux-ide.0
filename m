From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/11] libata: implement ATA_EHI_NO_AUTOPSY and QUIET
Date: Mon, 3 Jul 2006 16:07:26 +0900
Message-ID: <11519104461920-git-send-email-htejun@gmail.com>
References: <11519104451998-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:59460 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751039AbWGCHGv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jul 2006 03:06:51 -0400
Received: by wx-out-0102.google.com with SMTP id t10so500111wxc
        for <linux-ide@vger.kernel.org>; Mon, 03 Jul 2006 00:06:51 -0700 (PDT)
In-Reply-To: <11519104451998-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ATA_EHI_NO_AUTOPSY and QUIET.  These used to be implied by
ATA_PFLAG_LOADING, but new power management and PMP support need to
use these separately.  e.g. Suspend/resume operations shouldn't print
full EH messages and resume shouldn't be recorded as an error.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 ++++--
 drivers/scsi/libata-eh.c   |   31 +++++++++++++++++--------------
 include/linux/libata.h     |    2 ++
 3 files changed, 23 insertions(+), 16 deletions(-)

64088c397150035e6d20cee81d83b00f82909bb5
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 988f385..5364be0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5439,6 +5439,7 @@ int ata_device_add(const struct ata_prob
 		}
 
 		if (ap->ops->error_handler) {
+			struct ata_eh_info *ehi = &ap->eh_info;
 			unsigned long flags;
 
 			ata_port_probe(ap);
@@ -5446,8 +5447,9 @@ int ata_device_add(const struct ata_prob
 			/* kick EH for boot probing */
 			spin_lock_irqsave(ap->lock, flags);
 
-			ap->eh_info.probe_mask = (1 << ATA_MAX_DEVICES) - 1;
-			ap->eh_info.action |= ATA_EH_SOFTRESET;
+			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
+			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
 			ap->pflags |= ATA_PFLAG_LOADING;
 			ata_port_schedule_eh(ap);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index d19666c..1e9e73d 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -322,14 +322,13 @@ void ata_scsi_error(struct Scsi_Host *ho
 	/* clean up */
 	spin_lock_irqsave(ap->lock, flags);
 
-	if (ap->pflags & ATA_PFLAG_LOADING) {
+	if (ap->pflags & ATA_PFLAG_LOADING)
 		ap->pflags &= ~ATA_PFLAG_LOADING;
-	} else {
-		if (ap->pflags & ATA_PFLAG_SCSI_HOTPLUG)
-			queue_work(ata_aux_wq, &ap->hotplug_task);
-		if (ap->pflags & ATA_PFLAG_RECOVERED)
-			ata_port_printk(ap, KERN_INFO, "EH complete\n");
-	}
+	else if (ap->pflags & ATA_PFLAG_SCSI_HOTPLUG)
+		queue_work(ata_aux_wq, &ap->hotplug_task);
+
+	if (ap->pflags & ATA_PFLAG_RECOVERED)
+		ata_port_printk(ap, KERN_INFO, "EH complete\n");
 
 	ap->pflags &= ~(ATA_PFLAG_SCSI_HOTPLUG | ATA_PFLAG_RECOVERED);
 
@@ -759,8 +758,12 @@ static void ata_eh_about_to_do(struct at
 	unsigned long flags;
 
 	spin_lock_irqsave(ap->lock, flags);
+
 	ata_eh_clear_action(dev, &ap->eh_info, action);
-	ap->pflags |= ATA_PFLAG_RECOVERED;
+
+	if (!(ap->eh_context.i.flags & ATA_EHI_QUIET))
+		ap->pflags |= ATA_PFLAG_RECOVERED;
+
 	spin_unlock_irqrestore(ap->lock, flags);
 }
 
@@ -1274,6 +1277,9 @@ static void ata_eh_autopsy(struct ata_po
 
 	DPRINTK("ENTER\n");
 
+	if (ehc->i.flags & ATA_EHI_NO_AUTOPSY)
+		return;
+
 	/* obtain and analyze SError */
 	rc = sata_scr_read(ap, SCR_ERROR, &serror);
 	if (rc == 0) {
@@ -1464,7 +1470,7 @@ static int ata_eh_reset(struct ata_port 
 	struct ata_eh_context *ehc = &ap->eh_context;
 	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
-	int verbose = !(ap->pflags & ATA_PFLAG_LOADING);
+	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
 	unsigned int action;
 	ata_reset_fn_t reset;
 	int i, did_followup_srst, rc;
@@ -1907,11 +1913,8 @@ void ata_do_eh(struct ata_port *ap, ata_
 	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 	       ata_postreset_fn_t postreset)
 {
-	if (!(ap->pflags & ATA_PFLAG_LOADING)) {
-		ata_eh_autopsy(ap);
-		ata_eh_report(ap);
-	}
-
+	ata_eh_autopsy(ap);
+	ata_eh_report(ap);
 	ata_eh_recover(ap, prereset, softreset, hardreset, postreset);
 	ata_eh_finish(ap);
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2f7bbfc..36938ae 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -260,6 +260,8 @@ enum {
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
 	ATA_EHI_RESUME_LINK	= (1 << 1),  /* need to resume link */
+	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
+	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
 
 	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
 
-- 
1.3.2


