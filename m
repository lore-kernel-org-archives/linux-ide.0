From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/4] libata: odd length data handling for __atapi_pio_bytes()
Date: Fri, 10 Jun 2005 15:46:46 +0800
Message-ID: <42A94566.5020009@tw.ibm.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A7ED91.4090008@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010106020600020505050906"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:51699 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262512AbVFJHrV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Jun 2005 03:47:21 -0400
In-Reply-To: <42A7ED91.4090008@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------010106020600020505050906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Resend the patch #4.

Problem:
- When odd length data is transfered, the last byte of data is lost.

Changes:
- When an odd length data transfer is seen, round it up to the next even length.
   The same as atapi_input_bytes() in the ide-iops does.
   This may overrun the odd length buffer by one byte.

- Rename 'dwords' to 'words' in ata_pio_data_xfer()


Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------010106020600020505050906
Content-Type: text/plain;
 name="04_odd_data.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04_odd_data.diff"

--- 13_atapi_pio_trailing_data_handling/drivers/scsi/libata-core.c	2005-06-09 11:05:10.000000000 +0800
+++ 14_atapi_pio_odd_handling/drivers/scsi/libata-core.c	2005-06-10 15:08:24.000000000 +0800
@@ -2491,7 +2491,7 @@
 			       unsigned int buflen, int write_data)
 {
 	unsigned int i;
-	unsigned int words = buflen >> 1;
+	unsigned int words = (buflen+1) >> 1;
 	u16 *buf16 = (u16 *) buf;
 	void __iomem *mmio = (void __iomem *)ap->ioaddr.data_addr;
 
@@ -2507,12 +2507,12 @@
 static void ata_pio_data_xfer(struct ata_port *ap, unsigned char *buf,
 			      unsigned int buflen, int write_data)
 {
-	unsigned int dwords = buflen >> 1;
+	unsigned int words = (buflen+1) >> 1;
 
 	if (write_data)
-		outsw(ap->ioaddr.data_addr, buf, dwords);
+		outsw(ap->ioaddr.data_addr, buf, words);
 	else
-		insw(ap->ioaddr.data_addr, buf, dwords);
+		insw(ap->ioaddr.data_addr, buf, words);
 }
 
 static void ata_data_xfer(struct ata_port *ap, unsigned char *buf,

--------------010106020600020505050906--


