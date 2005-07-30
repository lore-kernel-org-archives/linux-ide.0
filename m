From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 01/07] sil24: implement status register emulation
Date: Sat, 30 Jul 2005 19:13:57 +0900 (KST)
Message-ID: <20050730101344.623D22BD@htj.dyndns.org>
References: <20050730101344.1C985988@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:44071 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263036AbVG3KOJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2005 06:14:09 -0400
Received: by zproxy.gmail.com with SMTP id r28so594100nza
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2005 03:14:07 -0700 (PDT)
In-Reply-To: <20050730101344.1C985988@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

01_sil24_add-status-emulation.patch

	Add back status register emulation.  It's very simple.  If the
	previous command completed successfully, we return ATA_DRDY
	for all following status register queries; otherwise, we
	return ATA_DRDY | ATA_ERR.  We can improve error reporting by
	reading CMD_ERROR register and emulating status/error values
	accordingly.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-07-30 19:13:39.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-07-30 19:13:39.000000000 +0900
@@ -217,6 +217,7 @@ struct sil24_cmd_block {
  * here from the previous interrupt.
  */
 struct sil24_port_priv {
+	u8 stat;
 	void *port;
 	struct sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
@@ -328,7 +329,8 @@ static struct ata_port_info sil24_port_i
 
 static u8 sil24_check_status(struct ata_port *ap)
 {
-	return ATA_DRDY;
+	struct sil24_port_priv *pp = ap->private_data;
+	return pp->stat;
 }
 
 static u8 sil24_check_err(struct ata_port *ap)
@@ -489,6 +491,7 @@ static inline void sil24_host_intr(struc
 
 	slot_stat = readl(port + PORT_SLOT_STAT);
 	if (!(slot_stat & HOST_SSTAT_ATTN)) {
+		pp->stat = ATA_DRDY;
 		if (qc)
 			ata_qc_complete(qc, 0);
 	} else {
@@ -510,6 +513,8 @@ static inline void sil24_host_intr(struc
 		       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
 		       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
 
+		/* FIXME: We can do better and emulate the err register too. */
+		pp->stat = ATA_DRDY | ATA_ERR;
 		if (qc)
 			ata_qc_complete(qc, ATA_ERR);
 
@@ -574,6 +579,7 @@ static int sil24_port_start(struct ata_p
 	}
 	memset(cb, 0, cb_size);
 
+	pp->stat = ATA_DRDY;
 	pp->port = hpriv->port_base + ap->port_no * PORT_REGS_SIZE;
 	pp->cmd_block = cb;
 	pp->cmd_block_dma = cb_dma;

