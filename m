From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.4.x libata update (updated :))
Date: Thu, 19 Aug 2004 12:52:53 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040819165253.GA28539@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:23510 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266687AbUHSQwz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Aug 2004 12:52:55 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, tonyb@cybernetics.com


(updated, and with correct 'bk pull' URL)

Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-upstream-2.4

This will update the following files:

 Documentation/Configure.help |   10 +
 drivers/scsi/ata_piix.c      |    5 
 drivers/scsi/libata-core.c   |  138 +++++++++++----
 drivers/scsi/libata-scsi.c   |  377 ++++++++++++++++++++++++++++++++++++++-----
 drivers/scsi/libata.h        |    4 
 drivers/scsi/sata_nv.c       |  315 ++++++++++++++++++++++++++++-------
 drivers/scsi/sata_promise.c  |    1 
 drivers/scsi/sata_sil.c      |    3 
 drivers/scsi/sata_sis.c      |    1 
 drivers/scsi/sata_svw.c      |    1 
 drivers/scsi/sata_sx4.c      |    1 
 drivers/scsi/sata_via.c      |    1 
 drivers/scsi/sata_vsc.c      |    1 
 include/linux/ata.h          |    9 -
 include/linux/libata.h       |    8 
 include/scsi/scsi.h          |    1 
 16 files changed, 732 insertions(+), 144 deletions(-)

through these ChangeSets:

<achew@nvidia.com> (04/08/18 1.1485)
   [libata sata_nv] fix leak on error
   
   Spotted by Francois Romieu.

<alan@redhat.com> (04/08/18 1.1484)
   [libata] improve translation of ATA errors to SCSI sense codes

<jgarzik@pobox.com> (04/08/18 1.1483)
   [ata] remove 'packed' attributed from struct ata_prd
   
   It's not needed, and it generates very poor code on some platforms.
   
   Noticed by Bart and David Miller.

<bunk@fs.tum.de> (04/08/18 1.1482)
   [PATCH] 2.4.28-pre1: add two SATA Configure.help entries
   
   The trivial patch below adds the missing Configure.help entries for two
   new options.
   
   
   Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

<dougg@torque.net> (04/08/18 1.1481)
   [libata] fix INQUIRY handling
   
   
   Changes:
      - send vendor, product and rev strings back for 36 byte
        INQUIRYs
      - set the additional length field to indicate 96 byte
        response is available 

<jgarzik@pobox.com> (04/08/18 1.1480)
   [libata] fix error recovery reference count and in-recovery flag
   
   This bug could potentially lead to soft hangs (processes stuck in D
   state) if an error occurred.
   
   Yet another undocumented nuance of the ->eh_strategy_handler.
   
   Thanks to excellent detective work by Brad Campbell tracking this down.
   Thanks also to Doug Ledford.

<akpm@osdl.org> (04/08/16 1.1479)
   [PATCH] libata build fix
   
   drivers/scsi/libata-core.c: In function `swap_buf_le16':
   drivers/scsi/libata-core.c:2073: `words' undeclared (first use in this function)
   drivers/scsi/libata-core.c:2073: (Each undeclared identifier is reported only once
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>

<jgarzik@pobox.com> (04/08/14 1.1478)
   [libata] add ioctl infrastructure
   
   Mainly adding the infrastructure for various ATA ioctls.  Currently
   only supports two ATA-specific ioctls:
   HDIO_GET_32BIT and HDIO_SET_32BIT (hdparm -c)

<jgarzik@pobox.com> (04/08/14 1.1477)
   [libata] ATAPI PIO data xfer
   
   Abstract out PIO data xfer to xfer-a-sector and other-stuff pieces,
   then add new ATAPI code that uses the common xfer-a-sector code.

<jgarzik@pobox.com> (04/08/14 1.1476)
   [libata] fix PIO data xfer on big endian
   
   We were reading the data swapped, which was correct for the
   data page read from IDENTIFY DEVICE and incorrect for all other
   situations.
   
   Noticed by Ben Herrenschmidt.

<jgarzik@pobox.com> (04/08/14 1.1475)
   [libata] support commands SYNCHRONIZE CACHE, VERIFY, VERIFY(16)

<achew@nvidia.com> (04/08/13 1.1474)
   [libata sata_nv] support for hardware, bug fixes

<jgarzik@pobox.com> (04/08/13 1.1473)
   [libata] (cosmetic) sync with 2.6.x

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	2004-08-19 12:50:51 -04:00
+++ b/Documentation/Configure.help	2004-08-19 12:50:51 -04:00
@@ -9299,6 +9299,16 @@
 
   If unsure, say N.
 
+CONFIG_SCSI_ATA_PIIX
+  This option enables support for ICH5 Serial ATA.
+
+  If unsure, say N.
+
+CONFIG_SCSI_SATA_NV
+  This option enables support for NVIDIA Serial ATA.
+
+  If unsure, say N.
+
 CONFIG_SCSI_SATA_PROMISE
   This option enables support for Promise Serial ATA TX2/TX4.
 
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-08-19 12:50:51 -04:00
@@ -2,6 +2,10 @@
 
     ata_piix.c - Intel PATA/SATA controllers
 
+    Maintained by:  Jeff Garzik <jgarzik@pobox.com>
+    		    Please ALWAYS copy linux-ide@vger.kernel.org
+		    on emails.
+
 
 	Copyright 2003-2004 Red Hat Inc
 	Copyright 2003-2004 Jeff Garzik
@@ -102,6 +106,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
+	.ioctl                  = ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/libata-core.c	2004-08-19 12:50:51 -04:00
@@ -42,6 +42,7 @@
 #include <linux/libata.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
+#include <asm/byteorder.h>
 
 #include "libata.h"
 
@@ -1054,6 +1055,8 @@
 		goto err_out;
 	}
 
+	swap_buf_le16(dev->id, ATA_ID_WORDS);
+
 	/* print device capabilities */
 	printk(KERN_DEBUG "ata%u: dev %u cfg "
 	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
@@ -2082,6 +2085,16 @@
 	ata_qc_complete(qc, drv_stat);
 }
 
