From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] libata: Do not blacklist Micron M500DC
Date: Thu, 18 Jun 2015 14:50:18 -0400
Message-ID: <1434653418-4562-1-git-send-email-martin.petersen@oracle.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27803 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbbFRSvQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2015 14:51:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org

Queued TRIM got disabled on Micron M500DC drives thanks to the
"Micron_M500*" pattern we had in place to accommodate the previous
generation of this drive family. Tweak the blacklist entry slightly so
we only disable queued TRIM for the non-DC variants of M500 drives.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9cebd7872ac6..8815b9f691bd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4225,7 +4225,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* devices that don't properly handle queued TRIM commands */
-	{ "Micron_M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
2.4.3

