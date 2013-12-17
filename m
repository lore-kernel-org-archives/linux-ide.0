From: Marc Carino <marc.ceeeee@gmail.com>
Subject: [PATCH 2/2] libata: disable queued TRIMs for Micron M500 SSDs
Date: Mon, 16 Dec 2013 18:15:54 -0800
Message-ID: <1387246554-7311-3-git-send-email-marc.ceeeee@gmail.com>
References: <1387246554-7311-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34317 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab3LQCQW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Dec 2013 21:16:22 -0500
Received: by mail-ob0-f172.google.com with SMTP id gq1so5749121obb.31
        for <linux-ide@vger.kernel.org>; Mon, 16 Dec 2013 18:16:22 -0800 (PST)
In-Reply-To: <1387246554-7311-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: marc.ceeeee@gmail.com, mykola.dvornik@gmail.com

The Micron/Crucial M500 SSDs exhibit incorrect protocol behavior when
issuing queued TRIM commands, which could lead to silent data corruption.

Disable issuance of queued TRIM commands for the affected drives.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 drivers/ata/libata-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ff01584..715ba06 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2152,6 +2152,13 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 			dev->flags |= ATA_DFLAG_NCQ_SEND_RECV;
 			memcpy(dev->ncq_send_recv_cmds, ap->sector_buf,
 				ATA_LOG_NCQ_SEND_RECV_SIZE);
+
+			if (dev->horkage & ATA_HORKAGE_BROKEN_QUEUED_TRIM) {
+				ata_dev_dbg(dev,
+					    "disabling queued TRIM support\n");
+				dev->ncq_send_recv_cmds[ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET]
+					&= ~ATA_LOG_NCQ_SEND_RECV_DSM_TRIM;
+			}
 		}
 	}
 
@@ -4205,6 +4212,10 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* Devices that don't properly handle queued TRIM commands */
+	{ "Micron_M500*",		NULL,	ATA_HORKAGE_BROKEN_QUEUED_TRIM, },
+	{ "Crucial_CT???M500SSD1",	NULL,	ATA_HORKAGE_BROKEN_QUEUED_TRIM, },
+
 	/* End Marker */
 	{ }
 };
-- 
1.8.1.3

