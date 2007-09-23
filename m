From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/12] libata-pmp-prep: implement ATA_LFLAG_DISABLED
Date: Sun, 23 Sep 2007 13:14:13 +0900
Message-ID: <1190520853319-git-send-email-htejun@gmail.com>
References: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:64083 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbXIWEOb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:14:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1545873wah
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:14:31 -0700 (PDT)
In-Reply-To: <11905208513747-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ATA_LFLAG_DISABLED.  The flag indicates the link is disabled
due to EH recovery failure.  While a link is disabled, no EH action is
taken on the link and suspend/resume become noop too.

This will be used by PMP links to manage failed links.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   30 +++++++++++++++++++++++++++++-
 include/linux/libata.h  |    3 +++
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8f8ed4d..fbbf791 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1308,6 +1308,7 @@ static void ata_eh_analyze_serror(struct ata_link *link)
 	struct ata_eh_context *ehc = &link->eh_context;
 	u32 serror = ehc->i.serror;
 	unsigned int err_mask = 0, action = 0;
+	u32 hotplug_mask;
 
 	if (serror & SERR_PERSISTENT) {
 		err_mask |= AC_ERR_ATA_BUS;
@@ -1326,7 +1327,20 @@ static void ata_eh_analyze_serror(struct ata_link *link)
 		err_mask |= AC_ERR_SYSTEM;
 		action |= ATA_EH_HARDRESET;
 	}
-	if (serror & (SERR_PHYRDY_CHG | SERR_DEV_XCHG))
+
+	/* Determine whether a hotplug event has occurred.  Both
+	 * SError.N/X are considered hotplug events for enabled or
+	 * host links.  For disabled PMP links, only N bit is
+	 * considered as X bit is left at 1 for link plugging.
+	 */
+	hotplug_mask = 0;
+
+	if (!(link->flags & ATA_LFLAG_DISABLED) || ata_is_host_link(link))
+		hotplug_mask = SERR_PHYRDY_CHG | SERR_DEV_XCHG;
+	else
+		hotplug_mask = SERR_PHYRDY_CHG;
+
+	if (serror & hotplug_mask)
 		ata_ehi_hotplugged(&ehc->i);
 
 	ehc->i.err_mask |= err_mask;
@@ -2227,6 +2241,10 @@ static int ata_eh_skip_recovery(struct ata_link *link)
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_device *dev;
 
+	/* skip disabled links */
+	if (link->flags & ATA_LFLAG_DISABLED)
+		return 1;
+
 	/* thaw frozen port, resume link and recover failed devices */
 	if ((link->ap->pflags & ATA_PFLAG_FROZEN) ||
 	    (ehc->i.flags & ATA_EHI_RESUME_LINK) || ata_link_nr_enabled(link))
@@ -2327,6 +2345,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	struct ata_device *dev;
 	int nr_failed_devs, nr_disabled_devs;
 	int reset, rc;
+	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
@@ -2334,6 +2353,15 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	ata_port_for_each_link(link, ap) {
 		struct ata_eh_context *ehc = &link->eh_context;
 
+		/* re-enable link? */
+		if (ehc->i.action & ATA_EH_ENABLE_LINK) {
+			ata_eh_about_to_do(link, NULL, ATA_EH_ENABLE_LINK);
+			spin_lock_irqsave(ap->lock, flags);
+			link->flags &= ~ATA_LFLAG_DISABLED;
+			spin_unlock_irqrestore(ap->lock, flags);
+			ata_eh_done(link, NULL, ATA_EH_ENABLE_LINK);
+		}
+
 		ata_link_for_each_dev(dev, link) {
 			if (link->flags & ATA_LFLAG_NO_RETRY)
 				ehc->tries[dev->devno] = 1;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index adeee73..2bd1d26 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -170,6 +170,7 @@ enum {
 	ATA_LFLAG_ASSUME_SEMB	= (1 << 4), /* assume SEMB class */
 	ATA_LFLAG_ASSUME_CLASS	= ATA_LFLAG_ASSUME_ATA | ATA_LFLAG_ASSUME_SEMB,
 	ATA_LFLAG_NO_RETRY	= (1 << 5), /* don't retry this link */
+	ATA_LFLAG_DISABLED	= (1 << 6), /* link is disabled */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
@@ -289,6 +290,7 @@ enum {
 	ATA_EH_REVALIDATE	= (1 << 0),
 	ATA_EH_SOFTRESET	= (1 << 1),
 	ATA_EH_HARDRESET	= (1 << 2),
+	ATA_EH_ENABLE_LINK	= (1 << 3),
 
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE,
@@ -999,6 +1001,7 @@ static inline void ata_ehi_hotplugged(struct ata_eh_info *ehi)
 {
 	ata_ehi_schedule_probe(ehi);
 	ehi->flags |= ATA_EHI_HOTPLUGGED;
+	ehi->action |= ATA_EH_ENABLE_LINK;
 	ehi->err_mask |= AC_ERR_ATA_BUS;
 }
 
-- 
1.5.0.3


