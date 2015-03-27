From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/9] libata: whitespace cleanup in ata_get_cmd_descript()
Date: Fri, 27 Mar 2015 16:46:31 +0100
Message-ID: <1427471198-62676-3-git-send-email-hare@suse.de>
References: <1427471198-62676-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41463 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061AbbC0Pqm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Mar 2015 11:46:42 -0400
In-Reply-To: <1427471198-62676-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-eh.c | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d35d7a7..50ffd4e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2294,27 +2294,27 @@ const char *ata_get_cmd_descript(u8 command)
 		const char *text;
 	} cmd_descr[] = {
 		{ ATA_CMD_DEV_RESET,		"DEVICE RESET" },
-		{ ATA_CMD_CHK_POWER, 		"CHECK POWER MODE" },
-		{ ATA_CMD_STANDBY, 		"STANDBY" },
-		{ ATA_CMD_IDLE, 		"IDLE" },
-		{ ATA_CMD_EDD, 			"EXECUTE DEVICE DIAGNOSTIC" },
-		{ ATA_CMD_DOWNLOAD_MICRO,   	"DOWNLOAD MICROCODE" },
+		{ ATA_CMD_CHK_POWER,		"CHECK POWER MODE" },
+		{ ATA_CMD_STANDBY,		"STANDBY" },
+		{ ATA_CMD_IDLE,			"IDLE" },
+		{ ATA_CMD_EDD,			"EXECUTE DEVICE DIAGNOSTIC" },
+		{ ATA_CMD_DOWNLOAD_MICRO,	"DOWNLOAD MICROCODE" },
 		{ ATA_CMD_DOWNLOAD_MICRO_DMA,	"DOWNLOAD MICROCODE DMA" },
 		{ ATA_CMD_NOP,			"NOP" },
-		{ ATA_CMD_FLUSH, 		"FLUSH CACHE" },
-		{ ATA_CMD_FLUSH_EXT, 		"FLUSH CACHE EXT" },
-		{ ATA_CMD_ID_ATA,  		"IDENTIFY DEVICE" },
-		{ ATA_CMD_ID_ATAPI, 		"IDENTIFY PACKET DEVICE" },
-		{ ATA_CMD_SERVICE, 		"SERVICE" },
-		{ ATA_CMD_READ, 		"READ DMA" },
-		{ ATA_CMD_READ_EXT, 		"READ DMA EXT" },
-		{ ATA_CMD_READ_QUEUED, 		"READ DMA QUEUED" },
-		{ ATA_CMD_READ_STREAM_EXT, 	"READ STREAM EXT" },
+		{ ATA_CMD_FLUSH,		"FLUSH CACHE" },
+		{ ATA_CMD_FLUSH_EXT,		"FLUSH CACHE EXT" },
+		{ ATA_CMD_ID_ATA,		"IDENTIFY DEVICE" },
+		{ ATA_CMD_ID_ATAPI,		"IDENTIFY PACKET DEVICE" },
+		{ ATA_CMD_SERVICE,		"SERVICE" },
+		{ ATA_CMD_READ,			"READ DMA" },
+		{ ATA_CMD_READ_EXT,		"READ DMA EXT" },
+		{ ATA_CMD_READ_QUEUED,		"READ DMA QUEUED" },
+		{ ATA_CMD_READ_STREAM_EXT,	"READ STREAM EXT" },
 		{ ATA_CMD_READ_STREAM_DMA_EXT,  "READ STREAM DMA EXT" },
-		{ ATA_CMD_WRITE, 		"WRITE DMA" },
-		{ ATA_CMD_WRITE_EXT, 		"WRITE DMA EXT" },
-		{ ATA_CMD_WRITE_QUEUED, 	"WRITE DMA QUEUED EXT" },
-		{ ATA_CMD_WRITE_STREAM_EXT, 	"WRITE STREAM EXT" },
+		{ ATA_CMD_WRITE,		"WRITE DMA" },
+		{ ATA_CMD_WRITE_EXT,		"WRITE DMA EXT" },
+		{ ATA_CMD_WRITE_QUEUED,		"WRITE DMA QUEUED EXT" },
+		{ ATA_CMD_WRITE_STREAM_EXT,	"WRITE STREAM EXT" },
 		{ ATA_CMD_WRITE_STREAM_DMA_EXT, "WRITE STREAM DMA EXT" },
 		{ ATA_CMD_WRITE_FUA_EXT,	"WRITE DMA FUA EXT" },
 		{ ATA_CMD_WRITE_QUEUED_FUA_EXT, "WRITE DMA QUEUED FUA EXT" },
@@ -2330,7 +2330,7 @@ const char *ata_get_cmd_descript(u8 command)
 		{ ATA_CMD_READ_MULTI_EXT,	"READ MULTIPLE EXT" },
 		{ ATA_CMD_WRITE_MULTI,		"WRITE MULTIPLE" },
 		{ ATA_CMD_WRITE_MULTI_EXT,	"WRITE MULTIPLE EXT" },
-		{ ATA_CMD_WRITE_MULTI_FUA_EXT, 	"WRITE MULTIPLE FUA EXT" },
+		{ ATA_CMD_WRITE_MULTI_FUA_EXT,	"WRITE MULTIPLE FUA EXT" },
 		{ ATA_CMD_SET_FEATURES,		"SET FEATURES" },
 		{ ATA_CMD_SET_MULTI,		"SET MULTIPLE MODE" },
 		{ ATA_CMD_VERIFY,		"READ VERIFY SECTOR(S)" },
@@ -2347,12 +2347,12 @@ const char *ata_get_cmd_descript(u8 command)
 		{ ATA_CMD_READ_LOG_EXT,		"READ LOG EXT" },
 		{ ATA_CMD_WRITE_LOG_EXT,	"WRITE LOG EXT" },
 		{ ATA_CMD_READ_LOG_DMA_EXT,	"READ LOG DMA EXT" },
-		{ ATA_CMD_WRITE_LOG_DMA_EXT, 	"WRITE LOG DMA EXT" },
+		{ ATA_CMD_WRITE_LOG_DMA_EXT,	"WRITE LOG DMA EXT" },
 		{ ATA_CMD_TRUSTED_NONDATA,	"TRUSTED NON-DATA" },
 		{ ATA_CMD_TRUSTED_RCV,		"TRUSTED RECEIVE" },
-		{ ATA_CMD_TRUSTED_RCV_DMA, 	"TRUSTED RECEIVE DMA" },
+		{ ATA_CMD_TRUSTED_RCV_DMA,	"TRUSTED RECEIVE DMA" },
 		{ ATA_CMD_TRUSTED_SND,		"TRUSTED SEND" },
-		{ ATA_CMD_TRUSTED_SND_DMA, 	"TRUSTED SEND DMA" },
+		{ ATA_CMD_TRUSTED_SND_DMA,	"TRUSTED SEND DMA" },
 		{ ATA_CMD_PMP_READ,		"READ BUFFER" },
 		{ ATA_CMD_PMP_READ_DMA,		"READ BUFFER DMA" },
 		{ ATA_CMD_PMP_WRITE,		"WRITE BUFFER" },
@@ -2369,12 +2369,12 @@ const char *ata_get_cmd_descript(u8 command)
 		{ ATA_CMD_MEDIA_LOCK,		"DOOR LOCK" },
 		{ ATA_CMD_MEDIA_UNLOCK,		"DOOR UNLOCK" },
 		{ ATA_CMD_DSM,			"DATA SET MANAGEMENT" },
-		{ ATA_CMD_CHK_MED_CRD_TYP, 	"CHECK MEDIA CARD TYPE" },
-		{ ATA_CMD_CFA_REQ_EXT_ERR, 	"CFA REQUEST EXTENDED ERROR" },
+		{ ATA_CMD_CHK_MED_CRD_TYP,	"CHECK MEDIA CARD TYPE" },
+		{ ATA_CMD_CFA_REQ_EXT_ERR,	"CFA REQUEST EXTENDED ERROR" },
 		{ ATA_CMD_CFA_WRITE_NE,		"CFA WRITE SECTORS WITHOUT ERASE" },
 		{ ATA_CMD_CFA_TRANS_SECT,	"CFA TRANSLATE SECTOR" },
 		{ ATA_CMD_CFA_ERASE,		"CFA ERASE SECTORS" },
-		{ ATA_CMD_CFA_WRITE_MULT_NE, 	"CFA WRITE MULTIPLE WITHOUT ERASE" },
+		{ ATA_CMD_CFA_WRITE_MULT_NE,	"CFA WRITE MULTIPLE WITHOUT ERASE" },
 		{ ATA_CMD_REQ_SENSE_DATA,	"REQUEST SENSE DATA EXT" },
 		{ ATA_CMD_SANITIZE_DEVICE,	"SANITIZE DEVICE" },
 		{ ATA_CMD_READ_LONG,		"READ LONG (with retries)" },
-- 
1.8.5.2