+void swap_buf_le16(u16 *buf, unsigned int buf_words)
+{
+#ifdef __BIG_ENDIAN
+	unsigned int i;
+
+	for (i = 0; i < buf_words; i++)
+		buf[i] = le16_to_cpu(buf[i]);
+#endif /* __BIG_ENDIAN */
+}
+
 static void ata_mmio_data_xfer(struct ata_port *ap, unsigned char *buf,
 			       unsigned int buflen, int write_data)
 {
@@ -2092,22 +2105,22 @@
 
 	if (write_data) {
 		for (i = 0; i < words; i++)
-			writew(buf16[i], mmio);
+			writew(le16_to_cpu(buf16[i]), mmio);
 	} else {
 		for (i = 0; i < words; i++)
-			buf16[i] = readw(mmio);
+			buf16[i] = cpu_to_le16(readw(mmio));
 	}
 }
 
 static void ata_pio_data_xfer(struct ata_port *ap, unsigned char *buf,
 			      unsigned int buflen, int write_data)
 {
-	unsigned int dwords = buflen >> 2;
+	unsigned int dwords = buflen >> 1;
 
 	if (write_data)
-		outsl(ap->ioaddr.data_addr, buf, dwords);
+		outsw(ap->ioaddr.data_addr, buf, dwords);
 	else
-		insl(ap->ioaddr.data_addr, buf, dwords);
+		insw(ap->ioaddr.data_addr, buf, dwords);
 }
 
 static void ata_data_xfer(struct ata_port *ap, unsigned char *buf,
@@ -2119,6 +2132,81 @@
 		ata_pio_data_xfer(ap, buf, buflen, do_write);
 }
 
+static void ata_pio_sector(struct ata_queued_cmd *qc)
+{
+	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
+	struct scatterlist *sg = qc->sg;
+	struct ata_port *ap = qc->ap;
+	struct page *page;
+	unsigned char *buf;
+
+	if (qc->cursect == (qc->nsect - 1))
+		ap->pio_task_state = PIO_ST_LAST;
+
+	page = sg[qc->cursg].page;
+	buf = kmap(page) +
+	      sg[qc->cursg].offset + (qc->cursg_ofs * ATA_SECT_SIZE);
+
+	qc->cursect++;
+	qc->cursg_ofs++;
+
+	if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
+		qc->cursg++;
+		qc->cursg_ofs = 0;
+	}
+
+	DPRINTK("data %s, drv_stat 0x%X\n",
+		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read",
+		status);
+
+	/* do the actual data transfer */
+	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
+	ata_data_xfer(ap, buf, ATA_SECT_SIZE, do_write);
+
+	kunmap(page);
+}
+
+static void atapi_pio_sector(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
+	unsigned int i, ireason, bc_lo, bc_hi, bytes;
+	int i_write, do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? 1 : 0;
+
+	ap->ops->tf_read(ap, &qc->tf);
+	ireason = qc->tf.nsect;
+	bc_lo = qc->tf.lbam;
+	bc_hi = qc->tf.lbah;
+	bytes = (bc_hi << 8) | bc_lo;
+
+	/* shall be cleared to zero, indicating xfer of data */
+	if (ireason & (1 << 0))
+		goto err_out;
+	
+	/* make sure transfer direction matches expected */
+	i_write = ((ireason & (1 << 1)) == 0) ? 1 : 0;
+	if (do_write != i_write)
+		goto err_out;
+
+	/* make sure byte count is multiple of sector size; not
+	* required by standard (warning! warning!), but IDE driver
+	* does this to simplify things a bit.  We are lazy, and
+	* follow suit.
+	*/
+	if (bytes & (ATA_SECT_SIZE - 1))
+		goto err_out;
+
+	for (i = 0; i < (bytes >> 9); i++)
+		ata_pio_sector(qc);
+	
+	return;
+
+err_out:
+	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
+	      ap->id, dev->devno);
+	ap->pio_task_state = PIO_ST_ERR;
+}
+
 /**
  *	ata_pio_sector -
  *	@ap:
@@ -2126,14 +2214,10 @@
  *	LOCKING:
  */
 
-static void ata_pio_sector(struct ata_port *ap)
+static void ata_pio_block(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
-	struct scatterlist *sg;
-	struct page *page;
-	unsigned char *buf;
 	u8 status;
-	int do_write;
 
 	/*
 	 * This is purely hueristic.  This is a fast path.
@@ -2163,32 +2247,10 @@
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
-	sg = qc->sg;
-
-	if (qc->cursect == (qc->nsect - 1))
-		ap->pio_task_state = PIO_ST_LAST;
-
-	page = sg[qc->cursg].page;
-	buf = kmap(page) +
-	      sg[qc->cursg].offset + (qc->cursg_ofs * ATA_SECT_SIZE);
-
-	qc->cursect++;
-	qc->cursg_ofs++;
-
-	if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
-		qc->cursg++;
-		qc->cursg_ofs = 0;
-	}
-
-	DPRINTK("data %s, drv_stat 0x%X\n",
-		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read",
-		status);
-
-	/* do the actual data transfer */
-	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
-	ata_data_xfer(ap, buf, ATA_SECT_SIZE, do_write);
-
-	kunmap(page);
+	if (is_atapi_taskfile(&qc->tf))
+		atapi_pio_sector(qc);
+	else
+		ata_pio_sector(qc);
 }
 
 static void ata_pio_error(struct ata_port *ap)
@@ -2217,7 +2279,7 @@
 
 	switch (ap->pio_task_state) {
 	case PIO_ST:
-		ata_pio_sector(ap);
+		ata_pio_block(ap);
 		break;
 
 	case PIO_ST_LAST:
@@ -2556,6 +2618,7 @@
 		break;
 
 	default:
+		WARN_ON(1);
 		return -1;
 	}
 
@@ -3528,6 +3591,7 @@
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
+EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_detect);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-08-19 12:50:51 -04:00
@@ -31,6 +31,7 @@
 #include <scsi/scsi_host.h>
 #include "sd.h"
 #include <linux/libata.h>
+#include <asm/uaccess.h>
 
 #include "libata.h"
 
@@ -38,6 +39,8 @@
 static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
 			      struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
