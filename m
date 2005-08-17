From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 06/08] sil24: replace pp->port w/ ap->ioaddr.cmd_addr
Date: Wed, 17 Aug 2005 13:09:07 +0900 (KST)
Message-ID: <20050817040611.24442CA4@htj.dyndns.org>
References: <20050817040611.C0A53974@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.207]:13076 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750834AbVHQEJN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 00:09:13 -0400
Received: by wproxy.gmail.com with SMTP id i20so86190wra
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 21:09:12 -0700 (PDT)
In-Reply-To: <20050817040611.C0A53974@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com, Carlos.Pardo@siliconimage.com
Cc: linux-ide@vger.kernel.org

06_sil24_remove-pp-port.patch

	As ap->ioaddr.cmd_addr isn't used for PORT_TF anymore, replace
	pp->port w/ it as AHCI does.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-08-17 13:06:08.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-08-17 13:06:08.000000000 +0900
@@ -214,7 +214,6 @@ struct sil24_cmd_block {
  * here from the previous interrupt.
  */
 struct sil24_port_priv {
-	void *port;
 	struct sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
 };
@@ -414,10 +413,11 @@ static void sil24_qc_prep(struct ata_que
 static int sil24_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	void *port = (void *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
 	dma_addr_t paddr = pp->cmd_block_dma + qc->tag * sizeof(*pp->cmd_block);
 
-	writel((u32)paddr, pp->port + PORT_CMD_ACTIVATE);
+	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
 	return 0;
 }
 
@@ -428,8 +428,7 @@ static void sil24_irq_clear(struct ata_p
 
 static void sil24_reset_controller(struct ata_port *ap)
 {
-	struct sil24_port_priv *pp = ap->private_data;
-	void *port = pp->port;
+	void *port = (void *)ap->ioaddr.cmd_addr;
 	int cnt;
 	u32 tmp;
 
@@ -480,8 +479,7 @@ static void sil24_eng_timeout(struct ata
 static void sil24_error_intr(struct ata_port *ap, u32 slot_stat)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
-	struct sil24_port_priv *pp = ap->private_data;
-	void *port = pp->port;
+	void *port = (void *)ap->ioaddr.cmd_addr;
 	u32 irq_stat, cmd_err, sstatus, serror;
 
 	irq_stat = readl(port + PORT_IRQ_STAT);
@@ -509,8 +507,7 @@ static void sil24_error_intr(struct ata_
 static inline void sil24_host_intr(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
-	struct sil24_port_priv *pp = ap->private_data;
-	void *port = pp->port;
+	void *port = (void *)ap->ioaddr.cmd_addr;
 	u32 slot_stat;
 
 	slot_stat = readl(port + PORT_SLOT_STAT);
@@ -561,7 +558,6 @@ static irqreturn_t sil24_interrupt(int i
 static int sil24_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
-	struct sil24_host_priv *hpriv = ap->host_set->private_data;
 	struct sil24_port_priv *pp;
 	struct sil24_cmd_block *cb;
 	size_t cb_size = sizeof(*cb);
@@ -579,7 +575,6 @@ static int sil24_port_start(struct ata_p
 	}
 	memset(cb, 0, cb_size);
 
-	pp->port = hpriv->port_base + ap->port_no * PORT_REGS_SIZE;
 	pp->cmd_block = cb;
 	pp->cmd_block_dma = cb_dma;
 
@@ -700,7 +695,7 @@ static int sil24_init_one(struct pci_dev
 		u32 tmp;
 		int cnt;
 
-		probe_ent->port[i].cmd_addr = portu;
+		probe_ent->port[i].cmd_addr = portu + PORT_PRB;
 		probe_ent->port[i].scr_addr = portu + PORT_SCONTROL;
 
 		ata_std_ports(&probe_ent->port[i]);

