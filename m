From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 4/4] CHS: calculate LBA28/LBA48 commands and protocol
 on the fly
Date: Tue, 04 Oct 2005 20:34:01 +0800
Message-ID: <434276B9.7080807@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060103000204040308070202"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:13538 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932396AbVJDMeS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 08:34:18 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j94CYCuP022260
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:34:12 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j94CYChH101810
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:34:12 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j94CYBs4029656
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:34:12 -0400
In-Reply-To: <43427405.80502@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------060103000204040308070202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 4/4: calculate LBA28/LBA48 commands and protocol on the fly

Changes:
    - calculate LBA28/LBA48 commands and protocol on the fly per Mark 
and Jeff's advice
    - add ATA_CMD_READ_MULTI, etc. to ata.h
    - add multi_count to ata_device (just pave the road for r/w multiple)
    - removed xfer_protocol, read_cmd and write_cmd from ata_device.
    - merge ata_prot_to_cmd() and ata_dev_set_protocol() and move it to 
libata-scsi.c


For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------060103000204040308070202
Content-Type: text/plain;
 name="chs4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chs4.diff"

--- upstream/include/linux/ata.h	2005-09-29 15:32:12.000000000 +0800
+++ chs3/include/linux/ata.h	2005-10-04 18:37:42.000000000 +0800
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
@@ -287,4 +291,14 @@ static inline int ata_ok(u8 status)
 			== ATA_DRDY);
 }
 
+static inline int lba_28_ok(u64 block, u32 n_block)
+{
+	return (block < ((u64)1 << 28)) && (n_block <= 256);
+}
+
+static inline int lba_48_ok(u64 block, u32 n_block)
+{
+	return (block < ((u64)1 << 48)) && (n_block <= 65536);
+}
+
 #endif /* __LINUX_ATA_H__ */
