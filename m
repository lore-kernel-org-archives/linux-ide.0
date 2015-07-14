From: Arne Fitzenreiter <arne_f@ipfire.org>
Subject: [PATCH 1/2] libata: add ATA_HORKAGE_NOTRIM
Date: Tue, 14 Jul 2015 15:01:48 +0200
Message-ID: <1436878909-26698-2-git-send-email-arne_f@ipfire.org>
References: <1436878909-26698-1-git-send-email-arne_f@ipfire.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail01.ipfire.org ([178.63.73.247]:56222 "EHLO
	mail01.ipfire.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbbGNNCE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2015 09:02:04 -0400
In-Reply-To: <1436878909-26698-1-git-send-email-arne_f@ipfire.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Arne Fitzenreiter <arne_f@ipfire.org>

sone disks lose data at trim also with disabled ncq
so this add a switch to force disable trim.

Signed-off-by: Arne Fitzenreiter <arne_f@ipfire.org>
---
 drivers/ata/libata-scsi.c      | 14 ++++++++------
 drivers/ata/libata-transport.c |  2 ++
 include/linux/libata.h         |  2 ++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3131adc..cc80e4d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2569,12 +2569,14 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 		rbuf[15] = lowest_aligned;
 
 		if (ata_id_has_trim(args->id)) {
-			rbuf[14] |= 0x80; /* LBPME */
-
-			if (ata_id_has_zero_after_trim(args->id) &&
-			    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM) {
-				ata_dev_info(dev, "Enabling discard_zeroes_data\n");
-				rbuf[14] |= 0x40; /* LBPRZ */
+			if (!(dev->horkage & ATA_HORKAGE_NOTRIM)) {
+				rbuf[14] |= 0x80; /* LBPME */
+
+				if (ata_id_has_zero_after_trim(args->id) &&
+				    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM) {
+					ata_dev_info(dev, "Enabling discard_zeroes_data\n");
+					rbuf[14] |= 0x40; /* LBPRZ */
+				}
 			}
 		}
 	}
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index d6c37bc..e2d9497 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -569,6 +569,8 @@ show_ata_dev_trim(struct device *dev,
 
 	if (!ata_id_has_trim(ata_dev->id))
 		mode = "unsupported";
+	else if (ata_dev->horkage & ATA_HORKAGE_NOTRIM)
+		mode = "forced_unsupported";
 	else if (ata_dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
 			mode = "forced_unqueued";
 	else if (ata_fpdma_dsm_supported(ata_dev))
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 36ce37b..5c8bac6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -431,6 +431,8 @@ enum {
 	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
 	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
 	ATA_HORKAGE_NO_NCQ_LOG	= (1 << 23),	/* don't use NCQ for log read */
+	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
+
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
2.4.4

