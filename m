From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 1/3] irq-pio: reorganize ata_pio_sector() and __atapi_pio_bytes()
Date: Thu, 06 Oct 2005 18:40:06 +0800
Message-ID: <4344FF06.2010708@tw.ibm.com>
References: <43438258.9080706@pobox.com> <4344FDED.1080402@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39313 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750802AbVJFKkL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 06:40:11 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j96AeBTm025637
	for <linux-ide@vger.kernel.org>; Thu, 6 Oct 2005 06:40:11 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j96AeB08091902
	for <linux-ide@vger.kernel.org>; Thu, 6 Oct 2005 06:40:11 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j96AeA3r027356
	for <linux-ide@vger.kernel.org>; Thu, 6 Oct 2005 06:40:10 -0400
In-Reply-To: <4344FDED.1080402@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Patch 1/3:
   reorganize ata_pio_sector() and __atapi_pio_bytes()

Changes:
   - move some code out of the kmap_atomic() / kunmap_atomic() zone
   - remove the redundant "do_write = (qc->tf.flags & ATA_TFLAG_WRITE);"


For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

===========

--- irq-pio/drivers/scsi/libata-core.c	2005-10-06 16:47:05.000000000 +0800
+++ himem1/drivers/scsi/libata-core.c	2005-10-06 15:59:35.000000000 +0800
@@ -2763,22 +2763,21 @@ static void ata_pio_sector(struct ata_qu
  	local_irq_save(flags);
  	buf = kmap_atomic(page, KM_IRQ0) + offset;

-	qc->cursect++;
-	qc->cursg_ofs++;
-
-	if ((qc->cursg_ofs * ATA_SECT_SIZE) == (&sg[qc->cursg])->length) {
-		qc->cursg++;
-		qc->cursg_ofs = 0;
-	}
-
  	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");

  	/* do the actual data transfer */
-	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
  	ata_data_xfer(ap, buf, ATA_SECT_SIZE, do_write);

  	kunmap_atomic(buf - offset, KM_IRQ0);
  	local_irq_restore(flags);
+
+	qc->cursect++;
+	qc->cursg_ofs++;
+
+	if ((qc->cursg_ofs * ATA_SECT_SIZE) == (&sg[qc->cursg])->length) {
+		qc->cursg++;
+		qc->cursg_ofs = 0;
+	}
  }

  /**
@@ -2956,6 +2955,14 @@ next_sg:
  	local_irq_save(flags);
  	buf = kmap_atomic(page, KM_IRQ0) + offset;

+	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+
+	/* do the actual data transfer */
+	ata_data_xfer(ap, buf, count, do_write);
+
+	kunmap_atomic(buf - offset, KM_IRQ0);
+	local_irq_restore(flags);
+
  	bytes -= count;
  	qc->curbytes += count;
  	qc->cursg_ofs += count;
@@ -2965,14 +2972,6 @@ next_sg:
  		qc->cursg_ofs = 0;
  	}

-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
-
-	/* do the actual data transfer */
-	ata_data_xfer(ap, buf, count, do_write);
-
-	kunmap_atomic(buf - offset, KM_IRQ0);
-	local_irq_restore(flags);
-
  	if (bytes)
  		goto next_sg;
  }


