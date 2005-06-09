From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2/4] if condition fix for __atapi_pio_bytes()
Date: Thu, 09 Jun 2005 12:05:34 +0800
Message-ID: <42A7C00E.3070600@tw.ibm.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A40214.5080006@tw.ibm.com>	 <58cb370e050606023238eeecba@mail.gmail.com>	 <42A66A60.5060105@tw.ibm.com>	 <58cb370e0506080248378c2cf2@mail.gmail.com>	 <42A6DD5E.30408@tw.ibm.com> <58cb370e05060806334c997daa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040501010108070600070105"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:24557 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261315AbVFIEGL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Jun 2005 00:06:11 -0400
In-Reply-To: <58cb370e05060806334c997daa@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------040501010108070600070105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Bartlomiej Zolnierkiewicz wrote:

> 
> Another idea - move rounding just before ata_data_xfer() so 'count' will stay 
> rounded only for the duration of ata_data_xfer() ('count' is reset for
> every sg)
> and we won't have to worry about sg->length and 'bytes'.
> 
> Or just leave it as it is and reorder patches... :).
> 
> 

Hi Bart,

How about moving the odd length rounding up code to ata_mmio_data_xfer() and ata_pio_data_xfer()?
It seems this can make the code of patch #4 simplified.
Also we can change the rounding in the trailing data handling code
from 'words = (bytes + 1)>> 1 ' to 'words = bytes >> 1'.

Ex. If bytes is 52, and buffer length is 51,
     ata_data_xfer() will be called with 51.
     ata_data_xfer() will actually transfer 52 bytes.

     1 byte left for the trailing data handling. Since
we know ata_data_xfer() round up one more byte, so in the trailing data handling code,
we can safely round down one less byte by 'words = bytes >> 1'.


Attached please find the revised patch #3 and #4 for your review.


Albert

--------------040501010108070600070105
Content-Type: text/plain;
 name="04_odd_data.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04_odd_data.diff"

--- 13_atapi_pio_trailing_data_handling/drivers/scsi/libata-core.c	2005-06-09 11:05:10.000000000 +0800
+++ 14_atapi_pio_odd_handling/drivers/scsi/libata-core.c	2005-06-09 11:04:09.000000000 +0800
@@ -2491,7 +2491,7 @@
 			       unsigned int buflen, int write_data)
 {
 	unsigned int i;
-	unsigned int words = buflen >> 1;
+	unsigned int words = (buflen+1) >> 1;
 	u16 *buf16 = (u16 *) buf;
 	void __iomem *mmio = (void __iomem *)ap->ioaddr.data_addr;
 
@@ -2507,7 +2507,7 @@
 static void ata_pio_data_xfer(struct ata_port *ap, unsigned char *buf,
 			      unsigned int buflen, int write_data)
 {
-	unsigned int dwords = buflen >> 1;
+	unsigned int dwords = (buflen+1) >> 1;
 
 	if (write_data)
 		outsw(ap->ioaddr.data_addr, buf, dwords);

--------------040501010108070600070105
Content-Type: text/plain;
 name="03_trailing_data.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03_trailing_data.diff"

--- 12_atapi_pio_if_condition_fix/drivers/scsi/libata-core.c	2005-06-06 13:52:11.000000000 +0800
+++ 13_atapi_pio_trailing_data_handling/drivers/scsi/libata-core.c	2005-06-09 11:05:10.000000000 +0800
@@ -2575,6 +2575,23 @@
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
+	/* check whether qc->sg is full */
+	if (unlikely(qc->cursg >= qc->n_elem)) {
+		unsigned char pad_buf[2];
+		unsigned int words = bytes >> 1;
+		unsigned int i;
+
+		DPRINTK("ata%u: padding %u bytes\n", ap->id, bytes);
+
+		memset(&pad_buf, 0, sizeof(pad_buf));
+		for (i = 0; i < words; i++) {
+			ata_data_xfer(ap, pad_buf, sizeof(pad_buf), do_write);
+		}
+
+		ap->pio_task_state = PIO_ST_LAST;
+		return;
+	}
+
 	sg = &qc->sg[qc->cursg];
 
 	page = sg->page;

--------------040501010108070600070105--