--- upstream/include/linux/libata.h	2005-09-29 15:32:12.000000000 +0800
+++ chs3/include/linux/libata.h	2005-10-04 17:16:56.000000000 +0800
@@ -279,10 +279,8 @@ struct ata_device {
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
--- upstream/drivers/scsi/libata-core.c	2005-09-29 15:32:03.000000000 +0800
+++ chs3/drivers/scsi/libata-core.c	2005-10-04 18:36:15.000000000 +0800
@@ -616,81 +616,6 @@ void ata_tf_from_fis(u8 *fis, struct ata
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
-
-/**
- *	ata_dev_set_protocol - set taskfile protocol and r/w commands
- *	@dev: device to examine and configure
- *
- *	Examine the device configuration, after we have
- *	read the identify-device page and configured the
- *	data transfer mode.  Set internal state related to
- *	the ATA taskfile protocol (pio, pio mult, dma, etc.)
- *	and calculate the proper read/write commands to use.
- *
- *	LOCKING:
- *	caller.
- */
-static void ata_dev_set_protocol(struct ata_device *dev)
-{
-	int pio = (dev->flags & ATA_DFLAG_PIO);
-	int lba48 = (dev->flags & ATA_DFLAG_LBA48);
-	int proto, cmd;
-
-	if (pio)
-		proto = dev->xfer_protocol = ATA_PROT_PIO;
-	else
-		proto = dev->xfer_protocol = ATA_PROT_DMA;
-
-	cmd = ata_prot_to_cmd(proto, lba48);
-	if (cmd < 0)
-		BUG();
-
-	dev->read_cmd = cmd & 0xff;
-	dev->write_cmd = (cmd >> 8) & 0xff;
-}
-
 static const char * xfer_mode_str[] = {
 	"UDMA/16",
 	"UDMA/25",
@@ -1641,7 +1566,7 @@ static void ata_host_set_dma(struct ata_
  */
 static void ata_set_mode(struct ata_port *ap)
 {
-	unsigned int i, xfer_shift;
+	unsigned int xfer_shift;
 	u8 xfer_mode;
 	int rc;
 
@@ -1670,11 +1595,6 @@ static void ata_set_mode(struct ata_port
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
 
-	for (i = 0; i < 2; i++) {
-		struct ata_device *dev = &ap->device[i];
-		ata_dev_set_protocol(dev);
-	}
-
 	return;
 
 err_out:
@@ -3241,13 +3161,6 @@ struct ata_queued_cmd *ata_qc_new_init(s
 		qc->nbytes = qc->curbytes = 0;
 
 		ata_tf_init(ap, &qc->tf, dev->devno);
-
-		if (dev->flags & ATA_DFLAG_LBA) {
-			qc->tf.flags |= ATA_TFLAG_LBA;
-
-			if (dev->flags & ATA_DFLAG_LBA48)
-				qc->tf.flags |= ATA_TFLAG_LBA48;
-		}
 	}
 
 	return qc;
--- chs2/drivers/scsi/libata-scsi.c	2005-10-04 19:01:17.000000000 +0800
+++ chs3/drivers/scsi/libata-scsi.c	2005-10-04 18:36:48.000000000 +0800
@@ -489,7 +489,7 @@ static unsigned int ata_scsi_flush_xlat(
 	tf->flags |= ATA_TFLAG_DEVICE;
 	tf->protocol = ATA_PROT_NODATA;
 
-	if ((tf->flags & ATA_TFLAG_LBA48) &&
+	if ((qc->dev->flags & ATA_DFLAG_LBA48) &&
 	    (ata_id_has_flush_ext(qc->dev->id)))
 		tf->command = ATA_CMD_FLUSH_EXT;
 	else
@@ -609,8 +609,6 @@ static unsigned int ata_scsi_verify_xlat
 {
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_device *dev = qc->dev;
-	unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
-	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
 	u64 dev_sectors = qc->dev->n_sectors;
 	u64 block;
 	u32 n_block;
@@ -631,16 +629,21 @@ static unsigned int ata_scsi_verify_xlat
 		return 1;
 	if ((block + n_block) > dev_sectors)
 		return 1;
-	if (lba48) {
-		if (n_block > (64 * 1024))
-			return 1;
-	} else {
-		if (n_block > 256)
-			return 1;
-	}
 
-	if (lba) {
-		if (lba48) {
+	if (dev->flags & ATA_DFLAG_LBA) {
+		qc->tf.flags |= ATA_TFLAG_LBA;
+
+		if (lba_28_ok(block, n_block)) {
+			/* use LBA28 */
+			tf->command = ATA_CMD_VERIFY;
+
+			tf->device |= (block >> 24) & 0xf;
+		} else if (lba_48_ok(block, n_block)) {
+			if (!(dev->flags & ATA_DFLAG_LBA48))
+				return 1;
+
+			/* use LBA48 */
+			qc->tf.flags |= ATA_TFLAG_LBA48;
 			tf->command = ATA_CMD_VERIFY_EXT;
 
 			tf->hob_nsect = (n_block >> 8) & 0xff;
@@ -648,11 +651,9 @@ static unsigned int ata_scsi_verify_xlat
 			tf->hob_lbah = (block >> 40) & 0xff;
 			tf->hob_lbam = (block >> 32) & 0xff;
 			tf->hob_lbal = (block >> 24) & 0xff;
-		} else {
-			tf->command = ATA_CMD_VERIFY;
-
-			tf->device |= (block >> 24) & 0xf;
-		}
+		} else
+			/* request too large even for LBA48 */
+			return 1;
 
 		tf->nsect = n_block & 0xff;
 
@@ -665,6 +666,9 @@ static unsigned int ata_scsi_verify_xlat
 		/* CHS */
 		u32 sect, head, cyl, track;
 
+		if (!lba_28_ok(block, n_block))
+			return 1;
+
 		/* Convert LBA to CHS */
 		track = (u32)block / dev->sectors;
 		cyl   = track / dev->heads;
@@ -692,6 +696,55 @@ static unsigned int ata_scsi_verify_xlat
 	return 0;
 }
 
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
+
+/**
+ *	ata_rw_cmd_protocol - set taskfile r/w commands and protocol
+ *	@qc: command to examine and configure
+ *
+ *	Examine the device configuration and tf->flags to calculate 
+ *	the proper read/write commands and protocol to use.
+ *
+ *	LOCKING:
+ *	caller.
+ */
+static void ata_rw_cmd_protocol(struct ata_queued_cmd *qc)
+{
+	struct ata_taskfile *tf = &qc->tf;
+	struct ata_device *dev = qc->dev;
+
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
+
+	tf->command = ata_rw_cmds[index + lba48 + write];
+}
+
 /**
  *	ata_scsi_rw_xlat - Translate SCSI r/w command into an ATA one
  *	@qc: Storage for translated ATA taskfile
@@ -716,21 +769,14 @@ static unsigned int ata_scsi_rw_xlat(str
 {
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_device *dev = qc->dev;
-	unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
-	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
 	u64 block;
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
@@ -766,26 +812,30 @@ static unsigned int ata_scsi_rw_xlat(str
 		 */
 		return 1;
 
-	if (lba) {
-		if (lba48) {
-			/* The request -may- be too large for LBA48. */
-			if ((block >> 48) || (n_block > 65536))
+	if (dev->flags & ATA_DFLAG_LBA) {
+		qc->tf.flags |= ATA_TFLAG_LBA;
+
+		if (lba_28_ok(block, n_block)) {
+			/* use LBA28 */
+			tf->device |= (block >> 24) & 0xf;
+
+		} else if (lba_48_ok(block, n_block)) {
+			if (!(dev->flags & ATA_DFLAG_LBA48))
 				return 1;
 
+			/* use LBA48 */
+			qc->tf.flags |= ATA_TFLAG_LBA48;
+
 			tf->hob_nsect = (n_block >> 8) & 0xff;
 
 			tf->hob_lbah = (block >> 40) & 0xff;
 			tf->hob_lbam = (block >> 32) & 0xff;
 			tf->hob_lbal = (block >> 24) & 0xff;
-		} else { 
-			/* LBA28 */
-
-			/* The request -may- be too large for LBA28. */
-			if ((block >> 28) || (n_block > 256))
-				return 1;
+		} else
+			/* request too large even for LBA48 */
+			return 1;
 
-			tf->device |= (block >> 24) & 0xf;
-		}
+		ata_rw_cmd_protocol(qc);
 
 		qc->nsect = n_block;
 		tf->nsect = n_block & 0xff;
@@ -800,9 +850,11 @@ static unsigned int ata_scsi_rw_xlat(str
 		u32 sect, head, cyl, track;
 
 		/* The request -may- be too large for CHS addressing. */
-		if ((block >> 28) || (n_block > 256))
+		if (!lba_28_ok(block, n_block))
 			return 1;
 
+		ata_rw_cmd_protocol(qc);
+
 		/* Convert LBA to CHS */
 		track = (u32)block / dev->sectors;
 		cyl   = track / dev->heads;

--------------060103000204040308070202--

