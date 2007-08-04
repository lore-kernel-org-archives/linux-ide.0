From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/14] libata-link: linkify EH action helpers
Date: Sat, 4 Aug 2007 17:42:40 +0900
Message-ID: <11862169602764-git-send-email-htejun@gmail.com>
References: <11862169601938-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:33798 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756594AbXHDImq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 04:42:46 -0400
Received: by rv-out-0910.google.com with SMTP id k20so848290rvb
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 01:42:46 -0700 (PDT)
In-Reply-To: <11862169601938-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_eh_about_to_do() and ata_eh_done() deal with ata_link instead
of ata_port.

This patch introduces no behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 48ca68b..fc4b641 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -947,23 +947,24 @@ static void ata_eh_detach_dev(struct ata_device *dev)
 
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
 
@@ -980,7 +981,7 @@ static void ata_eh_about_to_do(struct ata_port *ap, struct ata_device *dev,
 		ehi->flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
 	}
 
-	ata_eh_clear_action(&ap->link, dev, ehi, action);
+	ata_eh_clear_action(link, dev, ehi, action);
 
 	if (!(ehc->i.flags & ATA_EHI_QUIET))
 		ap->pflags |= ATA_PFLAG_RECOVERED;
@@ -990,20 +991,20 @@ static void ata_eh_about_to_do(struct ata_port *ap, struct ata_device *dev,
 
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
@@ -1011,7 +1012,7 @@ static void ata_eh_done(struct ata_port *ap, struct ata_device *dev,
 		ehc->i.flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
 	}
 
-	ata_eh_clear_action(&ap->link, dev, &ehc->i, action);
+	ata_eh_clear_action(link, dev, &ehc->i, action);
 }
 
 /**
@@ -1795,7 +1796,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 	int rc;
 
 	/* about to reset */
-	ata_eh_about_to_do(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+	ata_eh_about_to_do(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
 
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
@@ -1877,7 +1878,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 			goto out;
 		}
 
-		ata_eh_about_to_do(ap, NULL, ATA_EH_RESET_MASK);
+		ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
 		rc = ata_do_reset(ap, reset, classes, deadline);
 
 		if (rc == 0 && classify &&
@@ -1927,7 +1928,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 			postreset(ap, classes);
 
 		/* reset successful, schedule revalidation */
-		ata_eh_done(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+		ata_eh_done(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
 		ehc->i.action |= ATA_EH_REVALIDATE;
 	}
  out:
@@ -1964,12 +1965,12 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 				goto err;
 			}
 
-			ata_eh_about_to_do(ap, dev, ATA_EH_REVALIDATE);
+			ata_eh_about_to_do(&ap->link, dev, ATA_EH_REVALIDATE);
 			rc = ata_dev_revalidate(dev, readid_flags);
 			if (rc)
 				goto err;
 
-			ata_eh_done(ap, dev, ATA_EH_REVALIDATE);
+			ata_eh_done(&ap->link, dev, ATA_EH_REVALIDATE);
 
 			/* Configuration may have changed, reconfigure
 			 * transfer mode.
-- 
1.5.0.3


