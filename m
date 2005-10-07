From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/3] irq-pio: use PageHighMem() to optimize the kmap_atomic()
 usage
Date: Fri, 07 Oct 2005 14:20:59 +0800
Message-ID: <434613CB.6010600@tw.ibm.com>
References: <43438258.9080706@pobox.com> <4344FDED.1080402@tw.ibm.com> <4345089A.9020006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:23465 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751381AbVJGGVE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2005 02:21:04 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j976L4dj005077
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:21:04 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j976L4vf081306
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:21:04 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j976L3LQ019032
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:21:04 -0400
In-Reply-To: <4345089A.9020006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

(resend)
Patch 3/3:
   use PageHighMem() to optimize the kmap_atomic() usage, as done in ide-scsi.c

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

==========

--- himem2/drivers/scsi/libata-core.c	2005-10-06 16:10:33.000000000 +0800
+++ himem3/drivers/scsi/libata-core.c	2005-10-06 16:08:43.000000000 +0800
@@ -2748,7 +2748,6 @@ static void ata_pio_sector(struct ata_qu
 	struct page *page;
 	unsigned int offset;
 	unsigned char *buf;
-	unsigned long flags;

 	if (qc->cursect == (qc->nsect - 1))
 		ap->hsm_task_state = HSM_ST_LAST;
@@ -2762,14 +2761,21 @@ static void ata_pio_sector(struct ata_qu

 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");

-	local_irq_save(flags);
-	buf = kmap_atomic(page, KM_IRQ0);
+	if (PageHighMem(page)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		buf = kmap_atomic(page, KM_IRQ0);

-	/* do the actual data transfer */
-	ata_data_xfer(ap, buf + offset, ATA_SECT_SIZE, do_write);
+		/* do the actual data transfer */
+		ata_data_xfer(ap, buf + offset, ATA_SECT_SIZE, do_write);

-	kunmap_atomic(buf, KM_IRQ0);
-	local_irq_restore(flags);
+		kunmap_atomic(buf, KM_IRQ0);
+		local_irq_restore(flags);
+	} else {
+		buf = page_address(page);
+		ata_data_xfer(ap, buf + offset, ATA_SECT_SIZE, do_write);
+	}

 	qc->cursect++;
 	qc->cursg_ofs++;
@@ -2908,7 +2914,6 @@ static void __atapi_pio_bytes(struct ata
 	struct page *page;
 	unsigned char *buf;
 	unsigned int offset, count;
-	unsigned long flags;

 	if (qc->curbytes + bytes >= qc->nbytes)
 		ap->hsm_task_state = HSM_ST_LAST;
@@ -2954,14 +2959,21 @@ next_sg:

 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");

-	local_irq_save(flags);
-	buf = kmap_atomic(page, KM_IRQ0);
+	if (PageHighMem(page)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		buf = kmap_atomic(page, KM_IRQ0);

-	/* do the actual data transfer */
-	ata_data_xfer(ap, buf + offset, count, do_write);
+		/* do the actual data transfer */
+		ata_data_xfer(ap, buf + offset, count, do_write);

-	kunmap_atomic(buf, KM_IRQ0);
-	local_irq_restore(flags);
+		kunmap_atomic(buf, KM_IRQ0);
+		local_irq_restore(flags);
+	} else {
+		buf = page_address(page);
+		ata_data_xfer(ap, buf + offset, count, do_write);
+	}

 	bytes -= count;
 	qc->curbytes += count;


