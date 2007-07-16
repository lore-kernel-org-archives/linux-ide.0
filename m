From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/21] sata_sil24: replace sil24_update_tf() with sil24_read_tf()
Date: Mon, 16 Jul 2007 14:29:39 +0900
Message-ID: <11845637791316-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:3052 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760152AbXGPF3w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1464072wah
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:52 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Replace sil24_update_tf() to sil24_read_tf() which reads TF into
passed int result TF argument and can read TFs of PMP links.  This
will be used by PMP support.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil24.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index a11007b..5f8afa9 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -464,15 +464,15 @@ static void sil24_dev_config(struct ata_device *dev)
 		writel(PORT_CS_CDB16, port + PORT_CTRL_CLR);
 }
 
-static inline void sil24_update_tf(struct ata_port *ap)
+static void sil24_read_tf(struct ata_port *ap, int tag, struct ata_taskfile *tf)
 {
-	struct sil24_port_priv *pp = ap->private_data;
 	void __iomem *port = ap->ioaddr.cmd_addr;
-	struct sil24_prb __iomem *prb = port;
+	struct sil24_prb __iomem *prb;
 	u8 fis[6 * 4];
 
-	memcpy_fromio(fis, prb->fis, 6 * 4);
-	ata_tf_from_fis(fis, &pp->tf);
+	prb = port + PORT_LRAM + sil24_tag(tag) * PORT_LRAM_SLOT_SZ;
+	memcpy_fromio(fis, prb->fis, sizeof(fis));
+	ata_tf_from_fis(fis, tf);
 }
 
 static u8 sil24_check_status(struct ata_port *ap)
@@ -538,6 +538,7 @@ static int sil24_softreset(struct ata_port *ap, unsigned int *class,
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
+	struct ata_taskfile tf;
 	u32 mask, irq_stat;
 	const char *reason;
 
@@ -577,8 +578,8 @@ static int sil24_softreset(struct ata_port *ap, unsigned int *class,
 		goto err;
 	}
 
-	sil24_update_tf(ap);
-	*class = ata_dev_classify(&pp->tf);
+	sil24_read_tf(ap, 0, &tf);
+	*class = ata_dev_classify(&tf);
 
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
@@ -754,6 +755,7 @@ static void sil24_thaw(struct ata_port *ap)
 static void sil24_error_intr(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
+	struct sil24_port_priv *pp = ap->private_data;
 	struct ata_eh_info *ehi = &ap->eh_info;
 	int freeze = 0;
 	u32 irq_stat;
@@ -808,7 +810,7 @@ static void sil24_error_intr(struct ata_port *ap)
 		/* record error info */
 		qc = ata_qc_from_tag(ap, ap->active_tag);
 		if (qc) {
-			sil24_update_tf(ap);
+			sil24_read_tf(ap, qc->tag, &pp->tf);
 			qc->err_mask |= err_mask;
 		} else
 			ehi->err_mask |= err_mask;
@@ -825,8 +827,11 @@ static void sil24_error_intr(struct ata_port *ap)
 
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
1.5.0.3


