From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: add ATA_HORKAGE_NOTRIM
Date: Wed, 15 Jul 2015 11:25:58 -0400
Message-ID: <20150715152558.GA15934@mtj.duckdns.org>
References: <1436961277-4069-1-git-send-email-arne_f@ipfire.org>
 <1436961277-4069-2-git-send-email-arne_f@ipfire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34857 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbGOP0B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2015 11:26:01 -0400
Received: by ykdu72 with SMTP id u72so39231619ykd.2
        for <linux-ide@vger.kernel.org>; Wed, 15 Jul 2015 08:26:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436961277-4069-2-git-send-email-arne_f@ipfire.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arne Fitzenreiter <arne_f@ipfire.org>
Cc: linux-ide@vger.kernel.org

Hello,

Applied to libata/for-4.2-fixes with a minor adjustment and stable tag
added.

Thanks.
----- 8< -----
>From 71d126fd28de2d4d9b7b2088dbccd7ca62fad6e0 Mon Sep 17 00:00:00 2001
From: Arne Fitzenreiter <arne_f@ipfire.org>
Date: Wed, 15 Jul 2015 13:54:36 +0200
Subject: [PATCH] libata: add ATA_HORKAGE_NOTRIM

Some devices lose data on TRIM whether queued or not.  This patch adds
a horkage to disable TRIM.

tj: Collapsed unnecessary if() nesting.

Signed-off-by: Arne Fitzenreiter <arne_f@ipfire.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-scsi.c      | 3 ++-
 drivers/ata/libata-transport.c | 2 ++
 include/linux/libata.h         | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3131adc..641a61a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2568,7 +2568,8 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 		rbuf[14] = (lowest_aligned >> 8) & 0x3f;
 		rbuf[15] = lowest_aligned;
 
-		if (ata_id_has_trim(args->id)) {
+		if (ata_id_has_trim(args->id) &&
+		    !(dev->horkage & ATA_HORKAGE_NOTRIM)) {
 			rbuf[14] |= 0x80; /* LBPME */
 
 			if (ata_id_has_zero_after_trim(args->id) &&
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
2.4.3

