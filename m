From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/8] libata: check onlineness before using SPD in sata_down_spd_limit()
Date: Thu, 29 Jan 2009 20:31:31 +0900
Message-ID: <1233228696-10562-4-git-send-email-tj@kernel.org>
References: <1233228696-10562-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34087 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbZA2Lbx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 06:31:53 -0500
In-Reply-To: <1233228696-10562-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

sata_down_spd_limit() should check whether the link is online before
using the SPD value to determine how to limit the link speed.  Factor
out onlineness test and test it from sata_down_spd_limit().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 20d0e27..daf0dec 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -164,6 +164,11 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 
+static bool ata_sstatus_online(u32 sstatus)
+{
+	return (sstatus & 0xf) == 0x3;
+}
+
 /**
  *	ata_link_next - link iteration helper
  *	@link: the previous link, NULL to start
@@ -2891,7 +2896,7 @@ int sata_down_spd_limit(struct ata_link *link)
 	 * If not, use cached value in link->sata_spd.
 	 */
 	rc = sata_scr_read(link, SCR_STATUS, &sstatus);
-	if (rc == 0)
+	if (rc == 0 && ata_sstatus_online(sstatus))
 		spd = (sstatus >> 4) & 0xf;
 	else
 		spd = link->sata_spd;
@@ -5161,7 +5166,7 @@ bool ata_phys_link_online(struct ata_link *link)
 	u32 sstatus;
 
 	if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0 &&
-	    (sstatus & 0xf) == 0x3)
+	    ata_sstatus_online(sstatus))
 		return true;
 	return false;
 }
@@ -5185,7 +5190,7 @@ bool ata_phys_link_offline(struct ata_link *link)
 	u32 sstatus;
 
 	if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0 &&
-	    (sstatus & 0xf) != 0x3)
+	    !ata_sstatus_online(sstatus))
 		return true;
 	return false;
 }
-- 
1.6.0.2

