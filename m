From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [libata] arbitrary size ATAPI PIO support
Date: Sat, 16 Oct 2004 00:54:08 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04101515549bc5141@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.207]:64797 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267313AbUJOWyI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Oct 2004 18:54:08 -0400
Received: by mproxy.gmail.com with SMTP id 77so27692rnk
        for <linux-ide@vger.kernel.org>; Fri, 15 Oct 2004 15:54:08 -0700 (PDT)
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-10-15 21:39:18 +02:00
+++ b/drivers/scsi/libata-core.c	2004-10-15 21:39:18 +02:00
@@ -2223,11 +2223,50 @@
 	kunmap(page);
 }
 
-static void atapi_pio_sector(struct ata_queued_cmd *qc)
+static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
+{
+	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
+	struct scatterlist *sg = qc->sg;
+	struct ata_port *ap = qc->ap;
+	struct page *page;
+	unsigned char *buf;
+	unsigned int count;
+
+	if (qc->curbytes == qc->nbytes - bytes)
+		ap->pio_task_state = PIO_ST_LAST;
+
+next_sg:
+	sg = &sg[qc->cursg];
+	page = sg->page;
+
+	count = min(sg_dma_len(sg) - qc->cursg_ofs, bytes);
+	buf = kmap(page) + sg->offset + qc->cursg_ofs;
+
+	bytes -= count;
+	qc->curbytes += count;
+	qc->cursg_ofs += count;
+
+	if (qc->cursg_ofs == sg_dma_len(sg)) {
+		qc->cursg++;
+		qc->cursg_ofs = 0;
+	}
+
+	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+
+	/* do the actual data transfer */
+	ata_data_xfer(ap, buf, count, do_write);
+
+	kunmap(page);
+
+	if (bytes)
+		goto next_sg;
+}
+
+static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *dev = qc->dev;
-	unsigned int i, ireason, bc_lo, bc_hi, bytes;
+	unsigned int ireason, bc_lo, bc_hi, bytes;
 	int i_write, do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? 1 : 0;
 
 	ap->ops->tf_read(ap, &qc->tf);
@@ -2245,16 +2284,7 @@
 	if (do_write != i_write)
 		goto err_out;
 
-	/* make sure byte count is multiple of sector size; not
-	* required by standard (warning! warning!), but IDE driver
-	* does this to simplify things a bit.  We are lazy, and
-	* follow suit.
-	*/
-	if (bytes & (ATA_SECT_SIZE - 1))
-		goto err_out;
-
-	for (i = 0; i < (bytes >> 9); i++)
-		ata_pio_sector(qc);
+	__atapi_pio_bytes(qc, bytes);
 
 	return;
 
@@ -2305,7 +2335,7 @@
 	assert(qc != NULL);
 
 	if (is_atapi_taskfile(&qc->tf))
-		atapi_pio_sector(qc);
+		atapi_pio_bytes(qc);
 	else
 		ata_pio_sector(qc);
 }
@@ -2512,6 +2542,7 @@
 		qc->dev = dev;
 		qc->cursect = qc->cursg = qc->cursg_ofs = 0;
 		qc->nsect = 0;
+		qc->nbytes = qc->nbytes = 0;
 
 		ata_tf_init(ap, &qc->tf, dev->devno);
 
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-10-15 21:39:18 +02:00
+++ b/drivers/scsi/libata-scsi.c	2004-10-15 21:39:18 +02:00
@@ -1486,6 +1486,8 @@
 #endif
 	}
 
+	qc->nbytes = cmd->bufflen;
+
 	return 0;
 }
 
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-10-15 21:39:18 +02:00
+++ b/include/linux/libata.h	2004-10-15 21:39:18 +02:00
@@ -231,6 +231,10 @@
 
 	unsigned int		nsect;
 	unsigned int		cursect;
+
+	unsigned int		nbytes;
+	unsigned int		curbytes;
+
 	unsigned int		cursg;
 	unsigned int		cursg_ofs;
