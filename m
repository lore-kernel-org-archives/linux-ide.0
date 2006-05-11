From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/12] libata-ncq: add NCQ related ATA/libata constants and macros
Date: Thu, 11 May 2006 23:44:42 +0900
Message-ID: <1147358682312-git-send-email-htejun@gmail.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:18204 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751803AbWEKOot (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:49 -0400
Received: by nz-out-0102.google.com with SMTP id 13so216447nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:48 -0700 (PDT)
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add NCQ related ATA/libata constants and macros.

---

 include/linux/ata.h    |    9 +++++++++
 include/linux/libata.h |    2 ++
 2 files changed, 11 insertions(+), 0 deletions(-)

65d7503ff8ed1ba872c5538327247b98473a44e9
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 1cbeb43..c494e1c 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -133,6 +133,8 @@ enum {
 	ATA_CMD_WRITE		= 0xCA,
 	ATA_CMD_WRITE_EXT	= 0x35,
 	ATA_CMD_WRITE_FUA_EXT	= 0x3D,
+	ATA_CMD_FPDMA_READ	= 0x60,
+	ATA_CMD_FPDMA_WRITE	= 0x61,
 	ATA_CMD_PIO_READ	= 0x20,
 	ATA_CMD_PIO_READ_EXT	= 0x24,
 	ATA_CMD_PIO_WRITE	= 0x30,
@@ -151,6 +153,10 @@ enum {
 	ATA_CMD_INIT_DEV_PARAMS	= 0x91,
 	ATA_CMD_READ_NATIVE_MAX	= 0xF8,
 	ATA_CMD_READ_NATIVE_MAX_EXT = 0x27,
+	ATA_CMD_READ_LOG_EXT	= 0x2f,
+
+	/* READ_LOG_EXT pages */
+	ATA_LOG_SATA_NCQ	= 0x10,
 
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
@@ -221,6 +227,7 @@ enum ata_tf_protocols {
 	ATA_PROT_NODATA,	/* no data */
 	ATA_PROT_PIO,		/* PIO single sector */
 	ATA_PROT_DMA,		/* DMA */
+	ATA_PROT_NCQ,		/* NCQ */
 	ATA_PROT_ATAPI,		/* packet command, PIO data xfer*/
 	ATA_PROT_ATAPI_NODATA,	/* packet command, no data */
 	ATA_PROT_ATAPI_DMA,	/* packet command with special DMA sauce */
@@ -276,6 +283,8 @@ struct ata_taskfile {
 #define ata_id_has_pm(id)	((id)[82] & (1 << 3))
 #define ata_id_has_lba(id)	((id)[49] & (1 << 9))
 #define ata_id_has_dma(id)	((id)[49] & (1 << 8))
+#define ata_id_has_ncq(id)	((id)[76] & (1 << 8))
+#define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
 #define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
 #define ata_id_u32(id,n)	\
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ed884d6..c9d20d4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -125,6 +125,7 @@ enum {
 	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
 	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
 	ATA_DFLAG_CDB_INTR	= (1 << 2), /* device asserts INTRQ when ready for CDB */
+	ATA_DFLAG_NCQ		= (1 << 3), /* device supports NCQ */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
@@ -152,6 +153,7 @@ enum {
 	ATA_FLAG_IRQ_MASK	= (1 << 9), /* Mask IRQ in PIO xfers */
 	ATA_FLAG_PIO_POLLING	= (1 << 10), /* use polling PIO if LLD
 					      * doesn't handle PIO interrupts */
+	ATA_FLAG_NCQ		= (1 << 11), /* host supports NCQ */
 
 	ATA_FLAG_DEBUGMSG	= (1 << 14),
 	ATA_FLAG_FLUSH_PORT_TASK = (1 << 15), /* flush port task */
-- 
1.2.4


