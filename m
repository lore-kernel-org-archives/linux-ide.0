From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH 1/2] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Fri,  2 Aug 2013 20:34:55 -0700
Message-ID: <1375500896-22955-2-git-send-email-marc.ceeeee@gmail.com>
References: <1375500896-22955-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:45629 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab3HCDgY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Aug 2013 23:36:24 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so2856951oag.10
        for <linux-ide@vger.kernel.org>; Fri, 02 Aug 2013 20:36:23 -0700 (PDT)
In-Reply-To: <1375500896-22955-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Marc C <marc.ceeeee@gmail.com>

From: Marc C <marc.ceeeee@gmail.com>

Add support for the following ATA opcodes, which are present
in SATA 3.1 and T13 ATA ACS-3:

        SEND FPDMA QUEUED
        RECEIVE FPDMA QUEUED

Signed-off-by: Marc C <marc.ceeeee@gmail.com>
---
 drivers/ata/libata-core.c | 25 +++++++++++++++++++++----
 include/linux/ata.h       | 25 +++++++++++++++++++++++++
 include/linux/libata.h    |  4 ++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c24354d..f89b2ef 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -546,6 +546,8 @@ int atapi_cmd_type(u8 opcode)
  */
 void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
 {
+	const __le32 aux = cpu_to_le32(tf->auxiliary);
+
 	fis[0] = 0x27;			/* Register - Host to Device FIS */
 	fis[1] = pmp & 0xf;		/* Port multiplier number*/
 	if (is_cmd)
@@ -569,10 +571,10 @@ void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
 	fis[14] = 0;
 	fis[15] = tf->ctl;
 
-	fis[16] = 0;
-	fis[17] = 0;
-	fis[18] = 0;
-	fis[19] = 0;
+	fis[16] = aux & 0xff;
+	fis[17] = (aux >> 8) & 0xff;
+	fis[18] = (aux >> 16) & 0xff;
+	fis[19] = (aux >> 24) & 0xff;
 }
 
 /**
@@ -2103,6 +2105,7 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
 	unsigned int err_mask;
 	char *aa_desc = "";
+	u8 sata_setting[ATA_SECT_SIZE];
 
 	if (!ata_id_has_ncq(dev->id)) {
 		desc[0] = '\0';
@@ -2139,6 +2142,20 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 	else
 		snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
 			ddepth, aa_desc);
+
+	if (ata_id_has_ncq_send_and_recv(dev->id)) {
+		err_mask = ata_read_log_page(dev,
+					     ATA_LOG_NCQ_SEND_RECV,
+					     0,
+					     sata_setting,
+					     1);
+		if (!err_mask) {
+			dev->flags |= ATA_DFLAG_NCQ_SEND_RECV;
+			memcpy(dev->ncq_send_recv_cmds, sata_setting,
+				ATA_LOG_NCQ_SEND_RECV_SIZE);
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/ata.h b/include/linux/ata.h
index ee0bd95..dd26211 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -239,6 +239,8 @@ enum {
 	ATA_CMD_WRITE_QUEUED_FUA_EXT = 0x3E,
 	ATA_CMD_FPDMA_READ	= 0x60,
 	ATA_CMD_FPDMA_WRITE	= 0x61,
+	ATA_CMD_FPDMA_SEND	= 0x64,
+	ATA_CMD_FPDMA_RECV	= 0x65,
 	ATA_CMD_PIO_READ	= 0x20,
 	ATA_CMD_PIO_READ_EXT	= 0x24,
 	ATA_CMD_PIO_WRITE	= 0x30,
@@ -293,8 +295,13 @@ enum {
 	/* marked obsolete in the ATA/ATAPI-7 spec */
 	ATA_CMD_RESTORE		= 0x10,
 
+	/* Subcmds for ATA_CMD_FPDMA_SEND */
+	ATA_SUBCMD_FPDMA_SEND_DSM            = 0x00,
+	ATA_SUBCMD_FPDMA_SEND_WR_LOG_DMA_EXT = 0x02,
+
 	/* READ_LOG_EXT pages */
 	ATA_LOG_SATA_NCQ	= 0x10,
+	ATA_LOG_NCQ_SEND_RECV	= 0x13,
 	ATA_LOG_SATA_ID_DEV_DATA  = 0x30,
 	ATA_LOG_SATA_SETTINGS	  = 0x08,
 	ATA_LOG_DEVSLP_OFFSET	  = 0x30,
@@ -305,6 +312,15 @@ enum {
 	ATA_LOG_DEVSLP_VALID	  = 0x07,
 	ATA_LOG_DEVSLP_VALID_MASK = 0x80,
 
+	/* NCQ send and receive log */
+	ATA_LOG_NCQ_SEND_RECV_SUBCMDS_OFFSET	= 0x00,
+	ATA_LOG_NCQ_SEND_RECV_SUBCMDS_DSM	= (1 << 0),
+	ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET	= 0x04,
+	ATA_LOG_NCQ_SEND_RECV_DSM_TRIM          = (1 << 0),
+	ATA_LOG_NCQ_SEND_RECV_RD_LOG_OFFSET	= 0x08,
+	ATA_LOG_NCQ_SEND_RECV_WR_LOG_OFFSET	= 0x0C,
+	ATA_LOG_NCQ_SEND_RECV_SIZE		= 0x10,
+
 	/* READ/WRITE LONG (obsolete) */
 	ATA_CMD_READ_LONG	= 0x22,
 	ATA_CMD_READ_LONG_ONCE	= 0x23,
@@ -509,6 +525,8 @@ struct ata_taskfile {
 	u8			device;
 
 	u8			command;	/* IO operation */
+
+	u32			auxiliary;
 };
 
 /*
@@ -865,6 +883,13 @@ static inline int ata_id_rotation_rate(const u16 *id)
 	return val;
 }
 
+static inline bool ata_id_has_ncq_send_and_recv(const u16 *id)
+{
+	if (id[ATA_ID_SATA_CAPABILITY_2] & BIT(6))
+		return true;
+	return false;
+}
+
 static inline bool ata_id_has_trim(const u16 *id)
 {
 	if (ata_id_major_version(id) >= 7 &&
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4ea55bb..5e1b7f4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -164,6 +164,7 @@ enum {
 	ATA_DFLAG_DA		= (1 << 26), /* device supports Device Attention */
 	ATA_DFLAG_DEVSLP	= (1 << 27), /* device supports Device Sleep */
 	ATA_DFLAG_ACPI_DISABLED = (1 << 28), /* ACPI for the device is disabled */
+	ATA_DFLAG_NCQ_SEND_RECV = (1 << 29), /* device supports NCQ SEND and RECV */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -660,6 +661,9 @@ struct ata_device {
 	/* DEVSLP Timing Variables from Identify Device Data Log */
 	u8			devslp_timing[ATA_LOG_DEVSLP_SIZE];
 
+	/* NCQ send and receive log subcommand support */
+	u8			ncq_send_recv_cmds[ATA_LOG_NCQ_SEND_RECV_SIZE];
+
 	/* error history */
 	int			spdn_cnt;
 	/* ering is CLEAR_END, read comment above CLEAR_END */
-- 
1.8.1.2

