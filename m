From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/11] libata: implement ATA_EHI_RESUME_LINK
Date: Mon, 3 Jul 2006 16:07:26 +0900
Message-ID: <11519104463685-git-send-email-htejun@gmail.com>
References: <11519104451998-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:18668 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750921AbWGCHGu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jul 2006 03:06:50 -0400
Received: by wr-out-0506.google.com with SMTP id 71so571502wri
        for <linux-ide@vger.kernel.org>; Mon, 03 Jul 2006 00:06:50 -0700 (PDT)
In-Reply-To: <11519104451998-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ATA_EHI_RESUME_LINK, which indicates that the link needs to
be resumed.  This used to be implied by ATA_EHI_HOTPLUGGED.  However,
hotplug isn't the only event which requires link resume and separating
this out allows other places to request link resume.  This
differentiation also allows better debounce timing selection.

This patch converts user scan to use ATA_EHI_RESUME_LINK.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   15 ++++++++-------
 drivers/scsi/libata-scsi.c |    1 +
 include/linux/libata.h     |    3 ++-
 3 files changed, 11 insertions(+), 8 deletions(-)

11afe177206757095a8b265cd3649b629db45179
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 11f2257..3d6e41b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2619,13 +2619,14 @@ int ata_std_prereset(struct ata_port *ap
 	const unsigned long *timing;
 	int rc;
 
-	/* hotplug? */
-	if (ehc->i.flags & ATA_EHI_HOTPLUGGED) {
-		if (ap->flags & ATA_FLAG_HRST_TO_RESUME)
-			ehc->i.action |= ATA_EH_HARDRESET;
-		if (ap->flags & ATA_FLAG_SKIP_D2H_BSY)
-			ata_wait_spinup(ap);
-	}
+	/* handle link resume & hotplug spinup */
+	if ((ehc->i.flags & ATA_EHI_RESUME_LINK) &&
+	    (ap->flags & ATA_FLAG_HRST_TO_RESUME))
+		ehc->i.action |= ATA_EH_HARDRESET;
+
+	if ((ehc->i.flags & ATA_EHI_HOTPLUGGED) &&
+	    (ap->flags & ATA_FLAG_SKIP_D2H_BSY))
+		ata_wait_spinup(ap);
 
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 1946979..1ed89d8 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -3013,6 +3013,7 @@ static int ata_scsi_user_scan(struct Scs
 		if (dev) {
 			ap->eh_info.probe_mask |= 1 << dev->devno;
 			ap->eh_info.action |= ATA_EH_SOFTRESET;
+			ap->eh_info.flags |= ATA_EHI_RESUME_LINK;
 		} else
 			rc = -EINVAL;
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b5d247d..4d4ed2c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -259,6 +259,7 @@ enum {
 
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
+	ATA_EHI_RESUME_LINK	= (1 << 1),  /* need to resume link */
 
 	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
 
@@ -836,7 +837,7 @@ static inline void ata_ehi_hotplugged(st
 	if (ehi->flags & ATA_EHI_HOTPLUGGED)
 		return;
 
-	ehi->flags |= ATA_EHI_HOTPLUGGED;
+	ehi->flags |= ATA_EHI_HOTPLUGGED | ATA_EHI_RESUME_LINK;
 	ehi->hotplug_timestamp = jiffies;
 
 	ehi->err_mask |= AC_ERR_ATA_BUS;
-- 
1.3.2


