From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/3] libata ata_data_xfer() fix
Date: Mon, 01 Aug 2005 23:00:59 +0800
Message-ID: <42EE392B.8000405@tw.ibm.com>
References: <42EE37AB.2000006@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060204050104000005020409"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:35324 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262211AbVHAPBQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Aug 2005 11:01:16 -0400
In-Reply-To: <42EE37AB.2000006@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060204050104000005020409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

PATCH 2/3: ata_data_xfer() fix

Changes:
   - Add ATA_FLAG_IO_32BIT to libata.h for hosts with 32-bit data register.
   - Modify ata_mmio_data_xfer() and ata_pio_data_xfer() to handle buffer length
     not aligned to 32-bit boundary.

This patch does not reuse ap->pad as alignment buffer since
four bytes of local variable seems good enough.

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------060204050104000005020409
Content-Type: text/plain;
 name="pio2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pio2.diff"

--- linux/include/linux/libata.h	2005-08-01 15:35:39.000000000 +0800
+++ 02_pio_odd/include/linux/libata.h	2005-07-19 18:33:01.000000000 +0800
@@ -113,6 +113,7 @@
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
+	ATA_FLAG_IO_32BIT	= (1 << 9), /* data register can do 32-bit IO */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
--- 01_pio_ifcond/drivers/scsi/libata-core.c	2005-08-01 15:52:29.000000000 +0800
+++ 02_pio_odd/drivers/scsi/libata-core.c	2005-08-01 16:14:28.000000000 +0800
@@ -2519,43 +2519,146 @@
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
-	unsigned int i;
-	unsigned int words = buflen >> 1;
-	u16 *buf16 = (u16 *) buf;
+	unsigned int words;
+	unsigned int dwords = buflen >> 2;
+	unsigned int trailing = buflen & 0x03;
 	void __iomem *mmio = (void __iomem *)ap->ioaddr.data_addr;
 
-	if (write_data) {
-		for (i = 0; i < words; i++)
-			writew(le16_to_cpu(buf16[i]), mmio);
+	/* Transfer multiple of 4 bytes */
+	if (ap->flags & ATA_FLAG_IO_32BIT) {
+		if (write_data)
+			iowrite32_rep(mmio, buf, dwords);
+		else
+			ioread32_rep(mmio, buf, dwords);
 	} else {
-		for (i = 0; i < words; i++)
-			buf16[i] = cpu_to_le16(readw(mmio));
+		words  = dwords << 1;
+
+		if (write_data)
+			iowrite16_rep(mmio, buf, words);
+		else
+			ioread16_rep(mmio, buf, words);
+	}
+
+	/* Transfer trailing 1-3 bytes */
+	if (unlikely(trailing)) {
+		u16 buf16[2] = { 0, 0 };
+		unsigned char *trailing_buf = buf + buflen - trailing;
+
+		words = (trailing + 1) >> 1;
+
+		if (write_data) {
+			memcpy(buf16, trailing_buf, trailing);
+			iowrite16_rep(mmio, buf16, words);
+		} else {
+			ioread16_rep(mmio, buf16, words);
+			memcpy(trailing_buf, buf16, trailing);
+		}
 	}
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
+	unsigned int dwords = buflen >> 2;
+	unsigned int trailing = buflen & 0x03;
 
-	if (write_data)
-		outsw(ap->ioaddr.data_addr, buf, dwords);
-	else
-		insw(ap->ioaddr.data_addr, buf, dwords);
+	/* Transfer multiple of 4 bytes */
+	if (ap->flags & ATA_FLAG_IO_32BIT) {
+		if (write_data)
+			outsl(ap->ioaddr.data_addr, buf, dwords);
+		else
+			insl(ap->ioaddr.data_addr, buf, dwords);
+
+	} else {
+		if (write_data)
+			outsw(ap->ioaddr.data_addr, buf, dwords << 1);
+		else
+			insw(ap->ioaddr.data_addr, buf, dwords << 1);
+	}
+
+	/* Transfer trailing 1-3 bytes */
+	if (unlikely(trailing)) {
+		u16 buf16[2] = { 0, 0 };
+		unsigned char *trailing_buf = buf + buflen - trailing;
+		unsigned int words = (trailing + 1) >> 1;
+
+		if (write_data) {
+			memcpy(buf16, trailing_buf, trailing);
+			outsw(ap->ioaddr.data_addr, buf16, words);
+		} else {
+			insw(ap->ioaddr.data_addr, buf16, words);
+			memcpy(trailing_buf, buf16, trailing);
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
+	/* 4 byte alignment assumed */
+	assert(~((unsigned long)buf & 0x03));
+
 	if (ap->flags & ATA_FLAG_MMIO)
 		ata_mmio_data_xfer(ap, buf, buflen, do_write);
 	else
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
@@ -2594,6 +2697,18 @@
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

--------------060204050104000005020409--


