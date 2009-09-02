From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] Do not send RW commands to locked disks.
Date: Tue,  1 Sep 2009 17:28:05 -0700
Message-ID: <1251851285-9159-1-git-send-email-gwendal@google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:57197 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbZIBA3F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Sep 2009 20:29:05 -0400
In-Reply-To: <>
References: <>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

Send a Read/Write command to a locked disk triggers the error handler.
Given the disk returns a generic device error code, the error handler can come
to the conclusion of reducing the link speed, which is bad.
Also, if drives are still locked at boot, this fix speeds up the boot process
by returning errors without invoquing the error handler thread.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-core.c |    2 ++
 drivers/ata/libata-scsi.c |    6 ++++++
 include/linux/ata.h       |    3 +++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 072ba5e..3f80570 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5023,6 +5023,8 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 			    qc->tf.feature != SETFEATURES_WC_OFF)
 				break;
 			/* fall through */
+		case ATA_CMD_SEC_UNLOCK: /* Read/Write access now work */
+		case ATA_CMD_SEC_ERASE_UNIT: /* Read/Write access now work */
 		case ATA_CMD_INIT_DEV_PARAMS: /* CHS translation changed */
 		case ATA_CMD_SET_MULTI: /* multi_count changed */
 			/* revalidate device */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d0dfeef..8a41767 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1658,6 +1658,12 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
 	u32 n_block;
 	int rc;
 
+	if (unlikely(ata_id_locked(qc->dev->id))) {
+		/* Terminate RW commands early when the disk is locked */
+		ata_scsi_set_sense(scmd, ABORTED_COMMAND, 0, 0);
+		return 1;
+	}
+
 	if (cdb[0] == WRITE_10 || cdb[0] == WRITE_6 || cdb[0] == WRITE_16)
 		tf_flags |= ATA_TFLAG_WRITE;
 
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 9c75921..5a5642d 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -247,7 +247,9 @@ enum {
 	ATA_CMD_PMP_READ	= 0xE4,
 	ATA_CMD_PMP_WRITE	= 0xE8,
 	ATA_CMD_CONF_OVERLAY	= 0xB1,
+	ATA_CMD_SEC_ERASE_UNIT	= 0xF4,
 	ATA_CMD_SEC_FREEZE_LOCK	= 0xF5,
+	ATA_CMD_SEC_UNLOCK	= 0xF2,
 	ATA_CMD_SMART		= 0xB0,
 	ATA_CMD_MEDIA_LOCK	= 0xDE,
 	ATA_CMD_MEDIA_UNLOCK	= 0xDF,
@@ -536,6 +538,7 @@ static inline int ata_is_data(u8 prot)
 	  ((u64) (id)[(n) + 0]) )
 
 #define ata_id_cdb_intr(id)	(((id)[ATA_ID_CONFIG] & 0x60) == 0x20)
+#define ata_id_locked(id)	(((id)[ATA_ID_DLF] & 0x7) == 0x7)
 
 static inline bool ata_id_has_hipm(const u16 *id)
 {
-- 
1.5.4.3