+static struct ata_device *
+ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev);
 
 
 /**
@@ -59,15 +62,52 @@
  */
 int ata_std_bios_param(Disk * disk,	/* SCSI disk */
 		       kdev_t dev,	/* Device major, minor */
-		  int *ip /* Heads, sectors, cylinders in that order */ )
+		  int *geom /* Heads, sectors, cylinders in that order */ )
 {
-	ip[0] = 255;
-	ip[1] = 63;
-	ip[2] = disk->capacity / (ip[0] * ip[1]);
+	geom[0] = 255;
+	geom[1] = 63;
+	geom[2] = disk->capacity / (geom[0] * geom[1]);
 
 	return 0;
 }
 
+int ata_scsi_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg)
+{
+	struct ata_port *ap;
+	struct ata_device *dev;
+	int val = -EINVAL, rc = -EINVAL;
+
+	ap = (struct ata_port *) &scsidev->host->hostdata[0];
+	if (!ap)
+		goto out;
+
+	dev = ata_scsi_find_dev(ap, scsidev);
+	if (!dev) {
+		rc = -ENODEV;
+		goto out;
+	}
+
+	switch (cmd) {
+	case ATA_IOC_GET_IO32:
+		val = 0;
+		if (copy_to_user(arg, &val, 1))
+			return -EFAULT;
+		return 0;
+
+	case ATA_IOC_SET_IO32:
+		val = (long) arg;
+		if (val != 0)
+			return -EINVAL;
+		return 0;
+
+	default:
+		rc = -EOPNOTSUPP;
+		break;
+	}
+
+out:
+	return rc;
+}
 
 /**
  *	ata_scsi_qc_new - acquire new ata_queued_cmd reference
@@ -121,34 +161,158 @@
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@qc: Command that we are erroring out
  *
- *	Converts an ATA error into a SCSI error.
- *
- *	Right now, this routine is laughably primitive.  We
- *	don't even examine what ATA told us, we just look at
- *	the command data direction, and return a fatal SCSI
- *	sense error based on that.
+ *	Converts an ATA error into a SCSI error. While we are at it
+ *	we decode and dump the ATA error for the user so that they
+ *	have some idea what really happened at the non make-believe
+ *	layer.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_to_sense_error(struct ata_queued_cmd *qc)
+void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	u8 err = 0;
+	unsigned char *sb = cmd->sense_buffer;
+	/* Based on the 3ware driver translation table */
+	static unsigned char sense_table[][4] = {
+		/* BBD|ECC|ID|MAR */
+		{0xd1, 		ABORTED_COMMAND, 0x00, 0x00}, 	// Device busy                  Aborted command
+		/* BBD|ECC|ID */
+		{0xd0,  	ABORTED_COMMAND, 0x00, 0x00}, 	// Device busy                  Aborted command
+		/* ECC|MC|MARK */
+		{0x61, 		HARDWARE_ERROR, 0x00, 0x00}, 	// Device fault                 Hardware error
+		/* ICRC|ABRT */		/* NB: ICRC & !ABRT is BBD */
+		{0x84, 		ABORTED_COMMAND, 0x47, 0x00}, 	// Data CRC error               SCSI parity error
+		/* MC|ID|ABRT|TRK0|MARK */
+		{0x37, 		NOT_READY, 0x04, 0x00}, 	// Unit offline                 Not ready
+		/* MCR|MARK */
+		{0x09, 		NOT_READY, 0x04, 0x00}, 	// Unrecovered disk error       Not ready
+		/*  Bad address mark */
+		{0x01, 		MEDIUM_ERROR, 0x13, 0x00}, 	// Address mark not found       Address mark not found for data field
+		/* TRK0 */
+		{0x02, 		HARDWARE_ERROR, 0x00, 0x00}, 	// Track 0 not found		  Hardware error
+		/* Abort & !ICRC */
+		{0x04, 		ABORTED_COMMAND, 0x00, 0x00}, 	// Aborted command              Aborted command
+		/* Media change request */
+		{0x08, 		NOT_READY, 0x04, 0x00}, 	// Media change request	  FIXME: faking offline
+		/* SRV */
+		{0x10, 		ABORTED_COMMAND, 0x14, 0x00}, 	// ID not found                 Recorded entity not found
+		/* Media change */
+		{0x08,  	NOT_READY, 0x04, 0x00}, 	// Media change		  FIXME: faking offline
+		/* ECC */
+		{0x40, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Uncorrectable ECC error      Unrecovered read error
+		/* BBD - block marked bad */
+		{0x80, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Block marked bad		  Medium error, unrecovered read error
+		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark 
+	};
+	static unsigned char stat_table[][4] = {
+		/* Must be first because BUSY means no other bits valid */
+		{0x80, 		ABORTED_COMMAND, 0x47, 0x00},	// Busy, fake parity for now
+		{0x20, 		HARDWARE_ERROR,  0x00, 0x00}, 	// Device fault
+		{0x08, 		ABORTED_COMMAND, 0x47, 0x00},	// Timed out in xfer, fake parity for now
+		{0x04, 		RECOVERED_ERROR, 0x11, 0x00},	// Recovered ECC error	  Medium error, recovered
+		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark 
+	};
+	int i = 0;
 
 	cmd->result = SAM_STAT_CHECK_CONDITION;
-
-	cmd->sense_buffer[0] = 0x70;
-	cmd->sense_buffer[2] = MEDIUM_ERROR;
-	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
-
+	
+	/*
+	 *	Is this an error we can process/parse
+	 */
+	 
+	if(drv_stat & ATA_ERR)
+		/* Read the err bits */
+		err = ata_chk_err(qc->ap);
+
+	/* Display the ATA level error info */
+	
+	printk(KERN_WARNING "ata%u: status=0x%02x { ", qc->ap->id, drv_stat);
+	if(drv_stat & 0x80)
+	{
+		printk("Busy ");
+		err = 0;	/* Data is not valid in this case */
+	}
+	else {
+		if(drv_stat & 0x40)	printk("DriveReady ");
+		if(drv_stat & 0x20)	printk("DeviceFault ");
+		if(drv_stat & 0x10)	printk("SeekComplete ");
+		if(drv_stat & 0x08)	printk("DataRequest ");
+		if(drv_stat & 0x04)	printk("CorrectedError ");
+		if(drv_stat & 0x02)	printk("Index ");
+		if(drv_stat & 0x01)	printk("Error ");
+	}
+	printk("}\n");
+	
+	if(err)
+	{
+		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
+		if(err & 0x04)		printk("DriveStatusError ");
+		if(err & 0x80)
+		{
+			if(err & 0x04)
+				printk("BadCRC ");
+			else
+				printk("Sector ");
+		}
+		if(err & 0x40)		printk("UncorrectableError ");
+		if(err & 0x10)		printk("SectorIdNotFound ");
+		if(err & 0x02)		printk("TrackZeroNotFound ");
+		if(err & 0x01)		printk("AddrMarkNotFound ");
+		printk("}\n");
+		
+		/* Should we dump sector info here too ?? */
+	}
+		
+	
+	/* Look for err */
+	while(sense_table[i][0] != 0xFF)
+	{
+		/* Look for best matches first */
+		if((sense_table[i][0] & err) == sense_table[i][0])
+		{
+			sb[0] = 0x70;
+			sb[2] = sense_table[i][1];
+			sb[7] = 0x0a;
+			sb[12] = sense_table[i][2];
+			sb[13] = sense_table[i][3];
+			return;
+		}
+		i++;
+	}
+	/* No immediate match */
+	if(err)
+		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
+	
+	/* Fall back to interpreting status bits */
+	while(stat_table[i][0] != 0xFF)
+	{
+		if(stat_table[i][0] & drv_stat)
+		{
+			sb[0] = 0x70;
+			sb[2] = stat_table[i][1];
+			sb[7] = 0x0a;
+			sb[12] = stat_table[i][2];
+			sb[13] = stat_table[i][3];
+			return;
+		}
+		i++;
+	}
+	/* No error ?? */
+	printk(KERN_ERR "ata%u: called with no error (%02X)!\n", qc->ap->id, drv_stat);
 	/* additional-sense-code[-qualifier] */
+	
+	sb[0] = 0x70;
+	sb[2] = MEDIUM_ERROR;
+	sb[7] = 0x0A;
 	if (cmd->sc_data_direction == SCSI_DATA_READ) {
-		cmd->sense_buffer[12] = 0x11; /* "unrecovered read error" */
-		cmd->sense_buffer[13] = 0x04;
+		sb[12] = 0x11; /* "unrecovered read error" */
+		sb[13] = 0x04;
 	} else {
-		cmd->sense_buffer[12] = 0x0C; /* "write error -             */
-		cmd->sense_buffer[13] = 0x02; /*  auto-reallocation failed" */
+		sb[12] = 0x0C; /* "write error -             */
+		sb[13] = 0x02; /*  auto-reallocation failed" */
 	}
 }
 
@@ -174,11 +338,137 @@
 	ap = (struct ata_port *) &host->hostdata[0];
 	ap->ops->eng_timeout(ap);
 
+	host->in_recovery = 0;
+
+	/* TODO: this is per-command; when queueing is supported
+	 * this code will either change or move to a more
+	 * appropriate place
+	 */
+	host->host_failed--;
+
 	DPRINTK("EXIT\n");
 	return 0;
 }
 
 /**
+ *	ata_scsi_flush_xlat - Translate SCSI SYNCHRONIZE CACHE command
+ *	@qc: Storage for translated ATA taskfile
+ *	@scsicmd: SCSI command to translate (ignored)
+ *
+ *	Sets up an ATA taskfile to issue FLUSH CACHE or
+ *	FLUSH CACHE EXT.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on error.
+ */
+
+static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
+{
+	struct ata_taskfile *tf = &qc->tf;
+
+	tf->flags |= ATA_TFLAG_DEVICE;
+	tf->protocol = ATA_PROT_NODATA;
+
+	if ((tf->flags & ATA_TFLAG_LBA48) &&
+	    (ata_id_has_flush_ext(qc->dev)))
+		tf->command = ATA_CMD_FLUSH_EXT;
+	else
+		tf->command = ATA_CMD_FLUSH;
+
+	return 0;
+}
+
+/**
+ *	ata_scsi_verify_xlat - Translate SCSI VERIFY command into an ATA one
+ *	@qc: Storage for translated ATA taskfile
+ *	@scsicmd: SCSI command to translate
+ *
+ *	Converts SCSI VERIFY command to an ATA READ VERIFY command.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on error.
+ */
+
+static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
+{
+	struct ata_taskfile *tf = &qc->tf;
+	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
+	u64 dev_sectors = qc->dev->n_sectors;
+	u64 sect = 0;
+	u32 n_sect = 0;
+
+	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf->protocol = ATA_PROT_NODATA;
+	tf->device |= ATA_LBA;
+
+	if (scsicmd[0] == VERIFY) {
+		sect |= ((u64)scsicmd[2]) << 24;
+		sect |= ((u64)scsicmd[3]) << 16;
+		sect |= ((u64)scsicmd[4]) << 8;
+		sect |= ((u64)scsicmd[5]);
+
+		n_sect |= ((u32)scsicmd[7]) << 8;
+		n_sect |= ((u32)scsicmd[8]);
+	}
+
+	else if (scsicmd[0] == VERIFY_16) {
+		sect |= ((u64)scsicmd[2]) << 56;
+		sect |= ((u64)scsicmd[3]) << 48;
+		sect |= ((u64)scsicmd[4]) << 40;
+		sect |= ((u64)scsicmd[5]) << 32;
+		sect |= ((u64)scsicmd[6]) << 24;
+		sect |= ((u64)scsicmd[7]) << 16;
+		sect |= ((u64)scsicmd[8]) << 8;
+		sect |= ((u64)scsicmd[9]);
+
+		n_sect |= ((u32)scsicmd[10]) << 24;
+		n_sect |= ((u32)scsicmd[11]) << 16;
+		n_sect |= ((u32)scsicmd[12]) << 8;
+		n_sect |= ((u32)scsicmd[13]);
+	}
+
+	else
+		return 1;
+
+	if (!n_sect)
+		return 1;
+	if (sect >= dev_sectors)
+		return 1;
+	if ((sect + n_sect) > dev_sectors)
+		return 1;
+	if (lba48) {
+		if (n_sect > (64 * 1024))
+			return 1;
+	} else {
+		if (n_sect > 256)
+			return 1;
+	}
+
+	if (lba48) {
+		tf->hob_nsect = (n_sect >> 8) & 0xff;
+
+		tf->hob_lbah = (sect >> 40) & 0xff;
+		tf->hob_lbam = (sect >> 32) & 0xff;
+		tf->hob_lbal = (sect >> 24) & 0xff;
+	} else
+		tf->device |= (sect >> 24) & 0xf;
+
+	tf->nsect = n_sect & 0xff;
+
+	tf->hob_lbah = (sect >> 16) & 0xff;
+	tf->hob_lbam = (sect >> 8) & 0xff;
+	tf->hob_lbal = sect & 0xff;
+
+	return 0;
+}
+
+/**
  *	ata_scsi_rw_xlat - Translate SCSI r/w command into an ATA one
  *	@qc: Storage for translated ATA taskfile
  *	@scsicmd: SCSI command to translate
@@ -204,10 +494,6 @@
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	tf->hob_nsect = 0;
-	tf->hob_lbal = 0;
-	tf->hob_lbam = 0;
-	tf->hob_lbah = 0;
 	tf->protocol = qc->dev->xfer_protocol;
 	tf->device |= ATA_LBA;
 
@@ -300,7 +586,7 @@
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
 	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
-		ata_to_sense_error(qc);
+		ata_to_sense_error(qc, drv_stat);
 	else
 		cmd->result = SAM_STAT_GOOD;
 
@@ -490,7 +776,7 @@
 		0,
 		0x5,	/* claim SPC-3 version compatibility */
 		2,
