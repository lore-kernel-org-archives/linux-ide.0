From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 04/08] sil24: move error handling out of hot interrupt path
Date: Wed, 17 Aug 2005 13:08:57 +0900 (KST)
Message-ID: <20050817040611.3F4030CA@htj.dyndns.org>
References: <20050817040611.C0A53974@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:38420 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750801AbVHQEJC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 00:09:02 -0400
Received: by wproxy.gmail.com with SMTP id i2so85486wra
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 21:09:02 -0700 (PDT)
In-Reply-To: <20050817040611.C0A53974@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com, Carlos.Pardo@siliconimage.com
Cc: linux-ide@vger.kernel.org

04_sil24_add-error_intr-function.patch

	Move error handling from sil24_host_intr into separate
        function - sil24_error_intr.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |   55 +++++++++++++++++++++++++++++++------------------------
 1 files changed, 31 insertions(+), 24 deletions(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-08-17 13:06:07.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-08-17 13:06:08.000000000 +0900
@@ -480,6 +480,35 @@ static void sil24_eng_timeout(struct ata
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
+	if (qc)
+		ata_qc_complete(qc, ATA_ERR);
+
+	sil24_reset_controller(ap);
+}
+
 static inline void sil24_host_intr(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -491,30 +520,8 @@ static inline void sil24_host_intr(struc
 	if (!(slot_stat & HOST_SSTAT_ATTN)) {
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
-		if (qc)
-			ata_qc_complete(qc, ATA_ERR);
-
-		sil24_reset_controller(ap);
-	}
+	} else
+		sil24_error_intr(ap, slot_stat);
 }
 
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs)

