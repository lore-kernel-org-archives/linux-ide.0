From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/9] libata: add more opcodes to ata.h
Date: Fri, 14 Dec 2007 15:15:35 +0900
Message-ID: <11976129421484-git-send-email-htejun@gmail.com>
References: <11976129411285-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:60175 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbXLNGPs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 01:15:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1544730wah.23
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 22:15:48 -0800 (PST)
In-Reply-To: <11976129411285-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add constants for DEVICE CONFIGURATION OVERLAY and SET_MAX to
include/linux/ata.h.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/ata.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 5c4e54a..72ab808 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -190,6 +190,8 @@ enum {
 	ATA_CMD_READ_LOG_EXT	= 0x2f,
 	ATA_CMD_PMP_READ	= 0xE4,
 	ATA_CMD_PMP_WRITE	= 0xE8,
+	ATA_CMD_CONF_OVERLAY	= 0xB1,
+	ATA_CMD_SEC_FREEZE_LOCK	= 0xF5,
 
 	/* READ_LOG_EXT pages */
 	ATA_LOG_SATA_NCQ	= 0x10,
@@ -239,6 +241,19 @@ enum {
 	SATA_AN			= 0x05,  /* Asynchronous Notification */
 	SATA_DIPM		= 0x03,  /* Device Initiated Power Management */
 
+	/* feature values for SET_MAX */
+	ATA_SET_MAX_ADDR	= 0x00,
+	ATA_SET_MAX_PASSWD	= 0x01,
+	ATA_SET_MAX_LOCK	= 0x02,
+	ATA_SET_MAX_UNLOCK	= 0x03,
+	ATA_SET_MAX_FREEZE_LOCK	= 0x04,
+
+	/* feature values for DEVICE CONFIGURATION OVERLAY */
+	ATA_DCO_RESTORE		= 0xC0,
+	ATA_DCO_FREEZE_LOCK	= 0xC1,
+	ATA_DCO_IDENTIFY	= 0xC2,
+	ATA_DCO_SET		= 0xC3,
+
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
 	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
-- 
1.5.2.4

