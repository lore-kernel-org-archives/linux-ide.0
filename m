From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] libata: kill ata_ehi_schedule_probe()
Date: Tue, 11 Mar 2008 12:41:43 +0900
Message-ID: <12052069031224-git-send-email-htejun@gmail.com>
References: <12052069033338-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:36603 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbYCKDl4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 23:41:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2611787wah.23
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 20:41:55 -0700 (PDT)
In-Reply-To: <12052069033338-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: mikpe@it.uu.se, Tejun Heo <htejun@gmail.com>

ata_ehi_schedule_probe() was created to hide details of link-resuming
reset magic.  Now that all the softreset workarounds are gone,
scheduling probe is very simple - set probe_mask and request RESET.
Kill ata_ehi_schedule_probe() and open code it.  This also increases
consistency as ata_ehi_schedule_probe() couldn't cover individual
device probings so they were open-coded even when the helper existed.

While at it, define ATA_ALL_DEVICES as mask of all possible devices on
a link and always use it when requesting probe on link level for
simplicity and consistency.  Setting extra bits in the probe_mask
doesn't hurt anybody.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    3 +--
 drivers/ata/libata-eh.c   |    2 +-
 drivers/ata/libata-pmp.c  |   12 ++++++++----
 drivers/ata/libata-scsi.c |    2 +-
 include/linux/libata.h    |   12 ++++--------
 5 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a731298..410f1ea 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7067,8 +7067,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 			/* kick EH for boot probing */
 			spin_lock_irqsave(ap->lock, flags);
 
-			ehi->probe_mask =
-				(1 << ata_link_max_devices(&ap->link)) - 1;
+			ehi->probe_mask |= ATA_ALL_DEVICES;
 			ehi->action |= ATA_EH_RESET;
 			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index bef9187..64418f1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1746,7 +1746,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		ata_eh_analyze_serror(link);
 	} else if (rc != -EOPNOTSUPP) {
 		/* SError read failed, force reset and probing */
-		ata_ehi_schedule_probe(&ehc->i);
+		ehc->i.probe_mask |= ATA_ALL_DEVICES;
 		ehc->i.action |= ATA_EH_RESET;
 		ehc->i.err_mask |= AC_ERR_OTHER;
 	}
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index ba3ad46..2e9eea8 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -435,7 +435,7 @@ static int sata_pmp_init_links(struct ata_port *ap, int nr_ports)
 		struct ata_eh_context *ehc = &link->eh_context;
 
 		link->flags = 0;
-		ehc->i.probe_mask |= 1;
+		ehc->i.probe_mask |= ATA_ALL_DEVICES;
 		ehc->i.action |= ATA_EH_RESET;
 	}
 
@@ -831,8 +831,12 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 		ata_eh_thaw_port(ap);
 
 		/* PMP is reset, SErrors cannot be trusted, scan all */
-		ata_port_for_each_link(tlink, ap)
-			ata_ehi_schedule_probe(&tlink->eh_context.i);
+		ata_port_for_each_link(tlink, ap) {
+			struct ata_eh_context *ehc = &tlink->eh_context;
+
+			ehc->i.probe_mask |= ATA_ALL_DEVICES;
+			ehc->i.action |= ATA_EH_RESET;
+		}
 	}
 
 	/* If revalidation is requested, revalidate and reconfigure;
@@ -847,7 +851,7 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 		tries--;
 
 		if (rc == -ENODEV) {
-			ehc->i.probe_mask |= 1;
+			ehc->i.probe_mask |= ATA_ALL_DEVICES;
 			detach = 1;
 			/* give it just two more chances */
 			tries = min(tries, 2);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d938b26..b4c5ca1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3448,7 +3448,7 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 
 		ata_port_for_each_link(link, ap) {
 			struct ata_eh_info *ehi = &link->eh_info;
-			ehi->probe_mask |= (1 << ata_link_max_devices(link)) - 1;
+			ehi->probe_mask |= ATA_ALL_DEVICES;
 			ehi->action |= ATA_EH_RESET;
 		}
 	} else {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5de2ee3..a7882a2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -122,6 +122,8 @@ enum {
 
 	ATAPI_MAX_DRAIN		= 16 << 10,
 
+	ATA_ALL_DEVICES		= (1 << ATA_MAX_DEVICES) - 1,
+
 	ATA_SHT_EMULATED	= 1,
 	ATA_SHT_CMD_PER_LUN	= 1,
 	ATA_SHT_THIS_ID		= -1,
@@ -1095,17 +1097,11 @@ extern void ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...)
 	__attribute__ ((format (printf, 2, 3)));
 extern void ata_ehi_clear_desc(struct ata_eh_info *ehi);
 
-static inline void ata_ehi_schedule_probe(struct ata_eh_info *ehi)
-{
-	ehi->action |= ATA_EH_RESET;
-	ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
-}
-
 static inline void ata_ehi_hotplugged(struct ata_eh_info *ehi)
 {
-	ata_ehi_schedule_probe(ehi);
+	ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
 	ehi->flags |= ATA_EHI_HOTPLUGGED;
-	ehi->action |= ATA_EH_ENABLE_LINK;
+	ehi->action |= ATA_EH_RESET | ATA_EH_ENABLE_LINK;
 	ehi->err_mask |= AC_ERR_ATA_BUS;
 }
 
-- 
1.5.2.4

