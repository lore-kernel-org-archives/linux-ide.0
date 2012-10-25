From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_arasan_cf: declare/use 'qc' and 'ap' variables in arasan_cf_dma_start()
Date: Thu, 25 Oct 2012 21:08:46 +0400
Message-ID: <201210252108.47085.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:55395 "EHLO
	wasted.dev.rtsoft.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946112Ab2JYRUM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2012 13:20:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com, viresh.linux@gmail.com

'acdev->qc' and 'acdev->qc->ap' expressions are used multiple times in this
function, so it makes sense to use the local variables for them.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of the 'upstream' branch of libata-dev.git...

 drivers/ata/pata_arasan_cf.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: libata-dev/drivers/ata/pata_arasan_cf.c
===================================================================
--- libata-dev.orig/drivers/ata/pata_arasan_cf.c
+++ libata-dev/drivers/ata/pata_arasan_cf.c
@@ -668,13 +668,15 @@ void arasan_cf_error_handler(struct ata_
 
 static void arasan_cf_dma_start(struct arasan_cf_dev *acdev)
 {
+	struct ata_queued_cmd *qc = acdev->qc;
+	struct ata_port *ap = qc->ap;
 	u32 xfer_ctr = readl(acdev->vbase + XFER_CTR) & ~XFER_DIR_MASK;
-	u32 write = acdev->qc->tf.flags & ATA_TFLAG_WRITE;
+	u32 write = qc->tf.flags & ATA_TFLAG_WRITE;
 
 	xfer_ctr |= write ? XFER_WRITE : XFER_READ;
 	writel(xfer_ctr, acdev->vbase + XFER_CTR);
 
-	acdev->qc->ap->ops->sff_exec_command(acdev->qc->ap, &acdev->qc->tf);
+	ap->ops->sff_exec_command(ap, &qc->tf);
 	ata_sff_queue_work(&acdev->work);
 }
 
