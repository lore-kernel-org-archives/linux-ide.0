From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: [take 2] add support for READ/WRITE LONG commands
Date: Tue, 13 Feb 2007 13:30:43 -0500
Message-ID: <45D203D3.9010807@rtr.ca>
References: <45D10D2E.70408@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3492 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbXBMSbG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Feb 2007 13:31:06 -0500
In-Reply-To: <45D10D2E.70408@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>

[ take 2 -- s/cmd/scmd/; also fixed nbytes in libata-eh ]

The READ/WRITE LONG commands are theoretically obsolete,
but most (all?) drives to date still implement them.

Of these, WRITE_LONG and WRITE_LONG_ONCE are of particular
interest for fault injection testing -- eg. creating "media errors"
at specific locations on a disk.

The fussy bit is that these commands require a non-standard
sector size, usually 520 bytes instead of 512.

This patch adds support to libata for READ/WRITE LONG commands
issued via SG_IO/ATA_16.

Signed-off-by:  Mark Lord <mlord@pobox.com> 
---
diff -u --recursive --new-file --exclude='.*' --exclude='*.[osa]' --exclude='*.ko' --exclude='*.mod.c' linux-2.6.20/drivers/ata/libata-core.c new/drivers/ata/libata-core.c
--- linux-2.6.20/drivers/ata/libata-core.c	2007-02-04 13:44:54.000000000 -0500
+++ new/drivers/ata/libata-core.c	2007-02-12 19:41:55.000000000 -0500
@@ -1249,7 +1249,7 @@
 			buflen += sg[i].length;
 
 		ata_sg_init(qc, sg, n_elem);
-		qc->nsect = buflen / ATA_SECT_SIZE;
+		qc->nsect = buflen / qc->sect_size;
 		qc->nbytes = buflen;
 	}
 
@@ -4004,7 +4004,7 @@
 
 
 /**
- *	ata_pio_sector - Transfer ATA_SECT_SIZE (512 bytes) of data.
+ *	ata_pio_sector - Transfer a "sector" of data.
  *	@qc: Command on going
  *
  *	Transfer ATA_SECT_SIZE of data from/to the ATA device.
@@ -4021,12 +4021,13 @@
 	struct page *page;
 	unsigned int offset;
 	unsigned char *buf;
+	unsigned int sect_size = qc->sect_size;
 
 	if (qc->cursect == (qc->nsect - 1))
 		ap->hsm_task_state = HSM_ST_LAST;
 
 	page = sg[qc->cursg].page;
-	offset = sg[qc->cursg].offset + qc->cursg_ofs * ATA_SECT_SIZE;
+	offset = sg[qc->cursg].offset + qc->cursg_ofs * sect_size;
 
 	/* get the current page and offset */
 	page = nth_page(page, (offset >> PAGE_SHIFT));
@@ -4042,30 +4043,30 @@
 		buf = kmap_atomic(page, KM_IRQ0);
 
 		/* do the actual data transfer */
-		ap->ops->data_xfer(qc->dev, buf + offset, ATA_SECT_SIZE, do_write);
+		ap->ops->data_xfer(qc->dev, buf + offset, sect_size, do_write);
 
 		kunmap_atomic(buf, KM_IRQ0);
 		local_irq_restore(flags);
 	} else {
 		buf = page_address(page);
-		ap->ops->data_xfer(qc->dev, buf + offset, ATA_SECT_SIZE, do_write);
+		ap->ops->data_xfer(qc->dev, buf + offset, sect_size, do_write);
 	}
 
 	qc->cursect++;
 	qc->cursg_ofs++;
 