-		96 - 4
+		95 - 4
 	};
 
 	/* set scsi removeable (RMB) bit per ata bit */
@@ -501,7 +787,7 @@
 
 	memcpy(rbuf, hdr, sizeof(hdr));
 
-	if (buflen > 36) {
+	if (buflen > 35) {
 		memcpy(&rbuf[8], "ATA     ", 8);
 		ata_dev_id_string(dev, &rbuf[16], ATA_ID_PROD_OFS, 16);
 		ata_dev_id_string(dev, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
@@ -1018,19 +1304,19 @@
  *	Associated ATA device, or %NULL if not found.
  */
 
-static inline struct ata_device *
-ata_scsi_find_dev(struct ata_port *ap, struct scsi_cmnd *cmd)
+static struct ata_device *
+ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
 {
 	struct ata_device *dev;
 
 	/* skip commands not addressed to targets we simulate */
-	if (likely(cmd->target < ATA_MAX_DEVICES))
-		dev = &ap->device[cmd->target];
+	if (likely(scsidev->id < ATA_MAX_DEVICES))
+		dev = &ap->device[scsidev->id];
 	else
 		return NULL;
 
-	if (unlikely((cmd->channel != 0) ||
-		     (cmd->lun != 0)))
+	if (unlikely((scsidev->channel != 0) ||
+		     (scsidev->lun != 0)))
 		return NULL;
 
 	if (unlikely(!ata_dev_present(dev)))
@@ -1046,6 +1332,7 @@
 
 /**
  *	ata_get_xlat_func - check if SCSI to ATA translation is possible
+ *	@dev: ATA device
  *	@cmd: SCSI command opcode to consider
  *
  *	Look up the SCSI command given, and determine whether the
@@ -1055,7 +1342,7 @@
  *	Pointer to translation function if possible, %NULL if not.
  */
 
-static inline ata_xlat_func_t ata_get_xlat_func(u8 cmd)
+static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 {
 	switch (cmd) {
 	case READ_6:
@@ -1066,6 +1353,15 @@
 	case WRITE_10:
 	case WRITE_16:
 		return ata_scsi_rw_xlat;
+
+	case SYNCHRONIZE_CACHE:
+		if (ata_try_flush_cache(dev))
+			return ata_scsi_flush_xlat;
+		break;
+
+	case VERIFY:
+	case VERIFY_16:
+		return ata_scsi_verify_xlat;
 	}
 
 	return NULL;
@@ -1083,11 +1379,12 @@
 				     struct scsi_cmnd *cmd)
 {
 #ifdef ATA_DEBUG
+	struct scsi_device *scsidev = cmd->device;
 	u8 *scsicmd = cmd->cmnd;
 
 	DPRINTK("CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
 		ap->id,
-		cmd->channel, cmd->target, cmd->lun,
+		scsidev->channel, scsidev->id, scsidev->lun,
 		scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
 		scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
 		scsicmd[8]);
@@ -1117,17 +1414,18 @@
 {
 	struct ata_port *ap;
 	struct ata_device *dev;
+	struct scsi_device *scsidev = cmd->device;
 
 	/* Note: spin_lock_irqsave is held by caller... */
 	spin_unlock(&io_request_lock);
 
-	ap = (struct ata_port *) &cmd->host->hostdata[0];
+	ap = (struct ata_port *) &scsidev->host->hostdata[0];
 
 	spin_lock(&ap->host_set->lock);
 
 	ata_scsi_dump_cdb(ap, cmd);
 
-	dev = ata_scsi_find_dev(ap, cmd);
+	dev = ata_scsi_find_dev(ap, scsidev);
 	if (unlikely(!dev)) {
 		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
@@ -1135,7 +1433,8 @@
 	}
 
 	if (dev->class == ATA_DEV_ATA) {
-		ata_xlat_func_t xlat_func = ata_get_xlat_func(cmd->cmnd[0]);
+		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
+							      cmd->cmnd[0]);
 
 		if (xlat_func)
 			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
@@ -1178,7 +1477,7 @@
 
 	switch(scsicmd[0]) {
 		/* no-op's, complete with success */
-		case SYNCHRONIZE_CACHE:		/* FIXME: temporary */
+		case SYNCHRONIZE_CACHE:
 		case REZERO_UNIT:
 		case SEEK_6:
 		case SEEK_10:
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/libata.h	2004-08-19 12:50:51 -04:00
@@ -35,7 +35,6 @@
 	void			(*done)(struct scsi_cmnd *);
 };
 
-
 /* libata-core.c */
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
@@ -43,10 +42,11 @@
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
+extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 
 
 /* libata-scsi.c */
-extern void ata_to_sense_error(struct ata_queued_cmd *qc);
+extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-08-19 12:50:51 -04:00
@@ -20,6 +20,11 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  0.02
+ *     - Added support for CK804 SATA controller.
+ *
+ *  0.01
+ *     - Initial revision.
  */
 
 #include <linux/config.h>
@@ -35,7 +40,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.01"
+#define DRV_VERSION			"0.02"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -47,6 +52,7 @@
 #define NV_PORT1_SCR_REG_OFFSET		0x40
 
 #define NV_INT_STATUS			0x10
+#define NV_INT_STATUS_CK804		0x440
 #define NV_INT_STATUS_PDEV_INT		0x01
 #define NV_INT_STATUS_PDEV_PM		0x02
 #define NV_INT_STATUS_PDEV_ADDED	0x04
@@ -63,6 +69,7 @@
 					NV_INT_STATUS_SDEV_HOTPLUG)
 
 #define NV_INT_ENABLE			0x11
+#define NV_INT_ENABLE_CK804		0x441
 #define NV_INT_ENABLE_PDEV_MASK		0x01
 #define NV_INT_ENABLE_PDEV_PM		0x02
 #define NV_INT_ENABLE_PDEV_ADDED	0x04
@@ -81,30 +88,86 @@
 #define NV_INT_CONFIG			0x12
 #define NV_INT_CONFIG_METHD		0x01 // 0 = INT, 1 = SMI
 
+// For PCI config register 20
+#define NV_MCP_SATA_CFG_20		0x50
+#define NV_MCP_SATA_CFG_20_SATA_SPACE_EN	0x04
+
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void nv_host_stop (struct ata_host_set *host_set);
+static void nv_enable_hotplug(struct ata_probe_ent *probe_ent);
+static void nv_disable_hotplug(struct ata_host_set *host_set);
+static void nv_check_hotplug(struct ata_host_set *host_set);
+static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent);
+static void nv_disable_hotplug_ck804(struct ata_host_set *host_set);
+static void nv_check_hotplug_ck804(struct ata_host_set *host_set);
+
+enum nv_host_type
+{
+	NFORCE2,
+	NFORCE3,
+	CK804
+};
 
 static struct pci_device_id nv_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE2 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE3 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE3 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ 0, } /* terminate list */
 };
 
+#define NV_HOST_FLAGS_SCR_MMIO	0x00000001
+
+struct nv_host_desc
+{
+	enum nv_host_type	host_type;
+	unsigned long		host_flags;
+	void			(*enable_hotplug)(struct ata_probe_ent *probe_ent);
+	void			(*disable_hotplug)(struct ata_host_set *host_set);
+	void			(*check_hotplug)(struct ata_host_set *host_set);
+
+};
+static struct nv_host_desc nv_device_tbl[] = {
+	{
+		.host_type	= NFORCE2,
+		.host_flags	= 0x00000000,
+		.enable_hotplug	= nv_enable_hotplug,
+		.disable_hotplug= nv_disable_hotplug,
+		.check_hotplug	= nv_check_hotplug,
+	},
+	{
+		.host_type	= NFORCE3,
+		.host_flags	= 0x00000000,
+		.enable_hotplug	= nv_enable_hotplug,
+		.disable_hotplug= nv_disable_hotplug,
+		.check_hotplug	= nv_check_hotplug,
+	},
+	{	.host_type	= CK804,
+		.host_flags	= NV_HOST_FLAGS_SCR_MMIO,
+		.enable_hotplug	= nv_enable_hotplug_ck804,
+		.disable_hotplug= nv_disable_hotplug_ck804,
+		.check_hotplug	= nv_check_hotplug_ck804,
+	},
+};
+
+struct nv_host
+{
+	struct nv_host_desc	*host_desc;
+};
+
 static struct pci_driver nv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= nv_pci_tbl,
@@ -117,6 +180,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
+	.ioctl                  = ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -160,11 +224,10 @@
 irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
+	struct nv_host *host = host_set->private_data;
 	unsigned int i;
 	unsigned int handled = 0;
 	unsigned long flags;
-	u8 intr_status;
-	u8 intr_enable;
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
@@ -180,35 +243,11 @@
 				handled += ata_host_intr(ap, qc);
 		}
 
-		intr_status = inb(ap->ioaddr.scr_addr + NV_INT_STATUS);
-		intr_enable = inb(ap->ioaddr.scr_addr + NV_INT_ENABLE);
-
-		// Clear interrupt status.
-		outb(0xff, ap->ioaddr.scr_addr + NV_INT_STATUS);
-
-		if (intr_status & NV_INT_STATUS_HOTPLUG) {
-			if (intr_status & NV_INT_STATUS_PDEV_ADDED) {
-				printk(KERN_WARNING "ata%u: "
-					"Primary device added\n", ap->id);
-			}
-
-			if (intr_status & NV_INT_STATUS_PDEV_REMOVED) {
-				printk(KERN_WARNING "ata%u: "
-					"Primary device removed\n", ap->id);
-			}
-
-			if (intr_status & NV_INT_STATUS_SDEV_ADDED) {
-				printk(KERN_WARNING "ata%u: "
-					"Secondary device added\n", ap->id);
-			}
-
-			if (intr_status & NV_INT_STATUS_SDEV_REMOVED) {
-				printk(KERN_WARNING "ata%u: "
-					"Secondary device removed\n", ap->id);
-			}
-		}
 	}
 
