From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH RESEND v2 1/2] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Thu,  8 Aug 2013 00:56:51 -0700
Message-ID: <1375948612-14630-2-git-send-email-marc.ceeeee@gmail.com>
References: <1375948612-14630-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:42112 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab3HHH5K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Aug 2013 03:57:10 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so4971789oah.9
        for <linux-ide@vger.kernel.org>; Thu, 08 Aug 2013 00:57:10 -0700 (PDT)
In-Reply-To: <1375948612-14630-1-git-send-email-marc.ceeeee@gmail.com>
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
 drivers/ata/ahci.h        |  8 ++++++++
 drivers/ata/libahci.c     |  1 +
 drivers/ata/libata-core.c | 15 +++++++++++++++
 include/linux/ata.h       | 23 +++++++++++++++++++++++
 include/linux/libata.h    |  6 ++++++
 5 files changed, 53 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 1145637..f9e4fd8 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -388,4 +388,12 @@ static inline int ahci_nr_ports(u32 cap)
 	return (cap & 0x1f) + 1;
 }
 
+static inline void ahci_h2dfis_set_auxiliary(u8 *fis, u32 aux)
+{
+	fis[16] = aux & 0xff;
+	fis[17] = (aux >> 8) & 0xff;
+	fis[18] = (aux >> 16) & 0xff;
+	fis[19] = (aux >> 24) & 0xff;
+}
+
 #endif /* _AHCI_H */
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index acfd0f7..52668f4 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1499,6 +1499,7 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 	cmd_tbl = pp->cmd_tbl + qc->tag * AHCI_CMD_TBL_SZ;
 
 	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, cmd_tbl);
+	ahci_h2dfis_set_auxiliary(cmd_tbl, qc->auxiliary);
 	if (is_atapi) {
 		memset(cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
 		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c24354d..b0a0b5c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2103,6 +2103,7 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
 	unsigned int err_mask;
 	char *aa_desc = "";
+	u8 sata_setting[ATA_SECT_SIZE];
 
 	if (!ata_id_has_ncq(dev->id)) {
 		desc[0] = '\0';
@@ -2139,6 +2140,20 @@ static int ata_dev_config_ncq(struct ata_device *dev,
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
index ee0bd95..9dba217 100644
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
@@ -865,6 +881,13 @@ static inline int ata_id_rotation_rate(const u16 *id)
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
index 4ea55bb..7ec83b7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -164,6 +164,7 @@ enum {
 	ATA_DFLAG_DA		= (1 << 26), /* device supports Device Attention */
 	ATA_DFLAG_DEVSLP	= (1 << 27), /* device supports Device Sleep */
 	ATA_DFLAG_ACPI_DISABLED = (1 << 28), /* ACPI for the device is disabled */
+	ATA_DFLAG_NCQ_SEND_RECV = (1 << 29), /* device supports NCQ SEND and RECV */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -565,6 +566,7 @@ struct ata_queued_cmd {
 
 	struct ata_taskfile	tf;
 	u8			cdb[ATAPI_CDB_LEN];
+	u32			auxiliary;
 
 	unsigned long		flags;		/* ATA_QCFLAG_xxx */
 	unsigned int		tag;
@@ -660,6 +662,9 @@ struct ata_device {
 	/* DEVSLP Timing Variables from Identify Device Data Log */
 	u8			devslp_timing[ATA_LOG_DEVSLP_SIZE];
 
+	/* NCQ send and receive log subcommand support */
+	u8			ncq_send_recv_cmds[ATA_LOG_NCQ_SEND_RECV_SIZE];
+
 	/* error history */
 	int			spdn_cnt;
 	/* ering is CLEAR_END, read comment above CLEAR_END */
@@ -1556,6 +1561,7 @@ static inline void ata_qc_reinit(struct ata_queued_cmd *qc)
 	qc->n_elem = 0;
 	qc->err_mask = 0;
 	qc->sect_size = ATA_SECT_SIZE;
+	qc->auxiliary = 0;
 
 	ata_tf_init(qc->dev, &qc->tf);
 
-- 
1.8.1.2

