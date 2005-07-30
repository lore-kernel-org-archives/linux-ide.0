From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 02/07] sil24: move error handling out of hot interrupt path
Date: Sat, 30 Jul 2005 19:14:02 +0900 (KST)
Message-ID: <20050730101344.F56FB4A0@htj.dyndns.org>
References: <20050730101344.1C985988@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:16096 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263031AbVG3KOJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2005 06:14:09 -0400
Received: by zproxy.gmail.com with SMTP id i11so693501nzh
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2005 03:14:07 -0700 (PDT)
In-Reply-To: <20050730101344.1C985988@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

02_sil24_separate-out-error-path.patch

	Move error handling from sil24_host_intr into separate
	function - sil24_error_intr.

	Jeff, I don't think this patch actually improves readability
	and/or performance.  Is this what you wanted?

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |   59 +++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 33 insertions(+), 26 deletions(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-07-30 19:13:39.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-07-30 19:13:40.000000000 +0900
@@ -482,6 +482,37 @@ static void sil24_eng_timeout(struct ata
 	sil24_reset_controller(ap);
 }
 
+static void sil24_error_intr(struct ata_port *ap, u32 slot_stat)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	struct sil24_port_priv *pp = ap->private_data;
+	void *port = pp->port;
+	u32 irq_stat, cmd_err, sstatus, serror;
+
+	irq_stat = readl(port + PORT_IRQ_STAT);
+	cmd_err = readl(port + PORT_CMD_ERR);
+	sstatus = readl(port + PORT_SSTATUS);
+	serror = readl(port + PORT_SERROR);
+
+	/* Clear IRQ/errors */
+	writel(irq_stat, port + PORT_IRQ_STAT);
+	if (cmd_err)
+		writel(cmd_err, port + PORT_CMD_ERR);
+	if (serror)
+		writel(serror, port + PORT_SERROR);
+
+	printk(KERN_ERR DRV_NAME " ata%u: error interrupt on port%d\n"
+	       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
+	       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
+
+	/* FIXME: We can do better and emulate the err register too. */
+	pp->stat = ATA_DRDY | ATA_ERR;
+	if (qc)
+		ata_qc_complete(qc, ATA_ERR);
+
+	sil24_reset_controller(ap);
+}
+
 static inline void sil24_host_intr(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -494,32 +525,8 @@ static inline void sil24_host_intr(struc
 		pp->stat = ATA_DRDY;
 		if (qc)
 			ata_qc_complete(qc, 0);
-	} else {
-		u32 irq_stat, cmd_err, sstatus, serror;
-
-		irq_stat = readl(port + PORT_IRQ_STAT);
-		cmd_err = readl(port + PORT_CMD_ERR);
-		sstatus = readl(port + PORT_SSTATUS);
-		serror = readl(port + PORT_SERROR);
-
-		/* Clear IRQ/errors */
-		writel(irq_stat, port + PORT_IRQ_STAT);
-		if (cmd_err)
-			writel(cmd_err, port + PORT_CMD_ERR);
-		if (serror)
-			writel(serror, port + PORT_SERROR);
-
-		printk(KERN_ERR DRV_NAME " ata%u: error interrupt on port%d\n"
-		       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
-		       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
-
-		/* FIXME: We can do better and emulate the err register too. */
-		pp->stat = ATA_DRDY | ATA_ERR;
-		if (qc)
-			ata_qc_complete(qc, ATA_ERR);
-
-		sil24_reset_controller(ap);
-	}
+	} else
+		sil24_error_intr(ap, slot_stat);
 }
 
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs)