+	if (host->host_desc->check_hotplug)
+		host->host_desc->check_hotplug(host_set);
+
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
 	return IRQ_RETVAL(handled);
@@ -216,41 +255,48 @@
 
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 
-	return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	else
+		return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
 	if (sc_reg > SCR_CONTROL)
 		return;
 
-	outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	else
+		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 static void nv_host_stop (struct ata_host_set *host_set)
 {
-	int i;
+	struct nv_host *host = host_set->private_data;
 
-	for (i=0; i<host_set->n_ports; i++) {
-		u8 intr_mask;
+	// Disable hotplug event interrupts.
+	if (host->host_desc->disable_hotplug)
+		host->host_desc->disable_hotplug(host_set);
 
-		// Disable hotplug event interrupts.
-		intr_mask = inb(host_set->ports[i]->ioaddr.scr_addr +
-				NV_INT_ENABLE);
-		intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
-		outb(intr_mask, host_set->ports[i]->ioaddr.scr_addr +
-				NV_INT_ENABLE);
-	}
+	kfree(host);
 }
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
+	struct nv_host *host;
 	struct ata_probe_ent *probe_ent = NULL;
-	int i;
 	int rc;
 
 	if (!printed_version++)
@@ -274,6 +320,14 @@
 		goto err_out_regions;
 	}
 
