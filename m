From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] libata: kill ATA_EHI_RESUME_LINK
Date: Tue, 11 Mar 2008 13:27:32 +0900
Message-ID: <12052096542848-git-send-email-htejun@gmail.com>
References: <12052096544056-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:21368 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbYCKE1m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 00:27:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2628806wah.23
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 21:27:41 -0700 (PDT)
In-Reply-To: <12052096544056-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: mikpe@it.uu.se, Tejun Heo <htejun@gmail.com>

ATA_EHI_RESUME_LINK has two functions - promote reset to hardreset if
ATA_LFLAG_HRST_TO_RESUME is set and preventing EH from shortcutting
reset action when probing is requested.  The former is gone now and
the latter can easily be achieved by making EH to perform at least one
reset if reset is requested, which also makes more sense than
depending on RESUME_LINK flag.

As ATA_EHI_RESUME_LINK was the only EHI reset modifier, this also
kills reset modifier handling.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c   |   21 ++++++++-------------
 drivers/ata/libata-pmp.c  |    1 -
 drivers/ata/libata-scsi.c |    1 -
 include/linux/libata.h    |    3 ---
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2dd0a2b..5969471 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1079,12 +1079,6 @@ void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	/* suck in and clear reset modifier */
-	if (action & ATA_EH_RESET) {
-		ehc->i.flags |= ehi->flags & ATA_EHI_RESET_MODIFIER_MASK;
-		ehi->flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
-	}
-
 	ata_eh_clear_action(link, dev, ehi, action);
 
 	if (!(ehc->i.flags & ATA_EHI_QUIET))
@@ -1110,10 +1104,6 @@ void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 
-	/* if reset is complete, clear reset modifier */
-	if (action & ATA_EH_RESET)
-		ehc->i.flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
-
 	ata_eh_clear_action(link, dev, &ehc->i, action);
 }
 
@@ -2491,6 +2481,7 @@ static int ata_link_nr_vacant(struct ata_link *link)
 
 static int ata_eh_skip_recovery(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_device *dev;
 
@@ -2498,9 +2489,13 @@ static int ata_eh_skip_recovery(struct ata_link *link)
 	if (link->flags & ATA_LFLAG_DISABLED)
 		return 1;
 
-	/* thaw frozen port, resume link and recover failed devices */
-	if ((link->ap->pflags & ATA_PFLAG_FROZEN) ||
-	    (ehc->i.flags & ATA_EHI_RESUME_LINK) || ata_link_nr_enabled(link))
+	/* thaw frozen port and recover failed devices */
+	if ((ap->pflags & ATA_PFLAG_FROZEN) || ata_link_nr_enabled(link))
+		return 0;
+
+	/* reset at least once if reset is requested */
+	if ((ehc->i.action & ATA_EH_RESET) &&
+	    !(ehc->i.flags & ATA_EHI_DID_RESET))
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 7f8bcff..df1d325 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -437,7 +437,6 @@ static int sata_pmp_init_links(struct ata_port *ap, int nr_ports)
 		link->flags = 0;
 		ehc->i.probe_mask |= 1;
 		ehc->i.action |= ATA_EH_RESET;
-		ehc->i.flags |= ATA_EHI_RESUME_LINK;
 	}
 
 	return 0;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3270d21..d3b8291 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3509,7 +3509,6 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			struct ata_eh_info *ehi = &dev->link->eh_info;
 			ehi->probe_mask |= 1 << dev->devno;
 			ehi->action |= ATA_EH_RESET;
-			ehi->flags |= ATA_EHI_RESUME_LINK;
 		} else
 			rc = -EINVAL;
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8921c1c..2df65b7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -300,7 +300,6 @@ enum {
 
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
-	ATA_EHI_RESUME_LINK	= (1 << 1),  /* resume link (reset modifier) */
 	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
 	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
 	ATA_EHI_LPM		= (1 << 4),  /* link power management action */
@@ -312,7 +311,6 @@ enum {
 	ATA_EHI_POST_SETMODE	= (1 << 20), /* revaildating after setmode */
 
 	ATA_EHI_DID_RESET	= ATA_EHI_DID_SOFTRESET | ATA_EHI_DID_HARDRESET,
-	ATA_EHI_RESET_MODIFIER_MASK = ATA_EHI_RESUME_LINK,
 
 	/* max tries if error condition is still set after ->error_handler */
 	ATA_EH_MAX_TRIES	= 5,
@@ -1092,7 +1090,6 @@ extern void ata_ehi_clear_desc(struct ata_eh_info *ehi);
 
 static inline void ata_ehi_schedule_probe(struct ata_eh_info *ehi)
 {
-	ehi->flags |= ATA_EHI_RESUME_LINK;
 	ehi->action |= ATA_EH_RESET;
 	ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
 }
-- 
1.5.2.4

