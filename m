From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH v2] pata_arasan_cf: declare/use more local variables in arasan_cf_dma_start()
Date: Thu, 1 Nov 2012 18:28:36 +0300
Message-ID: <201211011828.36550.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:50755 "EHLO
	wasted.dev.rtsoft.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761388Ab2KAOat (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Nov 2012 10:30:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com, viresh.linux@gmail.com

'acdev->qc', 'acdev->qc->ap', and 'acdev->qc->tf' expressions are used multiple
times in this function, so it makes sense to use the local variables for them.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

---
The patch is atop of the 'upstream' branch of libata-dev.git...

 drivers/ata/pata_arasan_cf.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: libata-dev/drivers/ata/pata_arasan_cf.c
===================================================================
--- libata-dev.orig/drivers/ata/pata_arasan_cf.c
+++ libata-dev/drivers/ata/pata_arasan_cf.c
@@ -668,13 +668,16 @@ void arasan_cf_error_handler(struct ata_
 
 static void arasan_cf_dma_start(struct arasan_cf_dev *acdev)
 {
+	struct ata_queued_cmd *qc = acdev->qc;
+	struct ata_port *ap = qc->ap;
+	struct ata_taskfile *tf = &qc->tf;
 	u32 xfer_ctr = readl(acdev->vbase + XFER_CTR) & ~XFER_DIR_MASK;
-	u32 write = acdev->qc->tf.flags & ATA_TFLAG_WRITE;
+	u32 write = tf->flags & ATA_TFLAG_WRITE;
 
 	xfer_ctr |= write ? XFER_WRITE : XFER_READ;
 	writel(xfer_ctr, acdev->vbase + XFER_CTR);
 
-	acdev->qc->ap->ops->sff_exec_command(acdev->qc->ap, &acdev->qc->tf);
+	ap->ops->sff_exec_command(ap, tf);
 	ata_sff_queue_work(&acdev->work);
 }
 
