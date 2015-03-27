From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 1/2] libata: Update Crucial/Micron blacklist
Date: Fri, 27 Mar 2015 15:17:20 -0400
Message-ID: <1427483841-23401-1-git-send-email-martin.petersen@oracle.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Micron has released an updated firmware (MU02) for M510/M550/MX100
drives to fix the issues with queued TRIM. Queued TRIM remains broken on
M500 but is working fine on later drives such as M600 and MX200.

Tweak our blacklist to reflect the above.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=71371
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4c35f0822d06..42455ef977ff 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4204,9 +4204,16 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* devices that don't properly handle queued TRIM commands */
-	{ "Micron_M[56]*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	{ "Micron_M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Micron_M5[15]0*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Crucial_CT*M550*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Crucial_CT*SSD*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
 
 	/*
 	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
@@ -4226,6 +4233,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 */
 	{ "INTEL*SSDSC2MH*",		NULL,	0, },
 
+	{ "Micron*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Crucial*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "INTEL*SSD*", 		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "SSD*INTEL*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
1.9.3
