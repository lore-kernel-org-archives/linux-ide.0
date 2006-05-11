From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/7] libata-pm-prep: add @is_cmd to ata_tf_to_fis()
Date: Fri, 12 May 2006 01:37:50 +0900
Message-ID: <11473654701058-git-send-email-htejun@gmail.com>
References: <11473654703440-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:53139 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030329AbWEKQh5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:37:57 -0400
Received: by wr-out-0506.google.com with SMTP id 55so368907wri
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:37:57 -0700 (PDT)
In-Reply-To: <11473654703440-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add @is_cmd to ata_tf_to_fis().  This controls bit 7 of the second
byte of the constructed FIS which tells the device whether it is for a
command or not.  This cleans up ahci a bit and will be used by PM.

---

 drivers/scsi/ahci.c        |    8 +++-----
 drivers/scsi/libata-core.c |   14 ++++++++------
 drivers/scsi/sata_qstor.c  |    2 +-
 drivers/scsi/sata_sil24.c  |    2 +-
 include/linux/libata.h     |    3 ++-
 5 files changed, 15 insertions(+), 14 deletions(-)

b3b89cc12158046907c50b2112e6bb4e87c5b8cc
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 3254cd2..526150b 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -628,8 +628,7 @@ static int ahci_softreset(struct ata_lin
 			   cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
 
 	tf.ctl |= ATA_SRST;
-	ata_tf_to_fis(&tf, fis, 0);
-	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+	ata_tf_to_fis(&tf, 0, 0, fis);
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 
@@ -647,8 +646,7 @@ static int ahci_softreset(struct ata_lin
 	ahci_fill_cmd_slot(pp, 0, cmd_fis_len);
 
 	tf.ctl &= ~ATA_SRST;
-	ata_tf_to_fis(&tf, fis, 0);
-	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+	ata_tf_to_fis(&tf, 0, 0, fis);
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
@@ -787,7 +785,7 @@ static void ahci_qc_prep(struct ata_queu
 	 */
 	cmd_tbl = pp->cmd_tbl + qc->tag * AHCI_CMD_TBL_SZ;
 
-	ata_tf_to_fis(&qc->tf, cmd_tbl, 0);
+	ata_tf_to_fis(&qc->tf, 0, 1, cmd_tbl);
 	if (is_atapi) {
 		memset(cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
 		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 53b5ed0..b9feefb 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -92,8 +92,9 @@ MODULE_VERSION(DRV_VERSION);
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
@@ -101,12 +102,13 @@ MODULE_VERSION(DRV_VERSION);
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
index fe2a6cf..d1877e0 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -335,7 +335,7 @@ static void qs_qc_prep(struct ata_queued
 	buf[28] = dflags;
 
 	/* frame information structure (FIS) */
-	ata_tf_to_fis(&qc->tf, &buf[32], 0);
+	ata_tf_to_fis(&qc->tf, 0, 1, &buf[32]);
 }
 
 static inline void qs_packet_start(struct ata_queued_cmd *qc)
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 103e5d3..a952513 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -682,7 +682,7 @@ static void sil24_qc_prep(struct ata_que
 	}
 
 	prb->ctrl = cpu_to_le16(ctrl);
-	ata_tf_to_fis(&qc->tf, prb->fis, 0);
+	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, prb->fis);
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
 		sil24_fill_sg(qc, sge);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1fec322..17a4af4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -678,7 +678,8 @@ extern u32 ata_wait_register(void __iome
  */
 extern void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
 extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
-extern void ata_tf_to_fis(const struct ata_taskfile *tf, u8 *fis, u8 pmp);
+extern void ata_tf_to_fis(const struct ata_taskfile *tf,
+			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern u8 ata_noop_check_status(struct ata_port *ap);
 extern void ata_noop_dev_select (struct ata_port *ap, unsigned int device);
-- 
1.2.4


