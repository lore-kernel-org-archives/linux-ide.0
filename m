From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/15] libata: add ATAPI_* cmd types and implement atapi_cmd_type()
Date: Wed,  5 Dec 2007 16:43:06 +0900
Message-ID: <11968405963917-git-send-email-htejun@gmail.com>
References: <11968405951262-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:33171 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbXLEHnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 02:43:53 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6895624wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 23:43:48 -0800 (PST)
In-Reply-To: <11968405951262-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

Add ATAPI command types - ATAPI_READ, WRITE, RW_BUF, READ_CD and MISC,
and implement atapi_cmd_type() which takes SCSI opcode and returns to
which class the opcode belongs.  This will be used later to improve
ATAPI handling.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 62d09c8..72df408 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -35,6 +35,7 @@
 #include <linux/workqueue.h>
 #include <scsi/scsi_host.h>
 #include <linux/acpi.h>
+#include <linux/cdrom.h>
 
 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
@@ -345,6 +346,12 @@ enum {
 	ATA_DMA_MASK_ATA	= (1 << 0),	/* DMA on ATA Disk */
 	ATA_DMA_MASK_ATAPI	= (1 << 1),	/* DMA on ATAPI */
 	ATA_DMA_MASK_CFA	= (1 << 2),	/* DMA on CF Card */
+
+	/* ATAPI command types */
+	ATAPI_READ		= 0,		/* READs */
+	ATAPI_WRITE		= 1,		/* WRITEs */
+	ATAPI_READ_CD		= 2,		/* READ CD [MSF] */
+	ATAPI_MISC		= 3,		/* the rest */
 };
 
 enum ata_xfer_mask {
@@ -1407,6 +1414,27 @@ static inline int ata_try_flush_cache(const struct ata_device *dev)
 	       ata_id_has_flush_ext(dev->id);
 }
 
+static inline int atapi_cmd_type(u8 opcode)
+{
+	switch (opcode) {
+	case GPCMD_READ_10:
+	case GPCMD_READ_12:
+		return ATAPI_READ;
+
+	case GPCMD_WRITE_10:
+	case GPCMD_WRITE_12:
+	case GPCMD_WRITE_AND_VERIFY_10:
+		return ATAPI_WRITE;
+
+	case GPCMD_READ_CD:
+	case GPCMD_READ_CD_MSF:
+		return ATAPI_READ_CD;
+
+	default:
+		return ATAPI_MISC;
+	}
+}
+
 static inline unsigned int ac_err_mask(u8 status)
 {
 	if (status & (ATA_BUSY | ATA_DRQ))
-- 
1.5.2.4

