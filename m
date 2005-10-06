From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 3/3] irq-pio: reorganize "buf + offset"
Date: Thu, 06 Oct 2005 18:44:41 +0800
Message-ID: <43450019.1000509@tw.ibm.com>
References: <43438258.9080706@pobox.com> <4344FDED.1080402@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56805 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750807AbVJFKow (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 06:44:52 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j96AikCS016463
	for <linux-ide@vger.kernel.org>; Thu, 6 Oct 2005 06:44:46 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j96Aik08104524
	for <linux-ide@vger.kernel.org>; Thu, 6 Oct 2005 06:44:46 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j96AijYZ004593
	for <linux-ide@vger.kernel.org>; Thu, 6 Oct 2005 06:44:46 -0400
In-Reply-To: <4344FDED.1080402@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Patch 3/3:
   use PageHighMem() to optimize the kmap_atomic() usage, as done in ide-scsi.c

For your review, thanks.

Albert
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


