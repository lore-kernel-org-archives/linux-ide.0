From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/18] [PATCH] libata-link: linkify EH action helpers
Date: Mon, 16 Oct 2006 07:54:40 +0900
Message-ID: <11609528803629-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:50102 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422928AbWJOWyx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:53 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626620nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:53 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_eh_about_to_do() and ata_eh_done() deal with ata_link instead
of ata_port.

This patch introduces no behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   43 ++++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9cf41c4..7c089d3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -766,23 +766,24 @@ static void ata_eh_detach_dev(struct ata
 
 /**
  *	ata_eh_about_to_do - about to perform eh_action
- *	@ap: target ATA port
+ *	@link: target ATA link
  *	@dev: target ATA dev for per-dev action (can be NULL)
  *	@action: action about to be performed
  *
  *	Called just before performing EH actions to clear related bits
- *	in @ap->link.eh_info such that eh actions are not
- *	unnecessarily repeated.
+ *	in @link->eh_info such that eh actions are not unnecessarily
+ *	repeated.
  *
  *	LOCKING:
  *	None.
  */
-static void ata_eh_about_to_do(struct ata_port *ap, struct ata_device *dev,
+static void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 			       unsigned int action)
 {
+	struct ata_port *ap = link->ap;
+	struct ata_eh_info *ehi = &link->eh_info;
+	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long flags;
-	struct ata_eh_info *ehi = &ap->link.eh_info;
-	struct ata_eh_context *ehc = &ap->link.eh_context;
 
 	spin_lock_irqsave(ap->lock, flags);
 
@@ -799,7 +800,7 @@ static void ata_eh_about_to_do(struct at
 		ehi->flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
 	}
 
-	ata_eh_clear_action(&ap->link, dev, ehi, action);
+	ata_eh_clear_action(link, dev, ehi, action);
 
 	if (!(ehc->i.flags & ATA_EHI_QUIET))
 		ap->pflags |= ATA_PFLAG_RECOVERED;
@@ -809,20 +810,20 @@ static void ata_eh_about_to_do(struct at
 
 /**
  *	ata_eh_done - EH action complete
- *	@ap: target ATA port
+*	@ap: target ATA port
  *	@dev: target ATA dev for per-dev action (can be NULL)
  *	@action: action just completed
  *
  *	Called right after performing EH actions to clear related bits
- *	in @ap->link.eh_context.
+ *	in @link->eh_context.
  *
  *	LOCKING:
  *	None.
  */
-static void ata_eh_done(struct ata_port *ap, struct ata_device *dev,
+static void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 			unsigned int action)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_eh_context *ehc = &link->eh_context;
 
 	/* if reset is complete, clear all reset actions & reset modifier */
 	if (action & ATA_EH_RESET_MASK) {
@@ -830,7 +831,7 @@ static void ata_eh_done(struct ata_port 
 		ehc->i.flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
 	}
 
-	ata_eh_clear_action(&ap->link, dev, &ehc->i, action);
+	ata_eh_clear_action(link, dev, &ehc->i, action);
 }
 
 /**
@@ -1527,7 +1528,7 @@ static int ata_eh_reset(struct ata_port 
 	int did_followup_srst, rc;
 
 	/* about to reset */
-	ata_eh_about_to_do(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+	ata_eh_about_to_do(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
 
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
@@ -1600,7 +1601,7 @@ static int ata_eh_reset(struct ata_port 
 			return -EINVAL;
 		}
 
-		ata_eh_about_to_do(ap, NULL, ATA_EH_RESET_MASK);
+		ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
 		rc = ata_do_reset(ap, reset, classes);
 
 		if (rc == 0 && classify &&
@@ -1644,7 +1645,7 @@ static int ata_eh_reset(struct ata_port 
 			postreset(ap, classes);
 
 		/* reset successful, schedule revalidation */
-		ata_eh_done(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+		ata_eh_done(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
 		ehc->i.action |= ATA_EH_REVALIDATE;
 	}
 
@@ -1670,13 +1671,13 @@ static int ata_eh_revalidate_and_attach(
 				break;
 			}
 
-			ata_eh_about_to_do(ap, dev, ATA_EH_REVALIDATE);
+			ata_eh_about_to_do(&ap->link, dev, ATA_EH_REVALIDATE);
 			rc = ata_dev_revalidate(dev,
 					ehc->i.flags & ATA_EHI_DID_RESET);
 			if (rc)
 				break;
 
-			ata_eh_done(ap, dev, ATA_EH_REVALIDATE);
+			ata_eh_done(&ap->link, dev, ATA_EH_REVALIDATE);
 
 			/* schedule the scsi_rescan_device() here */
 			queue_work(ata_aux_wq, &(ap->scsi_rescan_task));
@@ -1740,7 +1741,7 @@ static int ata_eh_suspend(struct ata_por
 
 		WARN_ON(dev->flags & ATA_DFLAG_SUSPENDED);
 
-		ata_eh_about_to_do(ap, dev, ATA_EH_SUSPEND);
+		ata_eh_about_to_do(&ap->link, dev, ATA_EH_SUSPEND);
 
 		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
 			/* flush cache */
@@ -1763,7 +1764,7 @@ static int ata_eh_suspend(struct ata_por
 		dev->flags |= ATA_DFLAG_SUSPENDED;
 		spin_unlock_irqrestore(ap->lock, flags);
 
-		ata_eh_done(ap, dev, ATA_EH_SUSPEND);
+		ata_eh_done(&ap->link, dev, ATA_EH_SUSPEND);
 	}
 
 	if (rc)
@@ -1833,7 +1834,7 @@ static int ata_eh_resume(struct ata_port
 		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
 			continue;
 
-		ata_eh_about_to_do(ap, dev, ATA_EH_RESUME);
+		ata_eh_about_to_do(&ap->link, dev, ATA_EH_RESUME);
 
 		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
 			err_mask = ata_do_simple_cmd(dev,
@@ -1847,7 +1848,7 @@ static int ata_eh_resume(struct ata_port
 			}
 		}
 
-		ata_eh_done(ap, dev, ATA_EH_RESUME);
+		ata_eh_done(&ap->link, dev, ATA_EH_RESUME);
 	}
 
 	if (rc)
-- 
1.4.2.3


