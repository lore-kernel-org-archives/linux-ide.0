From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary" field
Date: Thu,  8 Aug 2013 21:49:10 -0700
Message-ID: <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35036 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234Ab3HIEvB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 00:51:01 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so5913511obc.6
        for <linux-ide@vger.kernel.org>; Thu, 08 Aug 2013 21:51:01 -0700 (PDT)
In-Reply-To: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com
Cc: Marc Carino <marc.ceeeee@gmail.com>

From: Marc Carino <marc.ceeeee@gmail.com>

SATA 3.1 added an "auxiliary" field to the host-to-device FIS.

Since there is no analog between the new field and the ATA
taskfile, a new element was added to 'struct ata_queued_cmd."

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 drivers/ata/acard-ahci.c  |  2 +-
 drivers/ata/libahci.c     |  2 +-
 drivers/ata/libata-core.c | 29 +++++++++++++++++++++++++++++
 drivers/ata/sata_fsl.c    |  2 +-
 drivers/ata/sata_mv.c     |  2 +-
 drivers/ata/sata_qstor.c  |  2 +-
 drivers/ata/sata_sil24.c  |  2 +-
 include/linux/libata.h    |  4 ++++
 8 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index fd665d9..a7bf4c4 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -274,7 +274,7 @@ static void acard_ahci_qc_prep(struct ata_queued_cmd *qc)
 	 */
 	cmd_tbl = pp->cmd_tbl + qc->tag * AHCI_CMD_TBL_SZ;
 
-	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, cmd_tbl);
+	ata_qc_to_fis(qc, qc->dev->link->pmp, 1, cmd_tbl);
 	if (is_atapi) {
 		memset(cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
 		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index acfd0f7..2283ea4 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1498,7 +1498,7 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 	 */
 	cmd_tbl = pp->cmd_tbl + qc->tag * AHCI_CMD_TBL_SZ;
 
-	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, cmd_tbl);
+	ata_qc_to_fis(qc, qc->dev->link->pmp, 1, cmd_tbl);
 	if (is_atapi) {
 		memset(cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
 		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c24354d..9d02c47 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -532,6 +532,34 @@ int atapi_cmd_type(u8 opcode)
 }
 
 /**
+ *	ata_qc_to_fis - Convert struct ata_queued_cmd to SATA FIS structure
+ *	@qc: struct ata_queued_cmd to convert
+ *	@pmp: Port multiplier port
+ *	@is_cmd: This FIS is for command
+ *	@fis: Buffer into which data will output
+ *
+ *	Converts a struct ata_queued_cmd to a Serial ATA
+ *	FIS structure (Register - Host to Device).
+ *
+ *	Beginning with SATA 3.1, the ATA taskfile does not completely describe
+ *	all of the fields in a host-to-device FIS. More specifically, the
+ *	'auxiliary' field has no ATA taskfile analog, and thus requires us
+ *	to populate the FIS via the ata_queued_cmd structure.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+void ata_qc_to_fis(const struct ata_queued_cmd *qc, u8 pmp, int is_cmd, u8 *fis)
+{
+	ata_tf_to_fis(&qc->tf, pmp, is_cmd, fis);
+
+	fis[16] = qc->auxiliary & 0xff;
+	fis[17] = (qc->auxiliary >> 8) & 0xff;
+	fis[18] = (qc->auxiliary >> 16) & 0xff;
+	fis[19] = (qc->auxiliary >> 24) & 0xff;
+}
+
+/**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
  *	@pmp: Port multiplier port
@@ -6877,6 +6905,7 @@ EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
 EXPORT_SYMBOL_GPL(atapi_cmd_type);
+EXPORT_SYMBOL_GPL(ata_qc_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 EXPORT_SYMBOL_GPL(ata_pack_xfermask);
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 19720a0..bbdba01 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -525,7 +525,7 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	cd = (struct command_desc *)pp->cmdentry + tag;
 	cd_paddr = pp->cmdentry_paddr + tag * SATA_FSL_CMD_DESC_SIZE;
 
-	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, (u8 *) &cd->cfis);
+	ata_qc_to_fis(qc, qc->dev->link->pmp, 1, (u8 *) &cd->cfis);
 
 	VPRINTK("Dumping cfis : 0x%x, 0x%x, 0x%x\n",
 		cd->cfis[0], cd->cfis[1], cd->cfis[2]);
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 56be318..96fc238 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2267,7 +2267,7 @@ static unsigned int mv_qc_issue_fis(struct ata_queued_cmd *qc)
 	u32 fis[5];
 	int err = 0;
 
-	ata_tf_to_fis(&qc->tf, link->pmp, 1, (void *)fis);
+	ata_qc_to_fis(qc, link->pmp, 1, (void *)fis);
 	err = mv_send_fis(ap, fis, ARRAY_SIZE(fis));
 	if (err)
 		return err;
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 3b0dd57..e0ce396 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -311,7 +311,7 @@ static void qs_qc_prep(struct ata_queued_cmd *qc)
 	buf[28] = dflags;
 
 	/* frame information structure (FIS) */
-	ata_tf_to_fis(&qc->tf, 0, 1, &buf[32]);
+	ata_qc_to_fis(qc, 0, 1, &buf[32]);
 }
 
 static inline void qs_packet_start(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index aa1051b..7e56d48 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -877,7 +877,7 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
 	}
 
 	prb->ctrl = cpu_to_le16(ctrl);
-	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, prb->fis);
+	ata_qc_to_fis(qc, qc->dev->link->pmp, 1, prb->fis);
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
 		sil24_fill_sg(qc, sge);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 283d66b..a4601cc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -604,6 +604,7 @@ struct ata_queued_cmd {
 
 	struct ata_taskfile	tf;
 	u8			cdb[ATAPI_CDB_LEN];
+	u32			auxiliary;
 
 	unsigned long		flags;		/* ATA_QCFLAG_xxx */
 	unsigned int		tag;
@@ -1145,6 +1146,8 @@ extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
 extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
 			u32 val, unsigned long interval, unsigned long timeout);
 extern int atapi_cmd_type(u8 opcode);
+extern void ata_qc_to_fis(const struct ata_queued_cmd *qc,
+			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
@@ -1658,6 +1661,7 @@ static inline void ata_qc_reinit(struct ata_queued_cmd *qc)
 	qc->n_elem = 0;
 	qc->err_mask = 0;
 	qc->sect_size = ATA_SECT_SIZE;
+	qc->auxiliary = 0;
 
 	ata_tf_init(qc->dev, &qc->tf);
 
-- 
1.8.1.2