+	host = kmalloc(sizeof(struct nv_host), GFP_KERNEL);
+	if (!host) {
+		rc = -ENOMEM;
+		goto err_out_free_ent;
+	}
+
+	host->host_desc = &nv_device_tbl[ent->driver_data];
+
 	memset(probe_ent, 0, sizeof(*probe_ent));
 	INIT_LIST_HEAD(&probe_ent->node);
 
@@ -283,6 +337,7 @@
 				ATA_FLAG_SATA_RESET |
 				ATA_FLAG_SRST |
 				ATA_FLAG_NO_LEGACY;
+
 	probe_ent->port_ops = &nv_ops;
 	probe_ent->n_ports = NV_PORTS;
 	probe_ent->irq = pdev->irq;
@@ -298,8 +353,6 @@
 		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
 	probe_ent->port[0].bmdma_addr =
 		pci_resource_start(pdev, 4) | NV_PORT0_BMDMA_REG_OFFSET;
-	probe_ent->port[0].scr_addr =
-		pci_resource_start(pdev, 5) | NV_PORT0_SCR_REG_OFFSET;
 
 	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
 	ata_std_ports(&probe_ent->port[1]);
@@ -308,33 +361,167 @@
 		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
 	probe_ent->port[1].bmdma_addr =
 		pci_resource_start(pdev, 4) | NV_PORT1_BMDMA_REG_OFFSET;
