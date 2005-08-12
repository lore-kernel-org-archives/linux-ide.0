From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/2] libata ata_data_xfer() fix
Date: Fri, 12 Aug 2005 14:15:34 +0800
Message-ID: <42FC3E86.9020108@tw.ibm.com>
References: <42FC3D2F.1030803@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030406020306030801080203"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:43497 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S1751099AbVHLGQS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Aug 2005 02:16:18 -0400
In-Reply-To: <42FC3D2F.1030803@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------030406020306030801080203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

PATCH 1/2: ata_data_xfer() fix

Changes:
   - Modify ata_mmio_data_xfer() and ata_pio_data_xfer() to handle odd-lengthed buffer.
   - Add some function comments

This patch does not reuse ap->pad as alignment buffer since
using local variable seems good enough.

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------030406020306030801080203
Content-Type: text/plain;
 name="pio1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pio1.diff"

--- linux/drivers/scsi/libata-core.c	2005-08-12 10:31:52.000000000 +0800
+++ 01_align/drivers/scsi/libata-core.c	2005-08-12 11:14:45.000000000 +0800
@@ -2519,6 +2519,20 @@
 #endif /* __BIG_ENDIAN */
 }
 
+/**
+ *	ata_mmio_data_xfer - Transfer data by MMIO
+ *	@ap: port to read/write
+ *	@buf: data buffer
+ *	@buflen: buffer length
+ *	@do_write: read/write
+ *
+ *	Transfer data from/to the device data register by MMIO.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ */
+
 static void ata_mmio_data_xfer(struct ata_port *ap, unsigned char *buf,
 			       unsigned int buflen, int write_data)
 {
@@ -2527,6 +2541,7 @@
 	u16 *buf16 = (u16 *) buf;
 	void __iomem *mmio = (void __iomem *)ap->ioaddr.data_addr;
 
+	/* Transfer multiple of 2 bytes */
 	if (write_data) {
 		for (i = 0; i < words; i++)
 			writew(le16_to_cpu(buf16[i]), mmio);
@@ -2534,19 +2549,76 @@
 		for (i = 0; i < words; i++)
 			buf16[i] = cpu_to_le16(readw(mmio));
 	}
+
+	/* Transfer trailing 1 byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		u16 align_buf[1] = { 0 };
+		unsigned char *trailing_buf = buf + buflen - 1;
+
+		if (write_data) {
+			memcpy(align_buf, trailing_buf, 1);
+			writew(le16_to_cpu(align_buf[0]), mmio);
+		} else {
+			align_buf[0] = cpu_to_le16(readw(mmio));
+			memcpy(trailing_buf, align_buf, 1);
+		}
+	}
 }
 
+/**
+ *	ata_pio_data_xfer - Transfer data by PIO
+ *	@ap: port to read/write
+ *	@buf: data buffer
+ *	@buflen: buffer length
+ *	@do_write: read/write
+ *
+ *	Transfer data from/to the device data register by PIO.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ */
+
 static void ata_pio_data_xfer(struct ata_port *ap, unsigned char *buf,
 			      unsigned int buflen, int write_data)
 {
-	unsigned int dwords = buflen >> 1;
+	unsigned int words = buflen >> 1;
 
+	/* Transfer multiple of 2 bytes */
 	if (write_data)
-		outsw(ap->ioaddr.data_addr, buf, dwords);
+		outsw(ap->ioaddr.data_addr, buf, words);
 	else
-		insw(ap->ioaddr.data_addr, buf, dwords);
+		insw(ap->ioaddr.data_addr, buf, words);
+
+	/* Transfer trailing 1 byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		u16 align_buf[1] = { 0 };
+		unsigned char *trailing_buf = buf + buflen - 1;
+
+		if (write_data) {
+			memcpy(align_buf, trailing_buf, 1);
+			outw(le16_to_cpu(align_buf[0]), ap->ioaddr.data_addr);
+		} else {
+			align_buf[0] = cpu_to_le16(inw(ap->ioaddr.data_addr));
+			memcpy(trailing_buf, align_buf, 1);
+		}
+	}
 }
 
+/**
+ *	ata_data_xfer - Transfer data from/to the data register.
+ *	@ap: port to read/write
+ *	@buf: data buffer
+ *	@buflen: buffer length
+ *	@do_write: read/write
+ *
+ *	Transfer data from/to the device data register.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ */
+
 static void ata_data_xfer(struct ata_port *ap, unsigned char *buf,
 			  unsigned int buflen, int do_write)
 {
@@ -2556,6 +2628,16 @@
 		ata_pio_data_xfer(ap, buf, buflen, do_write);
 }
 
+/**
+ *	ata_pio_sector - Transfer ATA_SECT_SIZE (512 bytes) of data.
+ *	@qc: Command on going
+ *
+ *	Transfer ATA_SECT_SIZE of data from/to the ATA device.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 static void ata_pio_sector(struct ata_queued_cmd *qc)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2594,6 +2676,18 @@
 	kunmap(page);
 }
 
+/**
+ *	__atapi_pio_bytes - Transfer data from/to the ATAPI device.
+ *	@qc: Command on going
+ *	@bytes: number of bytes
+ *
+ *	Transfer Transfer data from/to the ATAPI device.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ */
+
 static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2645,6 +2739,17 @@
 	}
 }
 
+/**
+ *	atapi_pio_bytes - Transfer data from/to the ATAPI device.
+ *	@qc: Command on going
+ *
+ *	Transfer Transfer data from/to the ATAPI device.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ */
+
 static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;

--------------030406020306030801080203--


