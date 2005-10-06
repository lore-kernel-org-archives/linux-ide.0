From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 03/03] sil24: implement proper TF register reading & caching
Date: Thu,  6 Oct 2005 11:43:39 +0900 (KST)
Message-ID: <20051006024322.4F573E0F@htj.dyndns.org>
References: <20051006024322.E428BF34@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.197]:46984 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751207AbVJFCnp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 22:43:45 -0400
Received: by xproxy.gmail.com with SMTP id i30so190580wxd
        for <linux-ide@vger.kernel.org>; Wed, 05 Oct 2005 19:43:45 -0700 (PDT)
In-Reply-To: <20051006024322.E428BF34@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com
Cc: linux-ide@vger.kernel.org

03_sil24_add-tf-reading.patch

	This patch implements proper TF register reading back and
	caching and bumps up version to 0.22.  This is taken from
	Edward's driver.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |   50 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-10-06 11:43:21.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-10-06 11:43:21.000000000 +0900
@@ -41,7 +41,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_sil24"
-#define DRV_VERSION	"0.21"	/* Silicon Image's preview driver was 0.10 */
+#define DRV_VERSION	"0.22"	/* Silicon Image's preview driver was 0.10 */
 
 #define NR_PORTS	4
 
@@ -216,6 +216,7 @@ struct sil24_cmd_block {
 struct sil24_port_priv {
 	struct sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
+	struct ata_taskfile tf;			/* Cached taskfile registers */
 };
 
 /* ap->host_set->private_data */
@@ -322,14 +323,25 @@ static struct ata_port_info sil24_port_i
 	},
 };
 
+static inline void sil24_update_tf(struct ata_port *ap)
+{
+	struct sil24_port_priv *pp = ap->private_data;
+	void *port = (void *)ap->ioaddr.cmd_addr;
+	struct sil24_prb *prb = port;
+
+	ata_tf_from_fis(prb->fis, &pp->tf);
+}
+
 static u8 sil24_check_status(struct ata_port *ap)
 {
-	return ATA_DRDY;
+	struct sil24_port_priv *pp = ap->private_data;
+	return pp->tf.command;
 }
 
 static u8 sil24_check_err(struct ata_port *ap)
 {
-	return 0;
+	struct sil24_port_priv *pp = ap->private_data;
+	return pp->tf.feature;
 }
 
 static int sil24_scr_map[] = {
@@ -485,6 +497,7 @@ static void sil24_eng_timeout(struct ata
 static void sil24_error_intr(struct ata_port *ap, u32 slot_stat)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	struct sil24_port_priv *pp = ap->private_data;
 	void *port = (void *)ap->ioaddr.cmd_addr;
 	u32 irq_stat, cmd_err, sstatus, serror;
 
@@ -509,8 +522,22 @@ static void sil24_error_intr(struct ata_
 	       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
 	       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
 
+	if (cmd_err == PORT_CERR_DEV || cmd_err == PORT_CERR_SDB) {
+		/*
+		 * Device is reporting error, tf registers are valid.
+		 */
+		sil24_update_tf(ap);
+	} else {
+		/*
+		 * Other errors.  libata currently doesn't have any
+		 * mechanism to report these errors.  Just turn on
+		 * ATA_ERR.
+		 */
+		pp->tf.command = ATA_ERR;
+	}
+
 	if (qc)
-		ata_qc_complete(qc, ATA_ERR);
+		ata_qc_complete(qc, pp->tf.command);
 
 	sil24_reset_controller(ap);
 }
@@ -523,8 +550,19 @@ static inline void sil24_host_intr(struc
 
 	slot_stat = readl(port + PORT_SLOT_STAT);
 	if (!(slot_stat & HOST_SSTAT_ATTN)) {
+		struct sil24_port_priv *pp = ap->private_data;
+		/*
+		 * !HOST_SSAT_ATTN guarantees successful completion,
+		 * so reading back tf registers is unnecessary for
+		 * most commands.  TODO: read tf registers for
+		 * commands which require these values on successful
+		 * completion (EXECUTE DEVICE DIAGNOSTIC, CHECK POWER,
+		 * DEVICE RESET and READ PORT MULTIPLIER (any more?).
+		 */
+		sil24_update_tf(ap);
+
 		if (qc)
-			ata_qc_complete(qc, 0);
+			ata_qc_complete(qc, pp->tf.command);
 	} else
 		sil24_error_intr(ap, slot_stat);
 }
@@ -579,6 +617,8 @@ static int sil24_port_start(struct ata_p
 		return -ENOMEM;
 	memset(pp, 0, sizeof(*pp));
 
+	pp->tf.command = ATA_DRDY;
+
 	cb = dma_alloc_coherent(dev, cb_size, &cb_dma, GFP_KERNEL);
 	if (!cb) {
 		kfree(pp);