-	probe_ent->port[1].scr_addr =
-		pci_resource_start(pdev, 5) | NV_PORT1_SCR_REG_OFFSET;
 
-	pci_set_master(pdev);
+	probe_ent->private_data = host;
 
-	// Enable hotplug event interrupts.
-	for (i=0; i<probe_ent->n_ports; i++) {
-		u8 intr_mask;
+	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
+		unsigned long base;
 
-		outb(NV_INT_STATUS_HOTPLUG, probe_ent->port[i].scr_addr +
-						NV_INT_STATUS);
-
-		intr_mask = inb(probe_ent->port[i].scr_addr + NV_INT_ENABLE);
-		intr_mask |= NV_INT_ENABLE_HOTPLUG;
-		outb(intr_mask, probe_ent->port[i].scr_addr + NV_INT_ENABLE);
+		probe_ent->mmio_base = ioremap(pci_resource_start(pdev, 5),
+				pci_resource_len(pdev, 5));
+		if (probe_ent->mmio_base == NULL)
+			goto err_out_iounmap;
+
+		base = (unsigned long)probe_ent->mmio_base;
+
+		probe_ent->port[0].scr_addr =
+			base + NV_PORT0_SCR_REG_OFFSET;
+		probe_ent->port[1].scr_addr =
+			base + NV_PORT1_SCR_REG_OFFSET;
+	} else {
+
+		probe_ent->port[0].scr_addr =
+			pci_resource_start(pdev, 5) | NV_PORT0_SCR_REG_OFFSET;
+		probe_ent->port[1].scr_addr =
+			pci_resource_start(pdev, 5) | NV_PORT1_SCR_REG_OFFSET;
 	}
 
+	pci_set_master(pdev);
+
+	// Enable hotplug event interrupts.
+	if (host->host_desc->enable_hotplug)
+		host->host_desc->enable_hotplug(probe_ent);
+
 	ata_add_to_probe_list(probe_ent);
 
 	return 0;
 
+err_out_iounmap:
+	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		iounmap(probe_ent->mmio_base);
+
+err_out_free_ent:
+	kfree(probe_ent);
+
 err_out_regions:
 	pci_release_regions(pdev);
 
 err_out:
 	pci_disable_device(pdev);
 	return rc;
