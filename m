From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] libata: Do not blacklist M510DC
Date: Wed, 15 Jul 2015 21:03:23 -0400
Message-ID: <1437008603-16554-1-git-send-email-martin.petersen@oracle.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19335 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbbGPBDh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2015 21:03:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org

A new Micron drive was just announced, once again recycling the first
part of the model string. Add an underscore to the M510/M550 pattern to
avoid picking up the new DC drive.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: <stable@vger.kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 12b176a10d57..db5d9f79a247 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4240,7 +4240,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Micron_M5[15]0*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
+	{ "Micron_M5[15]0_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*M550*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
2.4.3

