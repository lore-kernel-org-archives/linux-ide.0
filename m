From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/3] irq-pio: reorganize "buf + offset"
Date: Fri, 07 Oct 2005 14:18:48 +0800
Message-ID: <43461348.60302@tw.ibm.com>
References: <43438258.9080706@pobox.com> <4344FDED.1080402@tw.ibm.com> <4345089A.9020006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:4519 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751157AbVJGGTS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2005 02:19:18 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j976J80g003022
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:19:08 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j976J8XV096066
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:19:08 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j976IvZE016329
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:18:57 -0400
In-Reply-To: <4345089A.9020006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

(Resend)
Patch 2/3:
     reorganize "buf + offset" in ata_pio_sector() and __atapi_pio_bytes()


Changes:
   - relocate DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
   - buf + offset, buf - offset tidy up


Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

===========

--- himem1/drivers/scsi/libata-core.c	2005-10-06 15:59:35.000000000 +0800
+++ himem2/drivers/scsi/libata-core.c	2005-10-06 16:10:33.000000000 +0800
@@ -2760,15 +2760,15 @@ static void ata_pio_sector(struct ata_qu
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;

-	local_irq_save(flags);
-	buf = kmap_atomic(page, KM_IRQ0) + offset;
-
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");

+	local_irq_save(flags);
+	buf = kmap_atomic(page, KM_IRQ0);
+
 	/* do the actual data transfer */
-	ata_data_xfer(ap, buf, ATA_SECT_SIZE, do_write);
+	ata_data_xfer(ap, buf + offset, ATA_SECT_SIZE, do_write);

-	kunmap_atomic(buf - offset, KM_IRQ0);
+	kunmap_atomic(buf, KM_IRQ0);
 	local_irq_restore(flags);

 	qc->cursect++;
@@ -2952,15 +2952,15 @@ next_sg:
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);

-	local_irq_save(flags);
-	buf = kmap_atomic(page, KM_IRQ0) + offset;
-
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");

+	local_irq_save(flags);
+	buf = kmap_atomic(page, KM_IRQ0);
+
 	/* do the actual data transfer */
-	ata_data_xfer(ap, buf, count, do_write);
+	ata_data_xfer(ap, buf + offset, count, do_write);

-	kunmap_atomic(buf - offset, KM_IRQ0);
+	kunmap_atomic(buf, KM_IRQ0);
 	local_irq_restore(flags);

 	bytes -= count;


