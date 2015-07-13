From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata: add ATA_HORKAGE_MAX_SEC_1024 to revert back to previous max_sectors limit
Date: Mon, 13 Jul 2015 11:48:23 -0500
Message-ID: <1436806103-16503-1-git-send-email-dmilburn@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60429 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbbGMQgc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Jul 2015 12:36:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Since no longer limiting max_sectors to BLK_DEF_MAX_SECTORS (commit 34b48db66e08),
data corruption may occur on ST380013AS drive configured on 82801JI (ICH10 Family)
SATA controller. This patch will allow the driver to limit max_sectors as before

# cat /sys/block/sdb/queue/max_sectors_kb 
512

I was able to double the max_sectors_kb value up to 16384 on linux-4.2.0-rc2
before seeing corruption, but seems safer to use previous limit. Without this 
patch max_sectors_kb will be 32767.

Reported-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/libata-core.c | 7 +++++++
 include/linux/ata.h       | 1 +
 include/linux/libata.h    | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e83fc3d..0ff95eb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2478,6 +2478,10 @@ int ata_dev_configure(struct ata_device *dev)
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_128,
 					 dev->max_sectors);
 
+	if (dev->horkage & ATA_HORKAGE_MAX_SEC_1024)
+		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_1024,
+					 dev->max_sectors);
+
 	if (dev->horkage & ATA_HORKAGE_MAX_SEC_LBA48)
 		dev->max_sectors = ATA_MAX_SECTORS_LBA48;
 
@@ -4146,6 +4150,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Slimtype DVD A  DS8A8SH", NULL,	ATA_HORKAGE_MAX_SEC_LBA48 },
 	{ "Slimtype DVD A  DS8A9SH", NULL,	ATA_HORKAGE_MAX_SEC_LBA48 },
 
+	/* Limit device to previous BLK_DEF_MAX_SECTORS */
+	{ "ST380013AS",		"3.20",		ATA_HORKAGE_MAX_SEC_1024 },
+
 	/* Devices we expect to fail diagnostics */
 
 	/* Devices where NCQ should be avoided */
diff --git a/include/linux/ata.h b/include/linux/ata.h
index fed3641..6c78956 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -45,6 +45,7 @@ enum {
 	ATA_SECT_SIZE		= 512,
 	ATA_MAX_SECTORS_128	= 128,
 	ATA_MAX_SECTORS		= 256,
+	ATA_MAX_SECTORS_1024    = 1024,
 	ATA_MAX_SECTORS_LBA48	= 65535,/* TODO: 65536? */
 	ATA_MAX_SECTORS_TAPE	= 65535,
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 36ce37b..d29e707 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -431,6 +431,7 @@ enum {
 	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
 	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
 	ATA_HORKAGE_NO_NCQ_LOG	= (1 << 23),	/* don't use NCQ for log read */
+	ATA_HORKAGE_MAX_SEC_1024 = (1 << 24),   /* revert back to BLK_DEF_MAX_SECTORS */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
1.8.3.1

