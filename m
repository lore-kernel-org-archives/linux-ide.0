From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/14] libata: add NCQ related ATA constants and id macros
Date: Mon, 3 Apr 2006 17:32:39 +0900
Message-ID: <11440531593535-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.238]:54756 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751527AbWDCIco (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:44 -0400
Received: by wproxy.gmail.com with SMTP id 68so1223805wra
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:43 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add NCQ related ATA constants and id macros.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/ata.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

48e08259332120710872ee5dce6d2051324f5d46
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 283138f..0509340 100644
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
@@ -218,6 +224,7 @@ enum ata_tf_protocols {
 	ATA_PROT_NODATA,	/* no data */
 	ATA_PROT_PIO,		/* PIO single sector */
 	ATA_PROT_DMA,		/* DMA */
+	ATA_PROT_NCQ,		/* NCQ */
 	ATA_PROT_ATAPI,		/* packet command, PIO data xfer*/
 	ATA_PROT_ATAPI_NODATA,	/* packet command, no data */
 	ATA_PROT_ATAPI_DMA,	/* packet command with special DMA sauce */
@@ -273,6 +280,8 @@ struct ata_taskfile {
 #define ata_id_has_pm(id)	((id)[82] & (1 << 3))
 #define ata_id_has_lba(id)	((id)[49] & (1 << 9))
 #define ata_id_has_dma(id)	((id)[49] & (1 << 8))
+#define ata_id_has_ncq(id)	((id)[76] & (1 << 8))
+#define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
 #define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
 #define ata_id_u32(id,n)	\
-- 
1.2.4


