From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 4/4] irq-pio: add read/write multiple support
Date: Mon, 03 Oct 2005 21:19:50 +0800
Message-ID: <43412FF6.5030006@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060108090503000602090003"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:39317 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932183AbVJCNUF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Oct 2005 09:20:05 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j93DIeQ7004317
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 09:18:40 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j93DK0tP049742
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 07:20:00 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j93DJx8Z022181
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 07:19:59 -0600
In-Reply-To: <43411A1A.8050901@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------060108090503000602090003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 4/4: add read/write multiple support

Changes:
    - add ATA_CMD_READ_MULTI, etc. to ata.h
    - add multi_count to ata_device and initialize it with device 
identify data
    - merge ata_prot_to_cmd() with ata_dev_set_protocol()
    - ata_pio_complete(): change the wait condition from (ATA_BUSY | 
ATA_DRQ) to ATA_BUSY
    - add ata_pio_sectors() to support r/w multiple commands
    - ata_pio_block(): add ata_altstatus(ap) to prevent reading device 
status before it is valid


For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>


--------------060108090503000602090003
Content-Type: text/plain;
 name="idpio4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio4.diff"

--- irq-pio/include/linux/ata.h	2005-09-30 10:00:30.000000000 +0800
+++ id8/include/linux/ata.h	2005-10-03 13:54:52.000000000 +0800
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
@@ -270,6 +274,14 @@ static inline int is_atapi_taskfile(stru
 	       (tf->protocol == ATA_PROT_ATAPI_DMA);
 }
 
