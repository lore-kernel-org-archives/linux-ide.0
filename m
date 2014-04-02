From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 2/2] libata: Update queued trim blacklist for M5x0 drives
Date: Tue,  1 Apr 2014 20:42:37 -0400
Message-ID: <1396399357-28388-2-git-send-email-martin.petersen@oracle.com>
References: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37244 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbaDBAnA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2014 20:43:00 -0400
In-Reply-To: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, Chris Samuel <chris@csamuel.org>, Marc MERLIN <marc@merlins.org>

From: "Martin K. Petersen" <martin.petersen@oracle.com>

Crucial/Micron M500 drives properly support queued DSM TRIM starting
with firmware MU05. Update the blacklist so we only disable queued trim
for older firmware releases.

Early M550 series drives suffer from the same issue as M500. A bugfix
firmware is in the pipeline but not ready yet. Until then, blacklist
queued trim for M550.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Chris Samuel <chris@csamuel.org>
Cc: Marc MERLIN <marc@merlins.org>
---
 drivers/ata/libata-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 34406f7fdd7a..f2a6020366e1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4224,8 +4224,10 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* devices that don't properly handle queued TRIM commands */
-	{ "Micron_M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
-	{ "Crucial_CT???M500SSD*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
+	{ "Micron_M500*",		"MU0[1-4]*",	ATA_HORKAGE_NO_NCQ_TRIM, },
+	{ "Crucial_CT???M500SSD*",	"MU0[1-4]*",	ATA_HORKAGE_NO_NCQ_TRIM, },
+	{ "Micron_M550*",		NULL,		ATA_HORKAGE_NO_NCQ_TRIM, },
+	{ "Crucial_CT???M550SSD*",	NULL,		ATA_HORKAGE_NO_NCQ_TRIM, },
 
 	/*
 	 * Some WD SATA-I drives spin up and down erratically when the link
-- 
1.8.3.1

