From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/12] sata_sil24: replace sil24_update_tf() with sil24_read_tf()
Date: Sat, 8 Jul 2006 14:58:08 +0900
Message-ID: <1152338288504-git-send-email-htejun@gmail.com>
References: <11523382873130-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.205]:45040 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964790AbWGHF5V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:57:21 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1206439wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:57:20 -0700 (PDT)
In-Reply-To: <11523382873130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Replace sil24_update_tf() to sil24_read_tf() which reads TF into
passed int result TF argument and can read TFs of PMP links.  This
will be used by PMP support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

8bcba5c383f003b3a97aef03041620a6c469e73c
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 370fc6d..069665f 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -474,15 +474,15 @@ static void sil24_dev_config(struct ata_
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
+	prb = port + PORT_LRAM + tag * PORT_LRAM_SLOT_SZ;
+	memcpy_fromio(fis, prb->fis, sizeof(fis));
+	ata_tf_from_fis(fis, tf);
 }
 
 static u8 sil24_check_status(struct ata_port *ap)
@@ -548,6 +548,7 @@ static int sil24_softreset(struct ata_li
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
+	struct ata_taskfile tf;
 	u32 mask, irq_stat;
 	const char *reason;
 
@@ -587,8 +588,8 @@ static int sil24_softreset(struct ata_li
 		goto err;
 	}
 
-	sil24_update_tf(ap);
-	*class = ata_dev_classify(&pp->tf);
+	sil24_read_tf(ap, 0, &tf);
+	*class = ata_dev_classify(&tf);
 
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
@@ -767,6 +768,7 @@ static void sil24_thaw(struct ata_port *
 static void sil24_error_intr(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	struct sil24_port_priv *pp = ap->private_data;
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	int freeze = 0;
 	u32 irq_stat;
@@ -821,7 +823,7 @@ static void sil24_error_intr(struct ata_
 		/* record error info */
 		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc) {
-			sil24_update_tf(ap);
+			sil24_read_tf(ap, qc->tag, &pp->tf);
 			qc->err_mask |= err_mask;
 		} else
 			ehi->err_mask |= err_mask;
@@ -838,8 +840,11 @@ static void sil24_error_intr(struct ata_
 
 static void sil24_finish_qc(struct ata_queued_cmd *qc)
 {
+	struct ata_port *ap = qc->ap;
+	struct sil24_port_priv *pp = ap->private_data;
+
 	if (qc->flags & ATA_QCFLAG_RESULT_TF)
-		sil24_update_tf(qc->ap);
+		sil24_read_tf(ap, qc->tag, &pp->tf);
 }
 
 static inline void sil24_host_intr(struct ata_port *ap)
-- 
1.3.2


