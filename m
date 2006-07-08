From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/6] libata-pmp-prep: add @is_cmd to ata_tf_to_fis()
Date: Sat, 8 Jul 2006 14:51:18 +0900
Message-ID: <11523378784120-git-send-email-htejun@gmail.com>
References: <11523378773934-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:62072 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964782AbWGHFu0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:50:26 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1206133wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:50:26 -0700 (PDT)
In-Reply-To: <11523378773934-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add @is_cmd to ata_tf_to_fis().  This controls bit 7 of the second
byte which tells the device whether this H2D FIS is for a command or
not.  This cleans up ahci a bit and will be used by PMP.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c        |   10 ++++------
 drivers/scsi/libata-core.c |   14 ++++++++------
 drivers/scsi/sata_qstor.c  |    2 +-
 drivers/scsi/sata_sil24.c  |    2 +-
 include/linux/libata.h     |    3 ++-
 5 files changed, 16 insertions(+), 15 deletions(-)

ce524d81b263d170c5c14c90467ac284d5f06252
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f41db5d..9f2f66a 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -662,8 +662,7 @@ static int ahci_softreset(struct ata_lin
 			   cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
 
 	tf.ctl |= ATA_SRST;
-	ata_tf_to_fis(&tf, fis, 0);
-	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+	ata_tf_to_fis(&tf, 0, 0, fis);
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 
@@ -681,8 +680,7 @@ static int ahci_softreset(struct ata_lin
 	ahci_fill_cmd_slot(pp, 0, cmd_fis_len);
 
 	tf.ctl &= ~ATA_SRST;
-	ata_tf_to_fis(&tf, fis, 0);
-	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+	ata_tf_to_fis(&tf, 0, 0, fis);
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
@@ -732,7 +730,7 @@ static int ahci_hardreset(struct ata_lin
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
 	tf.command = 0xff;
-	ata_tf_to_fis(&tf, d2h_fis, 0);
+	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
 	rc = sata_std_hardreset(link, class);
 
@@ -825,7 +823,7 @@ static void ahci_qc_prep(struct ata_queu
 	 */
 	cmd_tbl = pp->cmd_tbl + qc->tag * AHCI_CMD_TBL_SZ;
 
-	ata_tf_to_fis(&qc->tf, cmd_tbl, 0);
+	ata_tf_to_fis(&qc->tf, 0, 1, cmd_tbl);
 	if (is_atapi) {
 		memset(cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
 		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 4d09167..38ddeff 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -100,8 +100,9 @@ MODULE_VERSION(DRV_VERSION);
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
- *	@fis: Buffer into which data will output
  *	@pmp: Port multiplier port
+ *	@is_cmd: This FIS is for command
+ *	@fis: Buffer into which data will output
  *
  *	Converts a standard ATA taskfile to a Serial ATA
  *	FIS structure (Register - Host to Device).
@@ -109,12 +110,13 @@ MODULE_VERSION(DRV_VERSION);
  *	LOCKING:
  *	Inherited from caller.
  */
-
-void ata_tf_to_fis(const struct ata_taskfile *tf, u8 *fis, u8 pmp)
+void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
 {
-	fis[0] = 0x27;	/* Register - Host to Device FIS */
-	fis[1] = (pmp & 0xf) | (1 << 7); /* Port multiplier number,
-					    bit 7 indicates Command FIS */
+	fis[0] = 0x27;			/* Register - Host to Device FIS */
+	fis[1] = pmp & 0xf;		/* Port multiplier number*/
+	if (is_cmd)
+		fis[1] |= (1 << 7);	/* bit 7 indicates Command FIS */
+
 	fis[2] = tf->command;
 	fis[3] = tf->feature;
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index e047890..fca2013 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -336,7 +336,7 @@ static void qs_qc_prep(struct ata_queued
 	buf[28] = dflags;
 
 	/* frame information structure (FIS) */
-	ata_tf_to_fis(&qc->tf, &buf[32], 0);
+	ata_tf_to_fis(&qc->tf, 0, 1, &buf[32]);
 }
 
 static inline void qs_packet_start(struct ata_queued_cmd *qc)
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index b2b8d13..b1ae88d 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -706,7 +706,7 @@ static void sil24_qc_prep(struct ata_que
 	}
 
 	prb->ctrl = cpu_to_le16(ctrl);
-	ata_tf_to_fis(&qc->tf, prb->fis, 0);
+	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, prb->fis);
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
 		sil24_fill_sg(qc, sge);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d65bb05..f46b215 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -741,7 +741,8 @@ extern u32 ata_wait_register(void __iome
  */
 extern void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
 extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
-extern void ata_tf_to_fis(const struct ata_taskfile *tf, u8 *fis, u8 pmp);
+extern void ata_tf_to_fis(const struct ata_taskfile *tf,
+			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern void ata_noop_dev_select (struct ata_port *ap, unsigned int device);
 extern void ata_std_dev_select (struct ata_port *ap, unsigned int device);
-- 
1.3.2


