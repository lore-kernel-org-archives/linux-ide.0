From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/3] libata-dev: pdc2027x use "long" for counter data type
Date: Fri, 12 Aug 2005 15:21:08 +0800
Message-ID: <42FC4DE4.1000408@tw.ibm.com>
References: <42FC4B36.9080805@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020006090101010907060902"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:24574 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S1751150AbVHLHVq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Aug 2005 03:21:46 -0400
In-Reply-To: <42FC4B36.9080805@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------020006090101010907060902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

Patch 2/3: pdc2027x use "long" for counter data type

Description:
     The pdc2027x byte counter value is only 30-bit, "long" should be big enough.

Changes:
  - Change the counter data type from "unsigned long" to "long".

Patch tested OK on x86, power4 and power5 machines.

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------020006090101010907060902
Content-Type: text/plain;
 name="pdc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc2.diff"

--- 01_pdc_mmio/drivers/scsi/pata_pdc2027x.c	2005-08-11 16:43:25.000000000 +0800
+++ 02_pdc_long/drivers/scsi/pata_pdc2027x.c	2005-08-12 11:39:32.000000000 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.70"
+#define DRV_VERSION	"0.71"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -481,9 +481,9 @@
  * @probe_ent: for the port address
  */
 
-static unsigned long pdc_read_counter(struct ata_probe_ent *probe_ent)
+static long pdc_read_counter(struct ata_probe_ent *probe_ent)
 {
-	unsigned long counter;
+	long counter;
 	int retry = 1;
 	u32 bccrl, bccrh, bccrlv, bccrhv;
 
@@ -612,7 +612,7 @@
 static long pdc_detect_pll_input_clock(struct ata_probe_ent *probe_ent) 
 {
 	u32 scr;
-	unsigned long start_count, end_count;
+	long start_count, end_count;
 	long pll_clock;
 
 	/* Read current counter value */
@@ -637,9 +637,9 @@
 	readl(probe_ent->mmio_base + PDC_SYS_CTL); /* flush */
 
 	/* calculate the input clock in Hz */
-	pll_clock = (long) ((start_count - end_count) * 10);
+	pll_clock = (start_count - end_count) * 10;
 
-	PDPRINTK("start[%lu] end[%lu] \n", start_count, end_count);
+	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
 	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);
 
 	return pll_clock;

--------------020006090101010907060902--


