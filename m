From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata vs ATAPI
Date: Thu, 14 Oct 2004 21:19:25 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04101412196d5a5c87@mail.gmail.com>
References: <58cb370e04101213215ce9a23c@mail.gmail.com>
	 <416C438C.4010902@pobox.com>
	 <58cb370e0410121417591ecff0@mail.gmail.com>
	 <20041014071313.GF1454@suse.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.203]:43605 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267376AbUJNTT0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Oct 2004 15:19:26 -0400
Received: by mproxy.gmail.com with SMTP id 77so150497rnk
        for <linux-ide@vger.kernel.org>; Thu, 14 Oct 2004 12:19:26 -0700 (PDT)
In-Reply-To: <20041014071313.GF1454@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, 14 Oct 2004 09:13:13 +0200, Jens Axboe <axboe@suse.de> wrote:
> On Tue, Oct 12 2004, Bartlomiej Zolnierkiewicz wrote:
> > > libata enables DMA at the maximum level supported by both the device and
> > > host controller.  I definitely want to do this by default.
> >
> > Me too but I suppose that there are many devices which don't like it
> > (otherwise restrictions in ide-cd and ide-scsi make no sense).
> >
> > Jens?
> 
> There's no precedens for doing > 128KiB on ATAPI in Linux. Recently Pat
> at Iomega tested 512/1024KiB requests and it worked fine. So if the
> device works, we should be golden...

Cool...

Jeff, I added arbitrary size ATAPI PIO support and it didn't help :(
(still empty info from SCSI layer)

Patch below:

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-10-14 21:18:29 +02:00
+++ b/drivers/scsi/libata-core.c	2004-10-14 21:18:29 +02:00
@@ -2223,11 +2223,48 @@
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
+	count = min(sg_dma_len(sg) - qc->cursg_ofs, bytes);
+	buf = kmap(sg->page) + sg->offset + qc->cursg_ofs;
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
@@ -2245,16 +2282,7 @@
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
 
@@ -2305,7 +2333,7 @@
 	assert(qc != NULL);
 
 	if (is_atapi_taskfile(&qc->tf))
-		atapi_pio_sector(qc);
+		atapi_pio_bytes(qc);
 	else
 		ata_pio_sector(qc);
 }
@@ -2512,6 +2540,7 @@
 		qc->dev = dev;
 		qc->cursect = qc->cursg = qc->cursg_ofs = 0;
 		qc->nsect = 0;
+		qc->nbytes = qc->nbytes = 0;
 
 		ata_tf_init(ap, &qc->tf, dev->devno);
 
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-10-14 21:18:29 +02:00
+++ b/drivers/scsi/libata-scsi.c	2004-10-14 21:18:29 +02:00
@@ -1464,6 +1464,9 @@
 
 	qc->tf.command = ATA_CMD_PACKET;
 
+	if (scsicmd[0] == INQUIRY)
+		using_pio = 1;
+
 	/* no data, or PIO data xfer */
 	if (using_pio || nodata) {
 		if (nodata)
@@ -1485,6 +1488,8 @@
 			qc->tf.feature |= ATAPI_DMADIR;
 #endif
 	}
+
+	qc->nbytes = cmd->bufflen;
 
 	return 0;
 }
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-10-14 21:18:29 +02:00
+++ b/include/linux/libata.h	2004-10-14 21:18:29 +02:00
@@ -231,6 +231,10 @@
 
 	unsigned int		nsect;
 	unsigned int		cursect;
+
+	unsigned int		nbytes;
+	unsigned int		curbytes;
+
 	unsigned int		cursg;
 	unsigned int		cursg_ofs;
