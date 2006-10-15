From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/18] [PATCH] libata-link: add PMP related ATA constants
Date: Mon, 16 Oct 2006 07:54:40 +0900
Message-ID: <1160952880699-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:2229 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422925AbWJOWys (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:48 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626618nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:46 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add Port Multiplier related ATA constants and macros.  Some of these
will be used by ata_link implementation.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/ata.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 1df9416..123f316 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -156,6 +156,8 @@ enum {
 	ATA_CMD_READ_NATIVE_MAX	= 0xF8,
 	ATA_CMD_READ_NATIVE_MAX_EXT = 0x27,
 	ATA_CMD_READ_LOG_EXT	= 0x2f,
+	ATA_CMD_PMP_READ	= 0xE4,
+	ATA_CMD_PMP_WRITE	= 0xE8,
 
 	/* READ_LOG_EXT pages */
 	ATA_LOG_SATA_NCQ	= 0x10,
@@ -196,6 +198,28 @@ enum {
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
@@ -396,4 +420,9 @@ static inline int lba_48_ok(u64 block, u
 	return ((block + n_block - 1) < ((u64)1 << 48)) && (n_block <= 65536);
 }
 
+#define sata_pmp_gscr_vendor(gscr)	((gscr)[SATA_PMP_GSCR_PROD_ID] & 0xffff)
+#define sata_pmp_gscr_devid(gscr)	((gscr)[SATA_PMP_GSCR_PROD_ID] >> 16)
+#define sata_pmp_gscr_rev(gscr)		(((gscr)[SATA_PMP_GSCR_REV] >> 8) & 0xff)
+#define sata_pmp_gscr_ports(gscr)	((gscr)[SATA_PMP_GSCR_PORT_INFO] & 0xf)
+
 #endif /* __LINUX_ATA_H__ */
-- 
1.4.2.3


