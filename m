From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/12] libata-pmp-prep: add @is_cmd to ata_tf_to_fis()
Date: Sun, 1 Jul 2007 19:26:08 +0900
Message-ID: <11832855683951-git-send-email-htejun@gmail.com>
References: <11832855672398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:26395 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbXGAK0M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:26:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1884684wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:26:12 -0700 (PDT)
In-Reply-To: <11832855672398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Add @is_cmd to ata_tf_to_fis().  This controls bit 7 of the second
byte which tells the device whether this H2D FIS is for a command or
not.  This cleans up ahci a bit and will be used by PMP.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |   10 ++++------
 drivers/ata/libata-core.c |   14 ++++++++------
 drivers/ata/sata_qstor.c  |    2 +-
 drivers/ata/sata_sil24.c  |    2 +-
 include/linux/libata.h    |    3 ++-
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7d315de..d3af721 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -994,8 +994,7 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 			   cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
 
 	tf.ctl |= ATA_SRST;
-	ata_tf_to_fis(&tf, fis, 0);
-	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+	ata_tf_to_fis(&tf, 0, 0, fis);
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 
@@ -1013,8 +1012,7 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 	ahci_fill_cmd_slot(pp, 0, cmd_fis_len);
 
 	tf.ctl &= ~ATA_SRST;
-	ata_tf_to_fis(&tf, fis, 0);
-	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+	ata_tf_to_fis(&tf, 0, 0, fis);
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
@@ -1063,7 +1061,7 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
 	tf.command = 0x80;
-	ata_tf_to_fis(&tf, d2h_fis, 0);
+	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
 	rc = sata_std_hardreset(link, class, deadline);
 
@@ -1184,7 +1182,7 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 	 */
 	cmd_tbl = pp->cmd_tbl + qc->tag * AHCI_CMD_TBL_SZ;
 
-	ata_tf_to_fis(&qc->tf, cmd_tbl, 0);
+	ata_tf_to_fis(&qc->tf, 0, 1, cmd_tbl);
 	if (is_atapi) {
 		memset(cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
 		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1e1855e..e66f7c0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -110,8 +110,9 @@ MODULE_VERSION(DRV_VERSION);
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
@@ -119,12 +120,13 @@ MODULE_VERSION(DRV_VERSION);
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
 
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index dbef6f3..11353b4 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -339,7 +339,7 @@ static void qs_qc_prep(struct ata_queued_cmd *qc)
 	buf[28] = dflags;
 
 	/* frame information structure (FIS) */
-	ata_tf_to_fis(&qc->tf, &buf[32], 0);
+	ata_tf_to_fis(&qc->tf, 0, 1, &buf[32]);
 }
 
 static inline void qs_packet_start(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 1eb3c47..85fd370 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -709,7 +709,7 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
 	}
 
 	prb->ctrl = cpu_to_le16(ctrl);
-	ata_tf_to_fis(&qc->tf, prb->fis, 0);
+	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, prb->fis);
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
 		sil24_fill_sg(qc, sge);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3db3aa5..b310af4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -806,7 +806,8 @@ extern unsigned int ata_dev_try_classify(struct ata_port *, unsigned int, u8 *);
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
1.5.0.3


