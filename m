From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/4] CHS: calculate read/write commands and protocol on the
 fly (revise #6)
Date: Wed, 12 Oct 2005 15:06:27 +0800
Message-ID: <434CB5F3.1040105@tw.ibm.com>
References: <434CAF8E.5040607@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:15083 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932396AbVJLHGd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Oct 2005 03:06:33 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j9C73Nte018393
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 03:03:23 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j9C77Ftu539422
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 01:07:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j9C76R2C012502
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 01:06:27 -0600
In-Reply-To: <434CAF8E.5040607@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Patch 2/4: calculate read/write commands and protocols on the fly

changes:
     - merge ata_prot_to_cmd() and ata_dev_set_protocol() as
       ata_rwcmd_protocol()
     - pave road for read/write multiple support
     - remove usage of pre-cached command and protocol values and call
       ata_rwcmd_protocol() instead

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

==============

--- upstream/include/linux/ata.h	2005-10-11 11:40:08.000000000 +0800
+++ ch2/include/linux/ata.h	2005-10-11 12:56:56.000000000 +0800
@@ -128,6 +128,10 @@ enum {
 	ATA_CMD_PIO_READ_EXT	= 0x24,
 	ATA_CMD_PIO_WRITE	= 0x30,
 	ATA_CMD_PIO_WRITE_EXT	= 0x34,
+	ATA_CMD_READ_MULTI	= 0xC4,
+	ATA_CMD_READ_MULTI_EXT	= 0x29,
+	ATA_CMD_WRITE_MULTI	= 0xC5,
+	ATA_CMD_WRITE_MULTI_EXT	= 0x39,
 	ATA_CMD_SET_FEATURES	= 0xEF,
 	ATA_CMD_PACKET		= 0xA0,
 	ATA_CMD_VERIFY		= 0x40,
--- upstream/include/linux/libata.h	2005-10-11 11:40:09.000000000 +0800
+++ ch2/include/linux/libata.h	2005-10-11 12:58:12.000000000 +0800
@@ -283,10 +283,8 @@ struct ata_device {
 	u8			xfer_mode;
 	unsigned int		xfer_shift;	/* ATA_SHIFT_xxx */
 
-	/* cache info about current transfer mode */
-	u8			xfer_protocol;	/* taskfile xfer protocol */
-	u8			read_cmd;	/* opcode to use on read */
-	u8			write_cmd;	/* opcode to use on write */
+	unsigned int		multi_count;	/* sectors count for
+						   READ/WRITE MULTIPLE */
 
 	/* for CHS addressing */
 	u16			cylinders;	/* Number of cylinders */
--- upstream/drivers/scsi/libata.h	2005-10-11 11:40:03.000000000 +0800
+++ ch2/drivers/scsi/libata.h	2005-10-11 12:59:09.000000000 +0800
@@ -42,6 +42,7 @@ extern int atapi_enabled;
 extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
+extern void ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern int ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
--- ch1/drivers/scsi/libata-core.c	2005-10-11 12:44:53.000000000 +0800
+++ ch2/drivers/scsi/libata-core.c	2005-10-11 13:01:05.000000000 +0800
@@ -616,79 +616,53 @@ void ata_tf_from_fis(u8 *fis, struct ata
 	tf->hob_nsect	= fis[13];
 }
 
-/**
- *	ata_prot_to_cmd - determine which read/write opcodes to use
- *	@protocol: ATA_PROT_xxx taskfile protocol
- *	@lba48: true is lba48 is present
- *
- *	Given necessary input, determine which read/write commands
- *	to use to transfer data.
- *
- *	LOCKING:
- *	None.
- */
-static int ata_prot_to_cmd(int protocol, int lba48)
-{
-	int rcmd = 0, wcmd = 0;
-
-	switch (protocol) {
-	case ATA_PROT_PIO:
-		if (lba48) {
-			rcmd = ATA_CMD_PIO_READ_EXT;
-			wcmd = ATA_CMD_PIO_WRITE_EXT;
-		} else {
-			rcmd = ATA_CMD_PIO_READ;
-			wcmd = ATA_CMD_PIO_WRITE;
-		}
-		break;
-
-	case ATA_PROT_DMA:
-		if (lba48) {
-			rcmd = ATA_CMD_READ_EXT;
-			wcmd = ATA_CMD_WRITE_EXT;
-		} else {
-			rcmd = ATA_CMD_READ;
-			wcmd = ATA_CMD_WRITE;
-		}
-		break;
-
-	default:
-		return -1;
-	}
-
-	return rcmd | (wcmd << 8);
-}
+static const u8 ata_rw_cmds[] = {
+	/* pio multi */
+	ATA_CMD_READ_MULTI,
+	ATA_CMD_WRITE_MULTI,
+	ATA_CMD_READ_MULTI_EXT,
+	ATA_CMD_WRITE_MULTI_EXT,
+	/* pio */
+	ATA_CMD_PIO_READ,
+	ATA_CMD_PIO_WRITE,
+	ATA_CMD_PIO_READ_EXT,
+	ATA_CMD_PIO_WRITE_EXT,
+	/* dma */
+	ATA_CMD_READ,
+	ATA_CMD_WRITE,
+	ATA_CMD_READ_EXT,
+	ATA_CMD_WRITE_EXT
+};
 
 /**
- *	ata_dev_set_protocol - set taskfile protocol and r/w commands
- *	@dev: device to examine and configure
+ *	ata_rwcmd_protocol - set taskfile r/w commands and protocol
+ *	@qc: command to examine and configure
  *
- *	Examine the device configuration, after we have
- *	read the identify-device page and configured the
- *	data transfer mode.  Set internal state related to
- *	the ATA taskfile protocol (pio, pio mult, dma, etc.)
- *	and calculate the proper read/write commands to use.
+ *	Examine the device configuration and tf->flags to calculate 
+ *	the proper read/write commands and protocol to use.
  *
  *	LOCKING:
  *	caller.
  */
-static void ata_dev_set_protocol(struct ata_device *dev)
+void ata_rwcmd_protocol(struct ata_queued_cmd *qc)
 {
-	int pio = (dev->flags & ATA_DFLAG_PIO);
-	int lba48 = (dev->flags & ATA_DFLAG_LBA48);
-	int proto, cmd;
-
-	if (pio)
-		proto = dev->xfer_protocol = ATA_PROT_PIO;
-	else
-		proto = dev->xfer_protocol = ATA_PROT_DMA;
+	struct ata_taskfile *tf = &qc->tf;
+	struct ata_device *dev = qc->dev;
 
-	cmd = ata_prot_to_cmd(proto, lba48);
-	if (cmd < 0)
-		BUG();
+	int index, lba48, write;
+ 
+	lba48 = (tf->flags & ATA_TFLAG_LBA48) ? 2 : 0;
+	write = (tf->flags & ATA_TFLAG_WRITE) ? 1 : 0;
+
+	if (dev->flags & ATA_DFLAG_PIO) {
+		tf->protocol = ATA_PROT_PIO;
+		index = dev->multi_count ? 0 : 4;
+	} else {
+		tf->protocol = ATA_PROT_DMA;
+		index = 8;
+	}
 
-	dev->read_cmd = cmd & 0xff;
-	dev->write_cmd = (cmd >> 8) & 0xff;
+	tf->command = ata_rw_cmds[index + lba48 + write];
 }
 
 static const char * xfer_mode_str[] = {
@@ -1641,7 +1615,7 @@ static void ata_host_set_dma(struct ata_
  */
 static void ata_set_mode(struct ata_port *ap)
 {
-	unsigned int i, xfer_shift;
+	unsigned int xfer_shift;
 	u8 xfer_mode;
 	int rc;
 
@@ -1670,11 +1644,6 @@ static void ata_set_mode(struct ata_port
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
 
-	for (i = 0; i < 2; i++) {
-		struct ata_device *dev = &ap->device[i];
-		ata_dev_set_protocol(dev);
-	}
-
 	return;
 
 err_out:
--- ch1/drivers/scsi/libata-scsi.c	2005-10-11 12:53:36.000000000 +0800
+++ ch2/drivers/scsi/libata-scsi.c	2005-10-11 13:03:10.000000000 +0800
@@ -742,15 +742,10 @@ static unsigned int ata_scsi_rw_xlat(str
 	u32 n_block;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	tf->protocol = qc->dev->xfer_protocol;
 
-	if (scsicmd[0] == READ_10 || scsicmd[0] == READ_6 ||
-	    scsicmd[0] == READ_16) {
-		tf->command = qc->dev->read_cmd;
-	} else {
-		tf->command = qc->dev->write_cmd;
+	if (scsicmd[0] == WRITE_10 || scsicmd[0] == WRITE_6 ||
+	    scsicmd[0] == WRITE_16)
 		tf->flags |= ATA_TFLAG_WRITE;
-	}
 
 	/* Calculate the SCSI LBA and transfer length. */
 	switch (scsicmd[0]) {
@@ -812,6 +807,8 @@ static unsigned int ata_scsi_rw_xlat(str
 			tf->device |= (block >> 24) & 0xf;
 		}
 
+		ata_rwcmd_protocol(qc);
+
 		qc->nsect = n_block;
 		tf->nsect = n_block & 0xff;
 
@@ -828,6 +825,8 @@ static unsigned int ata_scsi_rw_xlat(str
 		if ((block >> 28) || (n_block > 256))
 			goto out_of_range;
 
+		ata_rwcmd_protocol(qc);
+
 		/* Convert LBA to CHS */
 		track = (u32)block / dev->sectors;
 		cyl   = track / dev->heads;


