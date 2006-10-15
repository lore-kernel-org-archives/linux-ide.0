From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/12] libata-pmp: implement ATA_LFLAG_DISABLED
Date: Mon, 16 Oct 2006 08:47:17 +0900
Message-ID: <11609560371746-git-send-email-htejun@gmail.com>
References: <11609560371552-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:14479 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932224AbWJOXr3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:47:29 -0400
Received: by nf-out-0910.google.com with SMTP id c2so636805nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:47:28 -0700 (PDT)
In-Reply-To: <11609560371552-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
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
 drivers/ata/libata-eh.c   |   29 ++++++++++++++++++++++++++++-
 drivers/ata/libata-scsi.c |   10 ++++++----
 include/linux/libata.h    |    6 +++++-
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2c302c9..228240a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1058,6 +1058,7 @@ static void ata_eh_analyze_serror(struct
 	struct ata_eh_context *ehc = &link->eh_context;
 	u32 serror = ehc->i.serror;
 	unsigned int err_mask = 0, action = 0;
+	u32 hotplug_mask;
 
 	if (serror & SERR_PERSISTENT) {
 		err_mask |= AC_ERR_ATA_BUS;
@@ -1076,7 +1077,22 @@ static void ata_eh_analyze_serror(struct
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
@@ -1968,6 +1984,10 @@ static int ata_eh_skip_recovery(struct a
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_device *dev;
 
+	/* skip disabled links */
+	if (link->flags & ATA_LFLAG_DISABLED)
+		return 1;
+
 	/* skip if all possible devices are suspended */
 	ata_link_for_each_dev(dev, link) {
 		if (!(dev->flags & ATA_DFLAG_SUSPENDED))
@@ -2079,6 +2099,13 @@ int ata_eh_recover(struct ata_port *ap, 
 	ata_port_for_each_link(link, ap) {
 		struct ata_eh_context *ehc = &link->eh_context;
 
+		/* re-enable link? */
+		if (ehc->i.action & ATA_EH_ENABLE_LINK) {
+			ata_eh_about_to_do(link, NULL, ATA_EH_ENABLE_LINK);
+			link->flags &= ~ATA_LFLAG_DISABLED;
+			ata_eh_done(link, NULL, ATA_EH_ENABLE_LINK);
+		}
+
 		ata_link_for_each_dev(dev, link) {
 			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c62992f..64777e1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -463,9 +463,10 @@ int ata_scsi_device_suspend(struct scsi_
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
@@ -526,9 +527,10 @@ int ata_scsi_device_resume(struct scsi_d
 
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
index fe64a31..a940b67 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -160,6 +160,9 @@ enum {
 	ATA_DEV_PMP_UNSUP	= 6,	/* SATA port multiplier (unsupported) */
 	ATA_DEV_NONE		= 7,	/* no device */
 
+	/* struct ata_link flags */
+	ATA_LFLAG_DISABLED	= (1 << 0), /* this link is disabled (PMP) */
+
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
 					    /* (doesn't imply presence) */
@@ -283,6 +286,7 @@ enum {
 	ATA_EH_SUSPEND		= (1 << 3),
 	ATA_EH_RESUME		= (1 << 4),
 	ATA_EH_PM_FREEZE	= (1 << 5),
+	ATA_EH_ENABLE_LINK	= (1 << 6),
 
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE | ATA_EH_SUSPEND |
@@ -981,7 +985,7 @@ static inline void __ata_ehi_hotplugged(
 	ehi->flags |= ATA_EHI_HOTPLUGGED | ATA_EHI_RESUME_LINK;
 	ehi->hotplug_timestamp = jiffies;
 
-	ehi->action |= ATA_EH_SOFTRESET;
+	ehi->action |= ATA_EH_ENABLE_LINK | ATA_EH_SOFTRESET;
 	ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
 }
 
-- 
1.4.2.3


