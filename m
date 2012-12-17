From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] libata: replace sata_settings with devslp_timing
Date: Mon, 17 Dec 2012 23:18:59 +0800
Message-ID: <1355757539-4529-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:32498
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752393Ab2LQPW6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Dec 2012 10:22:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Shane Huang <shane.huang@amd.com>, stable@kernel.org

NCQ capability was used to check availability of SATA Settings page
from Identify Device Data Log, which contains DevSlp timing variables.
It does not work on some HDDs and leads to error messages.

IDENTIFY word 78 bit 5(Hardware Feature Control) can't work either
because it is only the sufficient condition of Identify Device data
log, not the necessary condition.

This patch replaced ata_device->sata_settings with ->devslp_timing
to only save DevSlp timing variables(8 bytes), instead of the whole
SATA Settings page(512 bytes).

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Shane Huang <shane.huang@amd.com>
Cc: stable@kernel.org
---
 drivers/ata/libahci.c     |    6 +++---
 drivers/ata/libata-core.c |   22 +++++++++++++---------
 include/linux/ata.h       |    8 +++++---
 include/linux/libata.h    |    4 ++--
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 320712a..6cd7805 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1951,13 +1951,13 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 	/* Use the nominal value 10 ms if the read MDAT is zero,
 	 * the nominal value of DETO is 20 ms.
 	 */
-	if (dev->sata_settings[ATA_LOG_DEVSLP_VALID] &
+	if (dev->devslp_timing[ATA_LOG_DEVSLP_VALID] &
 	    ATA_LOG_DEVSLP_VALID_MASK) {
-		mdat = dev->sata_settings[ATA_LOG_DEVSLP_MDAT] &
+		mdat = dev->devslp_timing[ATA_LOG_DEVSLP_MDAT] &
 		       ATA_LOG_DEVSLP_MDAT_MASK;
 		if (!mdat)
 			mdat = 10;
-		deto = dev->sata_settings[ATA_LOG_DEVSLP_DETO];
+		deto = dev->devslp_timing[ATA_LOG_DEVSLP_DETO];
 		if (!deto)
 			deto = 20;
 	} else {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9e8b99a..46cd3f4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2325,24 +2325,28 @@ int ata_dev_configure(struct ata_device *dev)
 			}
 		}
 
-		/* check and mark DevSlp capability */
-		if (ata_id_has_devslp(dev->id))
-			dev->flags |= ATA_DFLAG_DEVSLP;
-
-		/* Obtain SATA Settings page from Identify Device Data Log,
-		 * which contains DevSlp timing variables etc.
-		 * Exclude old devices with ata_id_has_ncq()
+		/* Check and mark DevSlp capability. Get DevSlp timing variables
+		 * from SATA Settings page of Identify Device Data Log.
 		 */
-		if (ata_id_has_ncq(dev->id)) {
+		if (ata_id_has_devslp(dev->id)) {
+			u8 sata_setting[ATA_SECT_SIZE];
+			int i, j;
+
+			dev->flags |= ATA_DFLAG_DEVSLP;
 			err_mask = ata_read_log_page(dev,
 						     ATA_LOG_SATA_ID_DEV_DATA,
 						     ATA_LOG_SATA_SETTINGS,
-						     dev->sata_settings,
+						     sata_setting,
 						     1);
 			if (err_mask)
 				ata_dev_dbg(dev,
 					    "failed to get Identify Device Data, Emask 0x%x\n",
 					    err_mask);
+			else
+				for (i = 0; i < ATA_LOG_DEVSLP_SIZE; i++) {
+					j = ATA_LOG_DEVSLP_OFFSET + i;
+					dev->devslp_timing[i] = sata_setting[j];
+				}
 		}
 
 		dev->cdb_len = 16;
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 408da95..8f7a3d6 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -297,10 +297,12 @@ enum {
 	ATA_LOG_SATA_NCQ	= 0x10,
 	ATA_LOG_SATA_ID_DEV_DATA  = 0x30,
 	ATA_LOG_SATA_SETTINGS	  = 0x08,
-	ATA_LOG_DEVSLP_MDAT	  = 0x30,
+	ATA_LOG_DEVSLP_OFFSET	  = 0x30,
+	ATA_LOG_DEVSLP_SIZE	  = 0x08,
+	ATA_LOG_DEVSLP_MDAT	  = 0x00,
 	ATA_LOG_DEVSLP_MDAT_MASK  = 0x1F,
-	ATA_LOG_DEVSLP_DETO	  = 0x31,
-	ATA_LOG_DEVSLP_VALID	  = 0x37,
+	ATA_LOG_DEVSLP_DETO	  = 0x01,
+	ATA_LOG_DEVSLP_VALID	  = 0x07,
 	ATA_LOG_DEVSLP_VALID_MASK = 0x80,
 
 	/* READ/WRITE LONG (obsolete) */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 83ba0ab..649e5f8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -652,8 +652,8 @@ struct ata_device {
 		u32		gscr[SATA_PMP_GSCR_DWORDS]; /* PMP GSCR block */
 	};
 
-	/* Identify Device Data Log (30h), SATA Settings (page 08h) */
-	u8			sata_settings[ATA_SECT_SIZE];
+	/* DEVSLP Timing Variables from Identify Device Data Log */
+	u8			devslp_timing[ATA_LOG_DEVSLP_SIZE];
 
 	/* error history */
 	int			spdn_cnt;
-- 
1.7.10.4