+}
+
+static void nv_enable_hotplug(struct ata_probe_ent *probe_ent)
+{
+	u8 intr_mask;
+
+	outb(NV_INT_STATUS_HOTPLUG,
+		(unsigned long)probe_ent->mmio_base + NV_INT_STATUS);
+
+	intr_mask = inb((unsigned long)probe_ent->mmio_base + NV_INT_ENABLE);
+	intr_mask |= NV_INT_ENABLE_HOTPLUG;
+
+	outb(intr_mask, (unsigned long)probe_ent->mmio_base + NV_INT_ENABLE);
+}
+
+static void nv_disable_hotplug(struct ata_host_set *host_set)
+{
+	u8 intr_mask;
+
+	intr_mask = inb((unsigned long)host_set->mmio_base + NV_INT_ENABLE);
+
+	intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
+
+	outb(intr_mask, (unsigned long)host_set->mmio_base + NV_INT_ENABLE);
+}
+
+static void nv_check_hotplug(struct ata_host_set *host_set)
+{
+	u8 intr_status;
+
+	intr_status = inb((unsigned long)host_set->mmio_base + NV_INT_STATUS);
+
+	// Clear interrupt status.
+	outb(0xff, (unsigned long)host_set->mmio_base + NV_INT_STATUS);
+
+	if (intr_status & NV_INT_STATUS_HOTPLUG) {
+		if (intr_status & NV_INT_STATUS_PDEV_ADDED)
+			printk(KERN_WARNING "nv_sata: "
+				"Primary device added\n");
+
+		if (intr_status & NV_INT_STATUS_PDEV_REMOVED)
+			printk(KERN_WARNING "nv_sata: "
+				"Primary device removed\n");
+
+		if (intr_status & NV_INT_STATUS_SDEV_ADDED)
+			printk(KERN_WARNING "nv_sata: "
+				"Secondary device added\n");
+
+		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
+			printk(KERN_WARNING "nv_sata: "
+				"Secondary device removed\n");
+	}
+}
+
+static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent)
+{
+	u8 intr_mask;
+	u8 regval;
+
+	pci_read_config_byte(probe_ent->pdev, NV_MCP_SATA_CFG_20, &regval);
+	regval |= NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+	pci_write_config_byte(probe_ent->pdev, NV_MCP_SATA_CFG_20, regval);
+
+	writeb(NV_INT_STATUS_HOTPLUG, probe_ent->mmio_base + NV_INT_STATUS_CK804);
+
+	intr_mask = readb(probe_ent->mmio_base + NV_INT_ENABLE_CK804);
+	intr_mask |= NV_INT_ENABLE_HOTPLUG;
+
+	writeb(intr_mask, probe_ent->mmio_base + NV_INT_ENABLE_CK804);
+}
+
+static void nv_disable_hotplug_ck804(struct ata_host_set *host_set)
+{
+	u8 intr_mask;
+	u8 regval;
+
+	intr_mask = readb(host_set->mmio_base + NV_INT_ENABLE_CK804);
+
+	intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
+
+	writeb(intr_mask, host_set->mmio_base + NV_INT_ENABLE_CK804);
+
+	pci_read_config_byte(host_set->pdev, NV_MCP_SATA_CFG_20, &regval);
+	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+	pci_write_config_byte(host_set->pdev, NV_MCP_SATA_CFG_20, regval);
+}
+
+static void nv_check_hotplug_ck804(struct ata_host_set *host_set)
+{
+	u8 intr_status;
+
+	intr_status = readb(host_set->mmio_base + NV_INT_STATUS_CK804);
+
+	// Clear interrupt status.
+	writeb(0xff, host_set->mmio_base + NV_INT_STATUS_CK804);
+
+	if (intr_status & NV_INT_STATUS_HOTPLUG) {
+		if (intr_status & NV_INT_STATUS_PDEV_ADDED)
+			printk(KERN_WARNING "nv_sata: "
+				"Primary device added\n");
+
+		if (intr_status & NV_INT_STATUS_PDEV_REMOVED)
+			printk(KERN_WARNING "nv_sata: "
+				"Primary device removed\n");
+
+		if (intr_status & NV_INT_STATUS_SDEV_ADDED)
+			printk(KERN_WARNING "nv_sata: "
+				"Secondary device added\n");
+
+		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
+			printk(KERN_WARNING "nv_sata: "
+				"Secondary device removed\n");
+	}
 }
 
 static int __init nv_init(void)
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-08-19 12:50:51 -04:00
@@ -91,6 +91,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
+	.ioctl                  = ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-08-19 12:50:51 -04:00
@@ -6,7 +6,7 @@
  *		    on emails.
  *
  *  Copyright 2003 Red Hat, Inc.
- *  Copyright 2003 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *  Copyright 2003 Benjamin Herrenschmidt
  *
  *  The contents of this file are subject to the Open
  *  Software License version 1.1 that can be found at
@@ -108,6 +108,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
+	.ioctl                  = ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/sata_sis.c	2004-08-19 12:50:51 -04:00
@@ -78,6 +78,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
+	.ioctl                  = ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/sata_svw.c	2004-08-19 12:50:51 -04:00
@@ -207,6 +207,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
+	.ioctl                  = ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/sata_sx4.c	2004-08-19 12:50:51 -04:00
@@ -176,6 +176,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
+	.ioctl                  = ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/sata_via.c	2004-08-19 12:50:51 -04:00
@@ -83,6 +83,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
+	.ioctl                  = ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-08-19 12:50:51 -04:00
+++ b/drivers/scsi/sata_vsc.c	2004-08-19 12:50:51 -04:00
@@ -192,6 +192,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
+	.ioctl                  = ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-08-19 12:50:51 -04:00
+++ b/include/linux/ata.h	2004-08-19 12:50:51 -04:00
@@ -182,12 +182,17 @@
 	ATA_PROT_ATAPI_DMA,	/* packet command with special DMA sauce */
 };
 
+enum ata_ioctls {
+	ATA_IOC_GET_IO32	= 0x309,
+	ATA_IOC_SET_IO32	= 0x324,
+};
+
 /* core structures */
 
 struct ata_prd {
 	u32			addr;
 	u32			flags_len;
-} __attribute__((packed));
+};
 
 struct ata_taskfile {
 	unsigned long		flags;		/* ATA_TFLAG_xxx */
@@ -215,6 +220,8 @@
 #define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
 #define ata_id_rahead_enabled(dev) ((dev)->id[85] & (1 << 6))
 #define ata_id_wcache_enabled(dev) ((dev)->id[85] & (1 << 5))
+#define ata_id_has_flush(dev) ((dev)->id[83] & (1 << 12))
+#define ata_id_has_flush_ext(dev) ((dev)->id[83] & (1 << 13))
 #define ata_id_has_lba48(dev)	((dev)->id[83] & (1 << 10))
 #define ata_id_has_wcache(dev)	((dev)->id[82] & (1 << 5))
 #define ata_id_has_pm(dev)	((dev)->id[82] & (1 << 3))
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-08-19 12:50:51 -04:00
+++ b/include/linux/libata.h	2004-08-19 12:50:51 -04:00
@@ -371,6 +371,7 @@
 extern void ata_pci_remove_one (struct pci_dev *pdev);
 extern int ata_device_add(struct ata_probe_ent *ent);
 extern int ata_scsi_detect(Scsi_Host_Template *sht);
+extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern int ata_scsi_release(struct Scsi_Host *host);
@@ -609,6 +610,13 @@
 	} else
 		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	return host_stat;
+}
+
+static inline int ata_try_flush_cache(struct ata_device *dev)
+{
+	return ata_id_wcache_enabled(dev) ||
+	       ata_id_has_flush(dev) ||
+	       ata_id_has_flush_ext(dev);
 }
 
 #endif /* __LINUX_LIBATA_H__ */
diff -Nru a/include/scsi/scsi.h b/include/scsi/scsi.h
--- a/include/scsi/scsi.h	2004-08-19 12:50:51 -04:00
+++ b/include/scsi/scsi.h	2004-08-19 12:50:51 -04:00
@@ -91,6 +91,7 @@
 #define WRITE_LONG_2          0xea
 #define READ_16               0x88
 #define WRITE_16              0x8a
+#define VERIFY_16	      0x8f
 #define SERVICE_ACTION_IN     0x9e
 /* values for service action in */
 #define SAI_READ_CAPACITY_16  0x10
