From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/16] libata-link: add PMP related ATA constants
Date: Sun, 1 Jul 2007 19:05:58 +0900
Message-ID: <11832843582364-git-send-email-htejun@gmail.com>
References: <11832843581399-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:52817 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbXGAKGE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:06:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1879664wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:06:03 -0700 (PDT)
In-Reply-To: <11832843581399-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Add Port Multiplier related ATA constants and macros.  Some of these
will be used by ata_link implementation.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/ata.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 407dc7e..b5a2016 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -164,6 +164,8 @@ enum {
 	ATA_CMD_SET_MAX		= 0xF9,
 	ATA_CMD_SET_MAX_EXT	= 0x37,
 	ATA_CMD_READ_LOG_EXT	= 0x2f,
+	ATA_CMD_PMP_READ	= 0xE4,
+	ATA_CMD_PMP_WRITE	= 0xE8,
 
 	/* READ_LOG_EXT pages */
 	ATA_LOG_SATA_NCQ	= 0x10,
@@ -212,6 +214,28 @@ enum {
 						   0=to device, 1=to host */
 	ATAPI_CDB_LEN		= 16,
 
+	/* PMP stuff */
+	SATA_PMP_MAX_PORTS	= 15,
+	SATA_PMP_CTRL_PORT	= 15,
+
+	SATA_PMP_GSCR_DWORDS	= 128,
+	SATA_PMP_GSCR_PROD_ID	= 0,
+	SATA_PMP_GSCR_REV	= 1,
+	SATA_PMP_GSCR_PORT_INFO	= 2,
+	SATA_PMP_GSCR_ERROR	= 32,
+	SATA_PMP_GSCR_ERROR_EN	= 33,
+	SATA_PMP_GSCR_FEAT	= 64,
+	SATA_PMP_GSCR_FEAT_EN	= 96,
+
+	SATA_PMP_PSCR_STATUS	= 0,
+	SATA_PMP_PSCR_ERROR	= 1,
+	SATA_PMP_PSCR_CONTROL	= 2,
+
+	SATA_PMP_FEAT_BIST	= (1 << 0),
+	SATA_PMP_FEAT_PMREQ	= (1 << 1),
+	SATA_PMP_FEAT_DYNSSC	= (1 << 2),
+	SATA_PMP_FEAT_NOTIFY	= (1 << 3),
+
 	/* cable types */
 	ATA_CBL_NONE		= 0,
 	ATA_CBL_PATA40		= 1,
@@ -418,4 +442,9 @@ static inline int lba_48_ok(u64 block, u32 n_block)
 	return ((block + n_block - 1) < ((u64)1 << 48)) && (n_block <= 65536);
 }
 
+#define sata_pmp_gscr_vendor(gscr)	((gscr)[SATA_PMP_GSCR_PROD_ID] & 0xffff)
+#define sata_pmp_gscr_devid(gscr)	((gscr)[SATA_PMP_GSCR_PROD_ID] >> 16)
+#define sata_pmp_gscr_rev(gscr)		(((gscr)[SATA_PMP_GSCR_REV] >> 8) & 0xff)
+#define sata_pmp_gscr_ports(gscr)	((gscr)[SATA_PMP_GSCR_PORT_INFO] & 0xf)
+
 #endif /* __LINUX_ATA_H__ */
-- 
1.5.0.3


