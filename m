From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH v5 3/4] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Sat, 24 Aug 2013 23:22:50 -0700
Message-ID: <1377411771-3733-4-git-send-email-marc.ceeeee@gmail.com>
References: <1377411771-3733-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:51496 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005Ab3HYGXU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Aug 2013 02:23:20 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so2200357obb.1
        for <linux-ide@vger.kernel.org>; Sat, 24 Aug 2013 23:23:19 -0700 (PDT)
In-Reply-To: <1377411771-3733-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Marc Carino <marc.ceeeee@gmail.com>

From: Marc Carino <marc.ceeeee@gmail.com>

Add support for the following ATA opcodes, which are present
in SATA 3.1 and T13 ATA ACS-3:

        SEND FPDMA QUEUED
        RECEIVE FPDMA QUEUED

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 drivers/ata/libata-core.c | 16 ++++++++++++++++
 include/linux/ata.h       | 21 +++++++++++++++++++++
 include/linux/libata.h    |  4 ++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9062aa0..4866913 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2141,6 +2141,22 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 	else
 		snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
 			ddepth, aa_desc);
+
+	if ((ap->flags & ATA_FLAG_FPDMA_AUX) &&
+	    ata_id_has_ncq_send_and_recv(dev->id)) {
+		err_mask = ata_read_log_page(dev, ATA_LOG_NCQ_SEND_RECV,
+					     0, ap->sector_buf, 1);
+		if (err_mask) {
+			ata_dev_dbg(dev,
+				    "failed to get NCQ Send/Recv Log Emask 0x%x\n",
+				    err_mask);
+		} else {
+			dev->flags |= ATA_DFLAG_NCQ_SEND_RECV;
+			memcpy(dev->ncq_send_recv_cmds, ap->sector_buf,
+				ATA_LOG_NCQ_SEND_RECV_SIZE);
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/ata.h b/include/linux/ata.h
index f63fb1a..bf4c69c 100644
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
+	ATA_LOG_NCQ_SEND_RECV	  = 0x13,
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
+	ATA_LOG_NCQ_SEND_RECV_DSM_TRIM		= (1 << 0),
+	ATA_LOG_NCQ_SEND_RECV_RD_LOG_OFFSET	= 0x08,
+	ATA_LOG_NCQ_SEND_RECV_WR_LOG_OFFSET	= 0x0C,
+	ATA_LOG_NCQ_SEND_RECV_SIZE		= 0x10,
+
 	/* READ/WRITE LONG (obsolete) */
 	ATA_CMD_READ_LONG	= 0x22,
 	ATA_CMD_READ_LONG_ONCE	= 0x23,
@@ -772,6 +788,11 @@ static inline int ata_id_rotation_rate(const u16 *id)
 	return val;
 }
 
+static inline bool ata_id_has_ncq_send_and_recv(const u16 *id)
+{
+	return id[ATA_ID_SATA_CAPABILITY_2] & BIT(6);
+}
+
 static inline bool ata_id_has_trim(const u16 *id)
 {
 	if (ata_id_major_version(id) >= 7 &&
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6539c50..b925504 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -172,6 +172,7 @@ enum {
 	ATA_DFLAG_DUBIOUS_XFER	= (1 << 16), /* data transfer not verified */
 	ATA_DFLAG_NO_UNLOAD	= (1 << 17), /* device doesn't support unload */
 	ATA_DFLAG_UNLOCK_HPA	= (1 << 18), /* unlock HPA */
+	ATA_DFLAG_NCQ_SEND_RECV = (1 << 19), /* device supports NCQ SEND and RECV */
 	ATA_DFLAG_INIT_MASK	= (1 << 24) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 24),
@@ -704,6 +705,9 @@ struct ata_device {
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

