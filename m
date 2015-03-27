From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 2/2] libata: Blacklist queued TRIM on Samsung SSD 850 Pro
Date: Fri, 27 Mar 2015 15:17:21 -0400
Message-ID: <1427483841-23401-2-git-send-email-martin.petersen@oracle.com>
References: <1427483841-23401-1-git-send-email-martin.petersen@oracle.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1427483841-23401-1-git-send-email-martin.petersen@oracle.com>
Sender: stable-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Blacklist queued TRIM on this drive for now.

Reported-by: Stefan Keller <linux-list@zahlenfresser.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
CC: stable@vger.kernel.org
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 42455ef977ff..81be545165d6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4214,6 +4214,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 850 PRO*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
 	/*
 	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
-- 
1.9.3
