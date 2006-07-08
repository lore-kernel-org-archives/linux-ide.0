From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/12] libata-pmp: implement ATA_LFLAG_DISABLED
Date: Sat, 8 Jul 2006 14:58:07 +0900
Message-ID: <11523382872631-git-send-email-htejun@gmail.com>
References: <11523382873130-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:20631 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964800AbWGHF5Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:57:16 -0400
Received: by py-out-1112.google.com with SMTP id 57so368623pya
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:57:15 -0700 (PDT)
In-Reply-To: <11523382873130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ATA_LFLAG_DISABLED.  The flag indicates the link is disabled
due to EH recovery failure.  While a link is disabled, no EH action is
taken on the link and suspend/resume become noop too.  For host port,
this doesn't introduce any behavior change other than not invoking
hotplug sequence on failed ports on resume and this behavior change is
intended.

This will be used by PMP links to manage failed links.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c   |   26 +++++++++++++++++++++++++-
 drivers/scsi/libata-scsi.c |   10 ++++++----
 include/linux/libata.h     |   13 +++++++++----
 3 files changed, 40 insertions(+), 9 deletions(-)

5505907a9aab2d5f22760ce6b367b01f99980991
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 0a6f17e..0125c18 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1042,6 +1042,7 @@ static void ata_eh_analyze_serror(struct
 	struct ata_eh_context *ehc = &link->eh_context;
 	u32 serror = ehc->i.serror;
 	unsigned int err_mask = 0, action = 0;
+	u32 hotplug_mask;
 
 	if (serror & SERR_PERSISTENT) {
 		err_mask |= AC_ERR_ATA_BUS;
@@ -1060,7 +1061,22 @@ static void ata_eh_analyze_serror(struct
 		err_mask |= AC_ERR_SYSTEM;
 		action |= ATA_EH_SOFTRESET;
 	}
-	if (serror & (SERR_PHYRDY_CHG | SERR_DEV_XCHG))
+
+	/* Determine whether a hotplug event has occurred.  Both
+	 * SError.N/X are considered hotplug events for enabled links.
+	 * For disabled host links, hp-poll is responsible for hotplug
+	 * event detection and thus both N/X bits are ignored.  For
+	 * disabled PMP links, only N bit is considered as X bit is
+	 * left at 1 for link plugging.
+	 */
+	hotplug_mask = 0;
+
+	if (!(link->flags & ATA_LFLAG_DISABLED))
+		hotplug_mask = SERR_PHYRDY_CHG | SERR_DEV_XCHG;
+	else if (!ata_is_host_link(link))
+		hotplug_mask = SERR_PHYRDY_CHG;
+
+	if (serror & hotplug_mask)
 		ata_ehi_hotplugged(&ehc->i);
 
 	ehc->i.err_mask |= err_mask;
@@ -1948,6 +1964,10 @@ static int ata_eh_skip_recovery(struct a
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_device *dev;
 
+	/* skip disabled links */
+	if (link->flags & ATA_LFLAG_DISABLED)
+		return 1;
+
 	/* skip if all possible devices are suspended */
 	ata_link_for_each_dev(dev, link) {
 		if (ata_dev_absent(dev) || ata_dev_ready(dev))
@@ -2058,6 +2078,10 @@ int ata_eh_recover(struct ata_port *ap, 
 	ata_port_for_each_link(link, ap) {
 		struct ata_eh_context *ehc = &link->eh_context;
 
+		/* re-enable link? */
+		if (ehc->i.flags & ATA_EHI_ENABLE_LINK)
+			link->flags &= ~ATA_LFLAG_DISABLED;
+
 		ata_link_for_each_dev(dev, link) {
 			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index d446a86..f756acd 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -431,9 +431,10 @@ int ata_scsi_device_suspend(struct scsi_
 		spin_lock_irqsave(ap->lock, flags);
 	}
 
-	/* if @sdev is already detached, nothing to do */
+	/* if @sdev is already detached or link is disabled, nothing to do */
 	if (sdev->sdev_state == SDEV_OFFLINE ||
-	    sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL)
+	    sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL ||
+	    (dev->link->flags & ATA_LFLAG_DISABLED))
 		goto out_unlock;
 
 	/* request suspend */
@@ -494,9 +495,10 @@ int ata_scsi_device_resume(struct scsi_d
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	/* if @sdev is already detached, nothing to do */
+	/* if @sdev is already detached or link is disabled, nothing to do */
 	if (sdev->sdev_state == SDEV_OFFLINE ||
-	    sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL)
+	    sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL ||
+	    (dev->link->flags & ATA_LFLAG_DISABLED))
 		goto out_unlock;
 
 	/* request resume */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index dce5ab8..906225c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -147,6 +147,9 @@ enum {
 	ATA_DEV_PMP_UNSUP	= 6,	/* SATA port multiplier (unsupported) */
 	ATA_DEV_NONE		= 7,	/* no device */
 
+	/* struct ata_link flags */
+	ATA_LFLAG_DISABLED	= (1 << 0), /* this link is disabled (PMP) */
+
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
 					    /* (doesn't imply presence) */
@@ -276,9 +279,10 @@ enum {
 
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
-	ATA_EHI_RESUME_LINK	= (1 << 1),  /* need to resume link */
-	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
-	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
+	ATA_EHI_ENABLE_LINK	= (1 << 1),  /* enable disabled link */
+	ATA_EHI_RESUME_LINK	= (1 << 2),  /* need to resume link */
+	ATA_EHI_NO_AUTOPSY	= (1 << 3),  /* no autopsy */
+	ATA_EHI_QUIET		= (1 << 4),  /* be quiet */
 
 	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
 
@@ -932,7 +936,8 @@ static inline void __ata_ehi_hotplugged(
 	if (ehi->flags & ATA_EHI_HOTPLUGGED)
 		return;
 
-	ehi->flags |= ATA_EHI_HOTPLUGGED | ATA_EHI_RESUME_LINK;
+	ehi->flags |=
+		ATA_EHI_HOTPLUGGED | ATA_EHI_ENABLE_LINK | ATA_EHI_RESUME_LINK;
 	ehi->hotplug_timestamp = jiffies;
 
 	ehi->action |= ATA_EH_SOFTRESET;
-- 
1.3.2


