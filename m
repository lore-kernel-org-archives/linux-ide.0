From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: [PATCH] libata: SSD horkage introduction
Date: Wed,  1 Sep 2010 15:54:56 -0400
Message-ID: <1283370896-3780-2-git-send-email-peter.petrakis@canonical.com>
References: <1283370896-3780-1-git-send-email-peter.petrakis@canonical.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:40850 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813Ab0IATzJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2010 15:55:09 -0400
In-Reply-To: <1283370896-3780-1-git-send-email-peter.petrakis@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>

Some embedded systems are using 'sub-optimal' SSD storage
devices which amongst other things, don't report their
rotational speed correctly. This commit addresses this by introducing
a new ATA_HORKAGE_NONROT bit and leverages the existing
blacklist framework. Only responses from scsi page 0xb1 are modified,
original identify data is untouched.

Signed-off-by: Peter M. Petrakis <peter.petrakis@canonical.com>
---
 drivers/ata/libata-core.c |    5 +++++
 drivers/ata/libata-scsi.c |    9 +++++++--
 include/linux/libata.h    |    1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7ef7c4f..9bbeeaa 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4259,6 +4259,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 */
 	{ "PIONEER DVD-RW  DVRTD08",	"1.00",	ATA_HORKAGE_NOSETXFER },
 
+	/*
+	 * SSD devices which report themselves incorrectly
+	 */
+	{ "8GB ATA Flash Disk", NULL, ATA_HORKAGE_NONROT }, /* Apacer SDM */
+
 	/* End Marker */
 	{ }
 };
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a89172c..700ab77 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2165,8 +2165,13 @@ static unsigned int ata_scsiop_inq_b1(struct ata_scsi_args *args, u8 *rbuf)
 
 	rbuf[1] = 0xb1;
 	rbuf[3] = 0x3c;
-	rbuf[4] = media_rotation_rate >> 8;
-	rbuf[5] = media_rotation_rate;
+	if (args->dev->horkage & ATA_HORKAGE_NONROT) {
+		rbuf[4] = 0;
+		rbuf[5] = 1;
+	} else {
+		rbuf[4] = media_rotation_rate >> 8;
+		rbuf[5] = media_rotation_rate;
+	}
 	rbuf[7] = form_factor;
 
 	return 0;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f010f18..f36c8aa 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -387,6 +387,7 @@ enum {
 	ATA_HORKAGE_NOSETXFER	= (1 << 14),	/* skip SETXFER, SATA only */
 	ATA_HORKAGE_BROKEN_FPDMA_AA	= (1 << 15),	/* skip AA */
 	ATA_HORKAGE_DUMP_ID	= (1 << 16),	/* dump IDENTIFY data */
+	ATA_HORKAGE_NONROT	= (1 << 17),	/* is non-rotational media, SSD */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
1.7.0.4

