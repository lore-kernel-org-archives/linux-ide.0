From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: improve EH action and EHI flag handling
Date: Mon, 10 Jul 2006 23:18:46 +0900
Message-ID: <20060710141846.GH2592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:26137 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030401AbWGJORs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 10:17:48 -0400
Received: by wr-out-0506.google.com with SMTP id i23so1683395wra
        for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 07:17:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Update ata_eh_about_to_do() and ata_eh_done() to improve EH action and
EHI flag handling.

* There are two types of EHI flags - one which expires on successful
  EH and the other which expires on a successful reset.  Make this
  distinction clear.

* Unlike other EH actions, reset actions are represented by two EH
  action masks and a EHI modifier.  Implement correct about_to_do/done
  semantics for resets.  That is, prior to reset, related EH info is
  sucked in from ehi and cleared, and after reset is complete, related
  EH info in ehc is cleared.

These changes improve consistency and remove unnecessary EH actions
caused by stale EH action masks and EHI flags.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   33 ++++++++++++++++++++++++++++-----
 include/linux/libata.h   |    4 +++-
 2 files changed, 31 insertions(+), 6 deletions(-)

4d0419327e924b122e951c77afca24bf6f42a6cd
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index a9dea3d..5d594f5 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -785,12 +785,27 @@ static void ata_eh_about_to_do(struct at
 			       unsigned int action)
 {
 	unsigned long flags;
+	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_context *ehc = &ap->eh_context;
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	ata_eh_clear_action(dev, &ap->eh_info, action);
+	/* Reset is represented by combination of actions and EHI
+	 * flags.  Suck in all related bits before clearing eh_info to
+	 * avoid losing requested action.
+	 */
+	if (action & ATA_EH_RESET_MASK) {
+		ehc->i.action |= ehi->action & ATA_EH_RESET_MASK;
+		ehc->i.flags |= ehi->flags & ATA_EHI_RESET_MODIFIER_MASK;
+
+		/* make sure all reset actions are cleared & clear EHI flags */
+		action |= ATA_EH_RESET_MASK;
+		ehi->flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
+	}
+
+	ata_eh_clear_action(dev, ehi, action);
 
-	if (!(ap->eh_context.i.flags & ATA_EHI_QUIET))
+	if (!(ehc->i.flags & ATA_EHI_QUIET))
 		ap->pflags |= ATA_PFLAG_RECOVERED;
 
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -811,6 +826,12 @@ static void ata_eh_about_to_do(struct at
 static void ata_eh_done(struct ata_port *ap, struct ata_device *dev,
 			unsigned int action)
 {
+	/* if reset is complete, clear all reset actions & reset modifier */
+	if (action & ATA_EH_RESET_MASK) {
+		action |= ATA_EH_RESET_MASK;
+		ap->eh_context.i.flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
+	}
+
 	ata_eh_clear_action(dev, &ap->eh_context.i, action);
 }
 
@@ -1499,6 +1520,9 @@ static int ata_eh_reset(struct ata_port 
 	ata_reset_fn_t reset;
 	int i, did_followup_srst, rc;
 
+	/* about to reset */
+	ata_eh_about_to_do(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
 	 */
@@ -1547,8 +1571,7 @@ static int ata_eh_reset(struct ata_port 
 		ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
 				reset == softreset ? "soft" : "hard");
 
-	/* reset */
-	ata_eh_about_to_do(ap, NULL, ATA_EH_RESET_MASK);
+	/* mark that this EH session started with reset */
 	ehc->i.flags |= ATA_EHI_DID_RESET;
 
 	rc = ata_do_reset(ap, reset, classes);
@@ -1611,7 +1634,7 @@ static int ata_eh_reset(struct ata_port 
 			postreset(ap, classes);
 
 		/* reset successful, schedule revalidation */
-		ata_eh_done(ap, NULL, ATA_EH_RESET_MASK);
+		ata_eh_done(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
 		ehc->i.action |= ATA_EH_REVALIDATE;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1609309..a897b4b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -266,12 +266,14 @@ enum {
 
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
-	ATA_EHI_RESUME_LINK	= (1 << 1),  /* need to resume link */
+	ATA_EHI_RESUME_LINK	= (1 << 1),  /* resume link (reset modifier) */
 	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
 	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
 
 	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
 
+	ATA_EHI_RESET_MODIFIER_MASK = ATA_EHI_RESUME_LINK,
+
 	/* max repeat if error condition is still set after ->error_handler */
 	ATA_EH_MAX_REPEAT	= 5,
 
-- 
1.3.2

