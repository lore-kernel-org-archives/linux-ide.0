From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/17] libata-link: linkify EH action helpers
Date: Sat, 8 Jul 2006 14:45:36 +0900
Message-ID: <11523375363290-git-send-email-htejun@gmail.com>
References: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.195]:11714 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932517AbWGHFos (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:48 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1205846wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:48 -0700 (PDT)
In-Reply-To: <11523375353473-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_eh_about_to_do() and ata_eh_done() deal with ata_link instead
of ata_port.

This patch introduces no behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   39 ++++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 19 deletions(-)

b01d20e457820a1e839d5944f9d654ef5963fa33
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 22ca9a2..62c75d4 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -772,27 +772,28 @@ static void ata_eh_detach_dev(struct ata
 
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
 	unsigned long flags;
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	ata_eh_clear_action(&ap->link, dev, &ap->link.eh_info, action);
+	ata_eh_clear_action(link, dev, &link->eh_info, action);
 
-	if (!(ap->link.eh_context.i.flags & ATA_EHI_QUIET))
+	if (!(link->eh_context.i.flags & ATA_EHI_QUIET))
 		ap->pflags |= ATA_PFLAG_RECOVERED;
 
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -800,20 +801,20 @@ static void ata_eh_about_to_do(struct at
 
 /**
  *	ata_eh_done - EH action complete
- *	@ap: target ATA port
+ *	@link: target ATA link
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
-	ata_eh_clear_action(&ap->link, dev, &ap->link.eh_context.i, action);
+	ata_eh_clear_action(link, dev, &link->eh_context.i, action);
 }
 
 /**
@@ -1561,7 +1562,7 @@ static int ata_eh_reset(struct ata_port 
 				reset == softreset ? "soft" : "hard");
 
 	/* reset */
-	ata_eh_about_to_do(ap, NULL, ATA_EH_RESET_MASK);
+	ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
 	ehc->i.flags |= ATA_EHI_DID_RESET;
 
 	rc = ata_do_reset(ap, reset, classes);
@@ -1580,7 +1581,7 @@ static int ata_eh_reset(struct ata_port 
 			return -EINVAL;
 		}
 
-		ata_eh_about_to_do(ap, NULL, ATA_EH_RESET_MASK);
+		ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
 		rc = ata_do_reset(ap, reset, classes);
 
 		if (rc == 0 && classify &&
@@ -1624,7 +1625,7 @@ static int ata_eh_reset(struct ata_port 
 			postreset(ap, classes);
 
 		/* reset successful, schedule revalidation */
-		ata_eh_done(ap, NULL, ATA_EH_RESET_MASK);
+		ata_eh_done(link, NULL, ATA_EH_RESET_MASK);
 		ehc->i.action |= ATA_EH_REVALIDATE;
 	}
 
@@ -1650,13 +1651,13 @@ static int ata_eh_revalidate_and_attach(
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
@@ -1720,7 +1721,7 @@ static int ata_eh_suspend(struct ata_por
 
 		WARN_ON(dev->flags & ATA_DFLAG_SUSPENDED);
 
-		ata_eh_about_to_do(ap, dev, ATA_EH_SUSPEND);
+		ata_eh_about_to_do(&ap->link, dev, ATA_EH_SUSPEND);
 
 		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
 			/* flush cache */
@@ -1743,7 +1744,7 @@ static int ata_eh_suspend(struct ata_por
 		dev->flags |= ATA_DFLAG_SUSPENDED;
 		spin_unlock_irqrestore(ap->lock, flags);
 
-		ata_eh_done(ap, dev, ATA_EH_SUSPEND);
+		ata_eh_done(&ap->link, dev, ATA_EH_SUSPEND);
 	}
 
 	if (rc)
@@ -1813,7 +1814,7 @@ static int ata_eh_resume(struct ata_port
 		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
 			continue;
 
-		ata_eh_about_to_do(ap, dev, ATA_EH_RESUME);
+		ata_eh_about_to_do(&ap->link, dev, ATA_EH_RESUME);
 
 		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
 			err_mask = ata_do_simple_cmd(dev,
@@ -1827,7 +1828,7 @@ static int ata_eh_resume(struct ata_port
 			}
 		}
 
-		ata_eh_done(ap, dev, ATA_EH_RESUME);
+		ata_eh_done(&ap->link, dev, ATA_EH_RESUME);
 	}
 
 	if (rc)
-- 
1.3.2


