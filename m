From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/6] sata_sil24: kill ops->tf_read() and use ata_std_noop_check_status()
Date: Sat, 20 May 2006 00:38:10 +0900
Message-ID: <11480530901961-git-send-email-htejun@gmail.com>
References: <11480530901755-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:56474 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932353AbWESPiY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 11:38:24 -0400
Received: by wr-out-0506.google.com with SMTP id 50so178349wri
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 08:38:23 -0700 (PDT)
In-Reply-To: <11480530901755-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

sil24 doesn't have single TF image.  Result TF is bound to each
command.  As libata now allows TF-less implementation, kill
ops->tf_read and use ata_std_noop_check_status() for check_status
callbacks.  Result TF is loaded directly from LRAM into qc->result_tf
if necessary.

This patch also makes sil24_hardreset() to request followup SRST as
that's the only way to wait for !BSY.  Note that the original
implementation never worked - if the cached status was !BSY,
ata_busy_sleep() finished immediately; otherwise, it timed out
regardless of the actual device status.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   58 +++++++++++++++------------------------------
 1 files changed, 19 insertions(+), 39 deletions(-)

38e62fb359d3447790ceb43f47ab8c473894f05f
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 89d5d70..def1378 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -311,7 +311,6 @@ static struct sil24_cerr_info {
 struct sil24_port_priv {
 	union sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
-	struct ata_taskfile tf;			/* Cached taskfile registers */
 };
 
 /* ap->host_set->private_data */
@@ -321,10 +320,8 @@ struct sil24_host_priv {
 };
 
 static void sil24_dev_config(struct ata_port *ap, struct ata_device *dev);
-static u8 sil24_check_status(struct ata_port *ap);
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
-static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
@@ -378,12 +375,10 @@ static const struct ata_port_operations 
 
 	.dev_config		= sil24_dev_config,
 
-	.check_status		= sil24_check_status,
-	.check_altstatus	= sil24_check_status,
+	.check_status		= ata_noop_check_status,
+	.check_altstatus	= ata_noop_check_status,
 	.dev_select		= ata_noop_dev_select,
 
-	.tf_read		= sil24_tf_read,
-
 	.probe_reset		= sil24_probe_reset,
 
 	.qc_prep		= sil24_qc_prep,
@@ -460,21 +455,15 @@ static void sil24_dev_config(struct ata_
 		writel(PORT_CS_CDB16, port + PORT_CTRL_CLR);
 }
 
-static inline void sil24_update_tf(struct ata_port *ap)
+static void sil24_read_tf(struct ata_port *ap, int tag, struct ata_taskfile *tf)
 {
-	struct sil24_port_priv *pp = ap->private_data;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
-	struct sil24_prb __iomem *prb = port;
+	struct sil24_prb __iomem *prb;
 	u8 fis[6 * 4];
 
-	memcpy_fromio(fis, prb->fis, 6 * 4);
-	ata_tf_from_fis(fis, &pp->tf);
-}
-
-static u8 sil24_check_status(struct ata_port *ap)
-{
-	struct sil24_port_priv *pp = ap->private_data;
-	return pp->tf.command;
+	prb = port + PORT_LRAM + tag * PORT_LRAM_SLOT_SZ;
+	memcpy_fromio(fis, prb->fis, sizeof(fis));
+	ata_tf_from_fis(fis, tf);
 }
 
 static int sil24_scr_map[] = {
@@ -505,12 +494,6 @@ static void sil24_scr_write(struct ata_p
 	}
 }
 
-static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	struct sil24_port_priv *pp = ap->private_data;
-	*tf = pp->tf;
-}
-
 static int sil24_init_port(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
@@ -533,6 +516,7 @@ static int sil24_softreset(struct ata_po
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
+	struct ata_taskfile tf;
 	u32 mask, irq_stat;
 	const char *reason;
 
@@ -572,8 +556,8 @@ static int sil24_softreset(struct ata_po
 		goto err;
 	}
 
-	sil24_update_tf(ap);
-	*class = ata_dev_classify(&pp->tf);
+	sil24_read_tf(ap, 0, &tf);
+	*class = ata_dev_classify(&tf);
 
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
@@ -608,7 +592,7 @@ static int sil24_hardreset(struct ata_po
 	/* SStatus oscillates between zero and valid status after
 	 * DEV_RST, debounce it.
 	 */
-	rc = sata_phy_debounce(ap, sata_deb_timing_eh);
+	rc = sata_phy_debounce(ap, sata_deb_timing_before_fsrst);
 	if (rc) {
 		reason = "PHY debouncing failed";
 		goto err;
@@ -621,15 +605,13 @@ static int sil24_hardreset(struct ata_po
 		goto err;
 	}
 
-	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
-		reason = "device not ready";
-		goto err;
-	}
-
-	/* sil24 doesn't report device class code after hardreset,
-	 * leave *class alone.
+	/* Sil24 doesn't store signature FIS after hardreset, so we
+	 * can't wait for BSY to clear.  Some devices take a long time
+	 * to get ready and those devices will choke if we don't wait
+	 * for BSY clearance here.  Tell libata to perform follow-up
+	 * softreset.
 	 */
-	return 0;
+	return -EAGAIN;
 
  err:
 	ata_port_printk(ap, KERN_ERR, "hardreset failed (%s)\n", reason);
@@ -816,7 +798,7 @@ static void sil24_error_intr(struct ata_
 		/* record error info */
 		qc = ata_qc_from_tag(ap, ap->active_tag);
 		if (qc) {
-			sil24_update_tf(ap);
+			sil24_read_tf(ap, sil24_tag(qc->tag), &qc->result_tf);
 			qc->err_mask |= err_mask;
 		} else
 			ehi->err_mask |= err_mask;
@@ -834,7 +816,7 @@ static void sil24_error_intr(struct ata_
 static void sil24_finish_qc(struct ata_queued_cmd *qc)
 {
 	if (qc->flags & ATA_QCFLAG_RESULT_TF)
-		sil24_update_tf(qc->ap);
+		sil24_read_tf(qc->ap, sil24_tag(qc->tag), &qc->result_tf);
 }
 
 static inline void sil24_host_intr(struct ata_port *ap)
@@ -954,8 +936,6 @@ static int sil24_port_start(struct ata_p
 	if (!pp)
 		goto err_out;
 
-	pp->tf.command = ATA_DRDY;
-
 	cb = dma_alloc_coherent(dev, cb_size, &cb_dma, GFP_KERNEL);
 	if (!cb)
 		goto err_out_pp;
-- 
1.3.2


