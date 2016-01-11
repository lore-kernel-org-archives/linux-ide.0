From: Daniel Walker <danielwa@cisco.com>
Subject: [PATCH -v2] drivers: libata-core : blacklist a Viking flash model for MWDMA corruption
Date: Mon, 11 Jan 2016 14:55:45 -0800
Message-ID: <1452552945-13609-1-git-send-email-danielwa@cisco.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:32939 "EHLO
	rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932553AbcAKWzs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2016 17:55:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Chris Hall <hall@cisco.com>, Shikha Jain <shikjain@cisco.com>, xe-kernel@external.cisco.com, Anil Veliyankara Madam <aveliyan@cisco.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Shikha Jain <shikjain@cisco.com>

Viking flash model VRFDFC22048UCHC-TE causes data corruption in MWDMA mode.

Cc: xe-kernel@external.cisco.com
Signed-off-by: Shikha Jain <shikjain@cisco.com>
Signed-off-by: Anil Veliyankara Madam <aveliyan@cisco.com>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b79cb10..46ebea1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4123,6 +4123,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "SAMSUNG CD-ROM SN-124", "N001",	ATA_HORKAGE_NODMA },
 	{ "Seagate STT20000A", NULL,		ATA_HORKAGE_NODMA },
 	{ " 2GB ATA Flash Disk", "ADMA428M",	ATA_HORKAGE_NODMA },
+	{ "VRFDFC22048UCHC-TE*", NULL,		ATA_HORKAGE_NODMA },
 	/* Odd clown on sil3726/4726 PMPs */
 	{ "Config  Disk",	NULL,		ATA_HORKAGE_DISABLE },
 
-- 
2.1.4

