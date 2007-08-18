From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream REGENERATED] libata: move EH repeat reporting into ata_eh_report()
Date: Sat, 18 Aug 2007 13:28:49 +0900
Message-ID: <20070818042849.GE8590@htj.dyndns.org>
References: <20070731074203.GA13674@htj.dyndns.org> <20070731075100.GB13674@htj.dyndns.org> <46C2BEDA.5070105@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:65304 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbXHRE25 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 00:28:57 -0400
Received: by wa-out-1112.google.com with SMTP id j4so72974wah
        for <linux-ide@vger.kernel.org>; Fri, 17 Aug 2007 21:28:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46C2BEDA.5070105@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, mikpe@it.uu.se

EH is sometimes repeated without any error or action.  For example,
this happens when probing IDENTIFY fails because of a phantom device.
In these cases, all the repeated EH does is making sure there is no
unhandled error or pending action and return.  This repeation is
necessary to avoid losing any event which occurred while EH was in
progress.

Unfortunately, this dry run causes annonying "EH pending after
completion" message.  This patch moves the repeat reporting into
ata_eh_report() such that it's more compact and skipped on dry runs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikep@it.uu.se>
---
Regenerated against #upstream (41b135c7) +
implement-and-use-ata_port_desc patch.

 drivers/ata/libata-eh.c |   30 ++++++++++++++++++------------
 include/linux/libata.h  |    5 +++--
 2 files changed, 21 insertions(+), 14 deletions(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -358,7 +358,7 @@ enum scsi_eh_timer_return ata_scsi_timed
 void ata_scsi_error(struct Scsi_Host *host)
 {
 	struct ata_port *ap = ata_shost_to_port(host);
-	int i, repeat_cnt = ATA_EH_MAX_REPEAT;
+	int i;
 	unsigned long flags;
 
 	DPRINTK("ENTER\n");
@@ -424,6 +424,9 @@ void ata_scsi_error(struct Scsi_Host *ho
 			__ata_port_freeze(ap);
 
 		spin_unlock_irqrestore(ap->lock, flags);
+
+		/* initialize eh_tries */
+		ap->eh_tries = ATA_EH_MAX_TRIES;
 	} else
 		spin_unlock_wait(ap->lock);
 
@@ -468,15 +471,12 @@ void ata_scsi_error(struct Scsi_Host *ho
 		spin_lock_irqsave(ap->lock, flags);
 
 		if (ap->pflags & ATA_PFLAG_EH_PENDING) {
-			if (--repeat_cnt) {
-				ata_port_printk(ap, KERN_INFO,
-					"EH pending after completion, "
-					"repeating EH (cnt=%d)\n", repeat_cnt);
+			if (--ap->eh_tries) {
 				spin_unlock_irqrestore(ap->lock, flags);
 				goto repeat;
 			}
 			ata_port_printk(ap, KERN_ERR, "EH pending after %d "
-					"tries, giving up\n", ATA_EH_MAX_REPEAT);
+					"tries, giving up\n", ATA_EH_MAX_TRIES);
 			ap->pflags &= ~ATA_PFLAG_EH_PENDING;
 		}
 
@@ -1778,6 +1778,7 @@ static void ata_eh_link_report(struct at
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	const char *frozen, *desc;
+	char tries_buf[6];
 	int tag, nr_failed = 0;
 
 	desc = NULL;
@@ -1802,18 +1803,23 @@ static void ata_eh_link_report(struct at
 	if (ap->pflags & ATA_PFLAG_FROZEN)
 		frozen = " frozen";
 
+	memset(tries_buf, 0, sizeof(tries_buf));
+	if (ap->eh_tries < ATA_EH_MAX_TRIES)
+		snprintf(tries_buf, sizeof(tries_buf) - 1, " t%d",
+			 ap->eh_tries);
+
 	if (ehc->i.dev) {
 		ata_dev_printk(ehc->i.dev, KERN_ERR, "exception Emask 0x%x "
-			       "SAct 0x%x SErr 0x%x action 0x%x%s\n",
-			       ehc->i.err_mask, link->sactive,
-			       ehc->i.serror, ehc->i.action, frozen);
+			       "SAct 0x%x SErr 0x%x action 0x%x%s%s\n",
+			       ehc->i.err_mask, link->sactive, ehc->i.serror,
+			       ehc->i.action, frozen, tries_buf);
 		if (desc)
 			ata_dev_printk(ehc->i.dev, KERN_ERR, "%s\n", desc);
 	} else {
 		ata_link_printk(link, KERN_ERR, "exception Emask 0x%x "
-				"SAct 0x%x SErr 0x%x action 0x%x%s\n",
-				ehc->i.err_mask, link->sactive,
-				ehc->i.serror, ehc->i.action, frozen);
+				"SAct 0x%x SErr 0x%x action 0x%x%s%s\n",
+				ehc->i.err_mask, link->sactive, ehc->i.serror,
+				ehc->i.action, frozen, tries_buf);
 		if (desc)
 			ata_link_printk(link, KERN_ERR, "%s\n", desc);
 	}
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -293,8 +293,8 @@ enum {
 	ATA_EHI_DID_RESET	= ATA_EHI_DID_SOFTRESET | ATA_EHI_DID_HARDRESET,
 	ATA_EHI_RESET_MODIFIER_MASK = ATA_EHI_RESUME_LINK,
 
-	/* max repeat if error condition is still set after ->error_handler */
-	ATA_EH_MAX_REPEAT	= 5,
+	/* max tries if error condition is still set after ->error_handler */
+	ATA_EH_MAX_TRIES	= 5,
 
 	/* how hard are we gonna try to probe/recover devices */
 	ATA_PROBE_MAX_TRIES	= 3,
@@ -580,6 +580,7 @@ struct ata_port {
 	u32			msg_enable;
 	struct list_head	eh_done_q;
 	wait_queue_head_t	eh_wait_q;
+	int			eh_tries;
 
 	pm_message_t		pm_mesg;
 	int			*pm_result;