+static inline int is_multi_taskfile(struct ata_taskfile *tf)
+{
+	return (tf->command == ATA_CMD_READ_MULTI) ||
+	       (tf->command == ATA_CMD_WRITE_MULTI) ||
+	       (tf->command == ATA_CMD_READ_MULTI_EXT) ||
+	       (tf->command == ATA_CMD_WRITE_MULTI_EXT);
+}
+
 static inline int ata_ok(u8 status)
 {
 	return ((status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ | ATA_ERR))
--- id6/include/linux/libata.h	2005-10-03 10:18:29.000000000 +0800
+++ id8/include/linux/libata.h	2005-10-03 13:56:29.000000000 +0800
@@ -285,6 +285,8 @@ struct ata_device {
 	u8			xfer_protocol;	/* taskfile xfer protocol */
 	u8			read_cmd;	/* opcode to use on read */
 	u8			write_cmd;	/* opcode to use on write */
+	unsigned int		multi_count;	/* sectors count for
+						   READ/WRITE MULTIPLE */
 };
 
 struct ata_port {
--- id7/drivers/scsi/libata-core.c	2005-10-03 12:39:03.000000000 +0800
+++ id8/drivers/scsi/libata-core.c	2005-10-03 18:33:26.000000000 +0800
@@ -616,49 +616,6 @@ void ata_tf_from_fis(u8 *fis, struct ata
 }
 
 /**
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
  *	ata_dev_set_protocol - set taskfile protocol and r/w commands
  *	@dev: device to examine and configure
  *
@@ -675,19 +632,42 @@ static void ata_dev_set_protocol(struct 
 {
 	int pio = (dev->flags & ATA_DFLAG_PIO);
 	int lba48 = (dev->flags & ATA_DFLAG_LBA48);
-	int proto, cmd;
+	int rcmd, wcmd;
 
-	if (pio)
-		proto = dev->xfer_protocol = ATA_PROT_PIO;
-	else
-		proto = dev->xfer_protocol = ATA_PROT_DMA;
+	if (pio) {
+		dev->xfer_protocol = ATA_PROT_PIO;
 
-	cmd = ata_prot_to_cmd(proto, lba48);
-	if (cmd < 0)
-		BUG();
+		if (dev->multi_count) {
+			if (lba48) {
+				rcmd = ATA_CMD_READ_MULTI_EXT;
+				wcmd = ATA_CMD_WRITE_MULTI_EXT;
+			} else {
+				rcmd = ATA_CMD_READ_MULTI;
+				wcmd = ATA_CMD_WRITE_MULTI;
+			}
+		} else {
+			if (lba48) {
+				rcmd = ATA_CMD_PIO_READ_EXT;
+				wcmd = ATA_CMD_PIO_WRITE_EXT;
+			} else {
+				rcmd = ATA_CMD_PIO_READ;
+				wcmd = ATA_CMD_PIO_WRITE;
+			}
+		}
+	} else {
+		dev->xfer_protocol = ATA_PROT_DMA;
+
+		if (lba48) {
+			rcmd = ATA_CMD_READ_EXT;
+			wcmd = ATA_CMD_WRITE_EXT;
+		} else {
+			rcmd = ATA_CMD_READ;
+			wcmd = ATA_CMD_WRITE;
+		}
+	}
 
-	dev->read_cmd = cmd & 0xff;
-	dev->write_cmd = (cmd >> 8) & 0xff;
+	dev->read_cmd = rcmd;
+	dev->write_cmd = wcmd;
 }
 
 static const char * xfer_mode_str[] = {
@@ -1269,6 +1249,12 @@ retry:
 			dev->n_sectors = ata_id_u32(dev->id, 60);
 		}
 
+		if (dev->id[59] & 0x100) {
+			dev->multi_count = dev->id[59] & 0xff;
+			DPRINTK("ata%u: dev %u multi count %u\n",
+				ap->id, device, dev->multi_count);
+		}
+
 		ap->host->max_cmd_len = 16;
 
 		/* print device info to dmesg */
@@ -2483,13 +2469,13 @@ static int ata_pio_complete (struct ata_
 	 * we enter, BSY will be cleared in a chk-status or two.  If not,
 	 * the drive is probably seeking or something.  Snooze for a couple
 	 * msecs, then chk-status again.  If still busy, fall back to
-	 * HSM_ST_POLL state.
+	 * HSM_ST_LAST_POLL state.
 	 */
-	drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
-	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+	drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
+	if (drv_stat & ATA_BUSY) {
 		msleep(2);
-		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
-		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+		drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
+		if (drv_stat & ATA_BUSY) {
 			ap->hsm_task_state = HSM_ST_LAST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
 			return 1;
@@ -2697,6 +2683,32 @@ static void ata_pio_sector(struct ata_qu
 }
 
 /**
+ *	ata_pio_sectors - Transfer one or many 512-byte sectors.
+ *	@qc: Command on going
+ *
+ *	Transfer one or many ATA_SECT_SIZE of data from/to the 
+ *	ATA device for the DRQ request.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
+static void ata_pio_sectors(struct ata_queued_cmd *qc)
+{
+	if (is_multi_taskfile(&qc->tf)) {
+		/* READ/WRITE MULTIPLE */
+		unsigned int nsect;
+
+		assert(qc->dev->multi_count);
+
+		nsect = min(qc->nsect - qc->cursect, qc->dev->multi_count);
+		while (nsect--)
+			ata_pio_sector(qc);
+	} else
+		ata_pio_sector(qc);
+}
+
+/**
  *	atapi_send_cdb - Write CDB bytes to hardware
  *	@ap: Port to which ATAPI device is attached.
  *	@qc: Taskfile currently active
@@ -2791,11 +2803,11 @@ static int ata_pio_first_block(struct at
 		 * send first data block.
 		 */
 
-		/* ata_pio_sector() might change the state to HSM_ST_LAST.
-		 * so, the state is changed here before ata_pio_sector().
+		/* ata_pio_sectors() might change the state to HSM_ST_LAST.
+		 * so, the state is changed here before ata_pio_sectors().
 		 */
 		ap->hsm_task_state = HSM_ST;
-		ata_pio_sector(qc);
+		ata_pio_sectors(qc);
 		ata_altstatus(ap); /* flush */
 	} else
 		/* send CDB */
@@ -2995,8 +3007,10 @@ static void ata_pio_block(struct ata_por
 			return;
 		}
 
-		ata_pio_sector(qc);
+		ata_pio_sectors(qc);
 	}
+
+	ata_altstatus(ap); /* flush */
 }
 
 static void ata_pio_error(struct ata_port *ap)
@@ -3932,7 +3946,7 @@ fsm_start:
 				goto fsm_start;
 			}
 
-			ata_pio_sector(qc);
+			ata_pio_sectors(qc);
 
 			if (ap->hsm_task_state == HSM_ST_LAST &&
 			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {

--------------060108090503000602090003--

