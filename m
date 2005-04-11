From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/4] libata-dev-2.6: pdc2027x PLL input clock detection fix
Date: Mon, 11 Apr 2005 18:28:59 +0800
Message-ID: <425A516B.8090000@tw.ibm.com>
References: <425A49F6.3040904@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020402060507010002080608"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:21987 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261764AbVDKKaD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Apr 2005 06:30:03 -0400
In-Reply-To: <425A49F6.3040904@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020402060507010002080608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Desc:
     pdc2027x: fix the PLL input clock detection problem:
Sometimes the pdc2027x driver reads incorrect value from the counter and initialize the hardware with incorrect clock rate.

Root Cause:

- The PLL input clock counter on the pdc2027x is a 30-bit deceasing counter.
    The driver reads the decreasing counter byte by byte and assemsble back the
    whole 30-bit counter when detecting the PLL input clock rate on the fly.

- The driver reads the counter from LSB then MSB, byte by byte.
    For example, for 7D030093, the driver read  93, 00, 03 and 7D,
    piece by piece. (This is pdc2027x hardware limitation.)

- The counter is running when the driver reads it.
    Ex. When 7D030093 decreasing to 7D027FFF, sometimes the driver will read 7D020093.
    That is, when the driver read LSB, LSB 0093 is quite close to zero. Later when the
    driver read MSB, MSB is already changed from 7D03 to 7D02. => The driver
    assembles the wrong bytes and gets 7D020093.

Changes:
- Verify whether the driver is reading while the MSB bits of the counter is changing.
    If yes, reread the counter. (Incorrect LSB bits only affect the result by less than 5% under 100ms
    delay time and can be ignored.)

- Change the delay time from 1ms to 100ms. This can make the detected clock rate more accurate.
The extra time spent on rereading the counter is less than 1% compared to 100ms.

Attached please find the patch 4/4 against the libata-dev-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------020402060507010002080608
Content-Type: text/plain;
 name="pdc_060_2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc_060_2.diff"

--- libata-dev-2.6-reorg/drivers/scsi/pata_pdc2027x.c	2005-04-11 15:05:28.000000000 +0800
+++ libata-dev-2.6-pll-fix/drivers/scsi/pata_pdc2027x.c	2005-04-11 15:05:42.000000000 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.59"
+#define DRV_VERSION	"0.60"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -463,7 +463,10 @@
 {
 	u8 ctr0, ctr1, ctr2, ctr3;
 	unsigned long counter;
+	u8 ctr0v, ctr1v, ctr2v, ctr3v;
+	int retry = 1;
 
+retry:
 	outb(0x20, probe_ent->port[0].bmdma_addr + 0x01);
 	ctr0 = inb(probe_ent->port[0].bmdma_addr + 0x03);
 	outb(0x21, probe_ent->port[0].bmdma_addr + 0x01);
@@ -473,10 +476,32 @@
 	outb(0x21, probe_ent->port[1].bmdma_addr + 0x01);
 	ctr3 = inb(probe_ent->port[1].bmdma_addr + 0x03);
 
+	/* Read the counter values again for verification */
+	outb(0x20,  probe_ent->port[0].bmdma_addr + 0x01);
+	ctr0v = inb(probe_ent->port[0].bmdma_addr + 0x03);
+	outb(0x21,  probe_ent->port[0].bmdma_addr + 0x01);
+	ctr1v = inb(probe_ent->port[0].bmdma_addr + 0x03);
+	outb(0x20,  probe_ent->port[1].bmdma_addr + 0x01);
+	ctr2v = inb(probe_ent->port[1].bmdma_addr + 0x03);
+	outb(0x21,  probe_ent->port[1].bmdma_addr + 0x01);
+	ctr3v = inb(probe_ent->port[1].bmdma_addr + 0x03);
+
 	counter = (ctr3 << 23) | (ctr2 << 15) | (ctr1 << 8) | ctr0;
 
 	PDPRINTK("ctr0[%X] ctr1[%X] ctr2[%X] ctr3[%X]\n", 
 		 ctr0, ctr1, ctr2, ctr3);
+	PDPRINTK("ctr0[%X] ctr1[%X] ctr2[%X] ctr3[%X]\n", 
+		 ctr0v, ctr1v, ctr2v, ctr3v);
+
+	/*
+	 * The 30-bit decreasing counter are read by 4 pieces.
+	 * Incorrect value may be read when ctr2 and ctr3 are changing.
+	 */
+	if (retry && !(ctr3 == ctr3v && ctr2 == ctr2v && ctr1 >= ctr1v)) {
+		retry--;
+		PDPRINTK("rereading counter\n");
+		goto retry;
+	}
 
 	return counter;
 }
@@ -599,8 +624,8 @@
 	PDPRINTK("scr1[%X]\n", scr1);
 	outb(scr1 | 0x40, probe_ent->port[0].bmdma_addr + 0x03);
 
-	/* Let the counter run for 1000 us. */
-	udelay(1000);
+	/* Let the counter run for 100 ms. */
+	mdelay(100);
 
 	/* Read the counter values again */
 	end_count = pdc_read_counter(probe_ent);
@@ -612,7 +637,7 @@
 	outb(scr1 & 0xBF, probe_ent->port[0].bmdma_addr + 0x03);
 
 	/* calculate the input clock in Hz */
-	pll_clock = (long) ((start_count - end_count) * 1000);
+	pll_clock = (long) ((start_count - end_count) * 10);
 
 	PDPRINTK("start[%lu] end[%lu] \n", start_count, end_count);
 	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);

--------------020402060507010002080608--