-	if ((qc->cursg_ofs * ATA_SECT_SIZE) == (&sg[qc->cursg])->length) {
+	if ((qc->cursg_ofs * sect_size) == (&sg[qc->cursg])->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
 }
 
 /**
- *	ata_pio_sectors - Transfer one or many 512-byte sectors.
+ *	ata_pio_sectors - Transfer one or many sectors.
  *	@qc: Command on going
  *
- *	Transfer one or many ATA_SECT_SIZE of data from/to the
- *	ATA device for the DRQ request.
+ *	Transfer one or many qc->sect_size chunks of data
+ *	from/to the ATA device for the DRQ request.
  *
  *	LOCKING:
  *	Inherited from caller.
diff -u --recursive --new-file --exclude='.*' --exclude='*.[osa]' --exclude='*.ko' --exclude='*.mod.c' linux-2.6.20/drivers/ata/libata-eh.c new/drivers/ata/libata-eh.c
--- linux-2.6.20/drivers/ata/libata-eh.c	2007-02-04 13:44:54.000000000 -0500
+++ new/drivers/ata/libata-eh.c	2007-02-13 13:15:22.000000000 -0500
@@ -1450,7 +1450,7 @@
 
 		nbytes = qc->nbytes;
 		if (!nbytes)
-			nbytes = qc->nsect << 9;
+			nbytes = qc->nsect & qc->sect_size;
 
 		ata_dev_printk(qc->dev, KERN_ERR,
 			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
diff -u --recursive --new-file --exclude='.*' --exclude='*.[osa]' --exclude='*.ko' --exclude='*.mod.c' linux-2.6.20/drivers/ata/libata-scsi.c new/drivers/ata/libata-scsi.c
--- linux-2.6.20/drivers/ata/libata-scsi.c	2007-02-04 13:44:54.000000000 -0500
+++ new/drivers/ata/libata-scsi.c	2007-02-13 13:15:53.000000000 -0500
@@ -2634,6 +2634,19 @@
 		tf->device = qc->dev->devno ?
 			tf->device | ATA_DEV1 : tf->device & ~ATA_DEV1;
 
+	/* READ/WRITE LONG use a non-standard sect_size */
+	qc->sect_size = ATA_SECT_SIZE;
+	switch (tf->command) {
+	case ATA_CMD_READ_LONG:
+	case ATA_CMD_READ_LONG_ONCE:
+	case ATA_CMD_WRITE_LONG:
+	case ATA_CMD_WRITE_LONG_ONCE:
+		if (tf->protocol != ATA_PROT_PIO
+		 || tf->nsect != 1)
+			goto invalid_fld;
+		qc->sect_size = scmd->request_bufflen;
+	}
+
 	/*
 	 * Filter SET_FEATURES - XFER MODE command -- otherwise,
 	 * SET_FEATURES - XFER MODE must be preceded/succeeded
@@ -2661,7 +2674,7 @@
 	 * TODO: find out if we need to do more here to
 	 *       cover scatter/gather case.
 	 */
-	qc->nsect = scmd->request_bufflen / ATA_SECT_SIZE;
+	qc->nsect = scmd->request_bufflen / qc->sect_size;
 
 	/* request result TF */
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
diff -u --recursive --new-file --exclude='.*' --exclude='*.[osa]' --exclude='*.ko' --exclude='*.mod.c' linux-2.6.20/include/linux/ata.h new/include/linux/ata.h
--- linux-2.6.20/include/linux/ata.h	2007-02-04 13:44:54.000000000 -0500
+++ new/include/linux/ata.h	2007-02-12 19:34:30.000000000 -0500
@@ -160,6 +160,12 @@
 	/* READ_LOG_EXT pages */
 	ATA_LOG_SATA_NCQ	= 0x10,
 
+	/* READ/WRITE LONG (obsolete) */
+	ATA_CMD_READ_LONG	= 0x22,
+	ATA_CMD_READ_LONG_ONCE	= 0x23,
+	ATA_CMD_WRITE_LONG	= 0x32,
+	ATA_CMD_WRITE_LONG_ONCE	= 0x33,
+
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
 	XFER_UDMA_7		= 0x47,
diff -u --recursive --new-file --exclude='.*' --exclude='*.[osa]' --exclude='*.ko' --exclude='*.mod.c' linux-2.6.20/include/linux/libata.h new/include/linux/libata.h
--- linux-2.6.20/include/linux/libata.h	2007-02-04 13:44:54.000000000 -0500
+++ new/include/linux/libata.h	2007-02-12 19:32:57.000000000 -0500
@@ -430,6 +430,7 @@
 	int			dma_dir;
 
 	unsigned int		pad_len;
+	unsigned int		sect_size;
 
 	unsigned int		nsect;
 	unsigned int		cursect;
@@ -1155,6 +1156,7 @@
 	qc->n_elem = 0;
 	qc->err_mask = 0;
 	qc->pad_len = 0;
+	qc->sect_size = 512;
 
 	ata_tf_init(qc->dev, &qc->tf);
 
