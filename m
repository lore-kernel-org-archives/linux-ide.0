From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/14] libata-link: add PM related ATA constants
Date: Fri, 12 May 2006 01:30:22 +0900
Message-ID: <11473650222502-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:39563 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751786AbWEKQaa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:30 -0400
Received: by wr-out-0506.google.com with SMTP id i12so405462wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:29 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add Port Multiplier related ATA constants and macros.  Some of these
will be used by ata_link implementation.

---

 include/linux/ata.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

51b532b3a54ccca372762a5f3cad55e65807df27
diff --git a/include/linux/ata.h b/include/linux/ata.h
index c494e1c..41ea837 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -154,6 +154,8 @@ enum {
 	ATA_CMD_READ_NATIVE_MAX	= 0xF8,
 	ATA_CMD_READ_NATIVE_MAX_EXT = 0x27,
 	ATA_CMD_READ_LOG_EXT	= 0x2f,
+	ATA_CMD_PM_READ		= 0xE4,
+	ATA_CMD_PM_WRITE	= 0xE8,
 
 	/* READ_LOG_EXT pages */
 	ATA_LOG_SATA_NCQ	= 0x10,
@@ -187,6 +189,28 @@ enum {
 						   0=to device, 1=to host */
 	ATAPI_CDB_LEN		= 16,
 
+	/* PM stuff */
+	ATA_PM_MAX_PORTS	= 15,
+	ATA_PM_CTRL_PORT	= 15,
+
+	ATA_PM_GSCR_DWORDS	= 128,
+	ATA_PM_GSCR_PROD_ID	= 0,
+	ATA_PM_GSCR_REV		= 1,
+	ATA_PM_GSCR_PORT_INFO	= 2,
+	ATA_PM_GSCR_ERROR	= 32,
+	ATA_PM_GSCR_ERROR_EN	= 33,
+	ATA_PM_GSCR_FEAT	= 64,
+	ATA_PM_GSCR_FEAT_EN	= 96,
+
+	ATA_PM_PSCR_STATUS	= 0,
+	ATA_PM_PSCR_ERROR	= 1,
+	ATA_PM_PSCR_CONTROL	= 2,
+
+	ATA_PM_FEAT_BIST	= (1 << 0),
+	ATA_PM_FEAT_PMREQ	= (1 << 1),
+	ATA_PM_FEAT_DYNSSC	= (1 << 2),
+	ATA_PM_FEAT_NOTIFY	= (1 << 3),
+
 	/* cable types */
 	ATA_CBL_NONE		= 0,
 	ATA_CBL_PATA40		= 1,
@@ -363,4 +387,9 @@ static inline int lba_48_ok(u64 block, u
 	return ((block + n_block - 1) < ((u64)1 << 48)) && (n_block <= 65536);
 }
 
+#define ata_pm_gscr_vendor(gscr)	((gscr)[ATA_PM_GSCR_PROD_ID] & 0xffff)
+#define ata_pm_gscr_devid(gscr)		((gscr)[ATA_PM_GSCR_PROD_ID] >> 16)
+#define ata_pm_gscr_rev(gscr)		(((gscr)[ATA_PM_GSCR_REV] >> 8) & 0xff)
+#define ata_pm_gscr_ports(gscr)		((gscr)[ATA_PM_GSCR_PORT_INFO] & 0xf)
+
 #endif /* __LINUX_ATA_H__ */
-- 
1.2.4


