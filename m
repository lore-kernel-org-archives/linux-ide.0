From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH] libata: Add some missing command descriptions
Date: Mon, 21 Oct 2013 19:26:30 -0600
Message-ID: <5265D446.8020002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:58405 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab3JVB2P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Oct 2013 21:28:15 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so563161iec.29
        for <linux-ide@vger.kernel.org>; Mon, 21 Oct 2013 18:28:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, ide <linux-ide@vger.kernel.org>

Add some missing command enumerations from the ATA-8 ACS-3 spec into 
include/linux/ata.h, and add the corresponding human-readable command
descriptions in libata-eh.c.

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c69fcce..ca88c48 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2293,6 +2293,7 @@ const char *ata_get_cmd_descript(u8 command)
 		{ ATA_CMD_IDLE, 		"IDLE" },
 		{ ATA_CMD_EDD, 			"EXECUTE DEVICE DIAGNOSTIC" },
 		{ ATA_CMD_DOWNLOAD_MICRO,   	"DOWNLOAD MICROCODE" },
+		{ ATA_CMD_DOWNLOAD_MICRO_DMA,	"DOWNLOAD MICROCODE DMA" },
 		{ ATA_CMD_NOP,			"NOP" },
 		{ ATA_CMD_FLUSH, 		"FLUSH CACHE" },
 		{ ATA_CMD_FLUSH_EXT, 		"FLUSH CACHE EXT" },
@@ -2313,6 +2314,8 @@ const char *ata_get_cmd_descript(u8 command)
 		{ ATA_CMD_WRITE_QUEUED_FUA_EXT, "WRITE DMA QUEUED FUA EXT" },
 		{ ATA_CMD_FPDMA_READ,		"READ FPDMA QUEUED" },
 		{ ATA_CMD_FPDMA_WRITE,		"WRITE FPDMA QUEUED" },
+		{ ATA_CMD_FPDMA_SEND,		"SEND FPDMA QUEUED" },
+		{ ATA_CMD_FPDMA_RECV,		"RECEIVE FPDMA QUEUED" },
 		{ ATA_CMD_PIO_READ,		"READ SECTOR(S)" },
 		{ ATA_CMD_PIO_READ_EXT,		"READ SECTOR(S) EXT" },
 		{ ATA_CMD_PIO_WRITE,		"WRITE SECTOR(S)" },
@@ -2339,12 +2342,15 @@ const char *ata_get_cmd_descript(u8 command)
 		{ ATA_CMD_WRITE_LOG_EXT,	"WRITE LOG EXT" },
 		{ ATA_CMD_READ_LOG_DMA_EXT,	"READ LOG DMA EXT" },
 		{ ATA_CMD_WRITE_LOG_DMA_EXT, 	"WRITE LOG DMA EXT" },
+		{ ATA_CMD_TRUSTED_NONDATA,	"TRUSTED NON-DATA" },
 		{ ATA_CMD_TRUSTED_RCV,		"TRUSTED RECEIVE" },
 		{ ATA_CMD_TRUSTED_RCV_DMA, 	"TRUSTED RECEIVE DMA" },
 		{ ATA_CMD_TRUSTED_SND,		"TRUSTED SEND" },
 		{ ATA_CMD_TRUSTED_SND_DMA, 	"TRUSTED SEND DMA" },
 		{ ATA_CMD_PMP_READ,		"READ BUFFER" },
+		{ ATA_CMD_PMP_READ_DMA,		"READ BUFFER DMA" },
 		{ ATA_CMD_PMP_WRITE,		"WRITE BUFFER" },
+		{ ATA_CMD_PMP_WRITE_DMA,	"WRITE BUFFER DMA" },
 		{ ATA_CMD_CONF_OVERLAY,		"DEVICE CONFIGURATION OVERLAY" },
 		{ ATA_CMD_SEC_SET_PASS,		"SECURITY SET PASSWORD" },
 		{ ATA_CMD_SEC_UNLOCK,		"SECURITY UNLOCK" },
@@ -2363,6 +2369,8 @@ const char *ata_get_cmd_descript(u8 command)
 		{ ATA_CMD_CFA_TRANS_SECT,	"CFA TRANSLATE SECTOR" },
 		{ ATA_CMD_CFA_ERASE,		"CFA ERASE SECTORS" },
 		{ ATA_CMD_CFA_WRITE_MULT_NE, 	"CFA WRITE MULTIPLE WITHOUT ERASE" },
+		{ ATA_CMD_REQ_SENSE_DATA,	"REQUEST SENSE DATA EXT" },
+		{ ATA_CMD_SANITIZE_DEVICE,	"SANITIZE DEVICE" },
 		{ ATA_CMD_READ_LONG,		"READ LONG (with retries)" },
 		{ ATA_CMD_READ_LONG_ONCE,	"READ LONG (without retries)" },
 		{ ATA_CMD_WRITE_LONG,		"WRITE LONG (with retries)" },
diff --git a/include/linux/ata.h b/include/linux/ata.h
index bf4c69c..f2f4d8d 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -219,6 +219,7 @@ enum {
 	ATA_CMD_IDLE		= 0xE3, /* place in idle power mode */
 	ATA_CMD_EDD		= 0x90,	/* execute device diagnostic */
 	ATA_CMD_DOWNLOAD_MICRO  = 0x92,
+	ATA_CMD_DOWNLOAD_MICRO_DMA = 0x93,
 	ATA_CMD_NOP		= 0x00,
 	ATA_CMD_FLUSH		= 0xE7,
 	ATA_CMD_FLUSH_EXT	= 0xEA,
@@ -268,12 +269,15 @@ enum {
 	ATA_CMD_WRITE_LOG_EXT	= 0x3F,
 	ATA_CMD_READ_LOG_DMA_EXT = 0x47,
 	ATA_CMD_WRITE_LOG_DMA_EXT = 0x57,
+	ATA_CMD_TRUSTED_NONDATA	= 0x5B,
 	ATA_CMD_TRUSTED_RCV	= 0x5C,
 	ATA_CMD_TRUSTED_RCV_DMA = 0x5D,
 	ATA_CMD_TRUSTED_SND	= 0x5E,
 	ATA_CMD_TRUSTED_SND_DMA = 0x5F,
 	ATA_CMD_PMP_READ	= 0xE4,
+	ATA_CMD_PMP_READ_DMA	= 0xE9,
 	ATA_CMD_PMP_WRITE	= 0xE8,
+	ATA_CMD_PMP_WRITE_DMA	= 0xEB,
 	ATA_CMD_CONF_OVERLAY	= 0xB1,
 	ATA_CMD_SEC_SET_PASS	= 0xF1,
 	ATA_CMD_SEC_UNLOCK	= 0xF2,
@@ -292,6 +296,9 @@ enum {
 	ATA_CMD_CFA_TRANS_SECT	= 0x87,
 	ATA_CMD_CFA_ERASE	= 0xC0,
 	ATA_CMD_CFA_WRITE_MULT_NE = 0xCD,
+	ATA_CMD_REQ_SENSE_DATA  = 0x0B,
+	ATA_CMD_SANITIZE_DEVICE = 0xB4,
+
 	/* marked obsolete in the ATA/ATAPI-7 spec */
 	ATA_CMD_RESTORE		= 0x10,
 
