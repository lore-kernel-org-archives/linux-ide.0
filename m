From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 1/4] libata: Allow NCQ TRIM to be enabled or disabled with a module parameter
Date: Mon,  4 May 2015 21:54:18 -0400
Message-ID: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41476 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610AbbEEByf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 21:54:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.de, linux-ide@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>

We have started seeing SSD firmware updates introduce support for queued
TRIM. Sadly, in most cases this support is completely untested and can
lead to either errors or data corruption.

Add two libata force flags that can be used to either enable or disable
queued TRIM support.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 Documentation/kernel-parameters.txt | 2 ++
 drivers/ata/libata-core.c           | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 61ab1628a057..a2e4891a714f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1774,6 +1774,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 			* [no]ncq: Turn on or off NCQ.
 
+			* [no]ncqtrim: Turn off queued DSM TRIM.
+
 			* nohrst, nosrst, norst: suppress hard, soft
                           and both resets.
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4476fb590733..9cebd7872ac6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6472,6 +6472,8 @@ static int __init ata_parse_force_one(char **cur,
 		{ "3.0Gbps",	.spd_limit	= 2 },
 		{ "noncq",	.horkage_on	= ATA_HORKAGE_NONCQ },
 		{ "ncq",	.horkage_off	= ATA_HORKAGE_NONCQ },
+		{ "noncqtrim",	.horkage_on	= ATA_HORKAGE_NO_NCQ_TRIM },
+		{ "ncqtrim",	.horkage_off	= ATA_HORKAGE_NO_NCQ_TRIM },
 		{ "dump_id",	.horkage_on	= ATA_HORKAGE_DUMP_ID },
 		{ "pio0",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 0) },
 		{ "pio1",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 1) },
-- 
1.9.3

