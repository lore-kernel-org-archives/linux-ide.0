From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 01/03] sil24: ignore non-error exception irqs
Date: Thu,  6 Oct 2005 11:43:29 +0900 (KST)
Message-ID: <20051006024322.D78DDB65@htj.dyndns.org>
References: <20051006024322.E428BF34@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:34222 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751114AbVJFCng (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 22:43:36 -0400
Received: by wproxy.gmail.com with SMTP id i2so150566wra
        for <linux-ide@vger.kernel.org>; Wed, 05 Oct 2005 19:43:35 -0700 (PDT)
In-Reply-To: <20051006024322.E428BF34@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com
Cc: linux-ide@vger.kernel.org

01_sil24_ignore-non-error-exception-irqs.patch

	Do not error-finish commands for non-error exception irqs -
	just ignore them.  This is taken from Edward's driver.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-10-06 11:43:17.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-10-06 11:43:21.000000000 +0900
@@ -489,12 +489,21 @@ static void sil24_error_intr(struct ata_
 	u32 irq_stat, cmd_err, sstatus, serror;
 
 	irq_stat = readl(port + PORT_IRQ_STAT);
+	writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
+
+	if (!(irq_stat & PORT_IRQ_ERROR)) {
+		/* ignore non-completion, non-error irqs for now */
+		printk(KERN_WARNING DRV_NAME
+		       "ata%u: non-error exception irq (irq_stat %x)\n",
+		       ap->id, irq_stat);
+		return;
+	}
+
 	cmd_err = readl(port + PORT_CMD_ERR);
 	sstatus = readl(port + PORT_SSTATUS);
 	serror = readl(port + PORT_SERROR);
 
 	/* Clear IRQ/errors */
-	writel(irq_stat, port + PORT_IRQ_STAT);
 	if (cmd_err)
 		writel(cmd_err, port + PORT_CMD_ERR);
 	if (serror)

