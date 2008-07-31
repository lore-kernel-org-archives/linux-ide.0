From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] libata: misc updates to prepare for slave link
Date: Thu, 31 Jul 2008 17:02:42 +0900
Message-ID: <1217491364-19725-4-git-send-email-tj@kernel.org>
References: <1217491364-19725-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39900 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbYGaIES (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 04:04:18 -0400
In-Reply-To: <1217491364-19725-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, JosephChan@via.com.tw
Cc: Tejun Heo <tj@kernel.org>

* Add ATA_EH_ALL_ACTIONS.

* Make sata_link_{on|off}_line() return bool instead of int.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |   16 ++++++++--------
 include/linux/libata.h    |    6 ++++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f7049cd..0c303e6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4935,16 +4935,16 @@ int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
  *	None.
  *
  *	RETURNS:
- *	1 if the port online status is available and online.
+ *	True if the port online status is available and online.
  */
-int ata_link_online(struct ata_link *link)
+bool ata_link_online(struct ata_link *link)
 {
 	u32 sstatus;
 
 	if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0 &&
 	    (sstatus & 0xf) == 0x3)
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 /**
@@ -4959,16 +4959,16 @@ int ata_link_online(struct ata_link *link)
  *	None.
  *
  *	RETURNS:
- *	1 if the port offline status is available and offline.
+ *	True if the port offline status is available and offline.
  */
-int ata_link_offline(struct ata_link *link)
+bool ata_link_offline(struct ata_link *link)
 {
 	u32 sstatus;
 
 	if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0 &&
 	    (sstatus & 0xf) != 0x3)
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 #ifdef CONFIG_PM
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 42c4b6f..67640ce 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -320,6 +320,8 @@ enum {
 	ATA_EH_LPM		= (1 << 4),  /* link power management action */
 
 	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE,
+	ATA_EH_ALL_ACTIONS	= ATA_EH_REVALIDATE | ATA_EH_RESET |
+				  ATA_EH_ENABLE_LINK | ATA_EH_LPM,
 
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
@@ -918,8 +920,8 @@ extern int sata_scr_valid(struct ata_link *link);
 extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
 extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
-extern int ata_link_online(struct ata_link *link);
-extern int ata_link_offline(struct ata_link *link);
+extern bool ata_link_online(struct ata_link *link);
+extern bool ata_link_offline(struct ata_link *link);
 #ifdef CONFIG_PM
 extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
 extern void ata_host_resume(struct ata_host *host);
-- 
1.5.4.5

