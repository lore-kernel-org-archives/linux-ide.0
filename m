From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/3] libata-dev: pdc2027x mdelay() problem fix for power5
 micro-partitioning
Date: Fri, 05 Aug 2005 01:34:58 +0800
Message-ID: <42F251C2.8090409@tw.ibm.com>
References: <42F24DBE.0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080004000602060701070307"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:18926 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261821AbVHDRgE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Aug 2005 13:36:04 -0400
In-Reply-To: <42F24DBE.0@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This is a multi-part message in MIME format.
--------------080004000602060701070307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

Patch 2/3: pdc2027x mdelay() problem fix for micro-partitioning

Description:
   The mdelay(100) does not delay exactly 100 ms on IBM power5 machines when the power5 CPU micro-partitioning feature is turned on.
Ex. If micro-partitioning is set to use 0.1 of the CPU time, mdelay(100) will delay about 1 sec instead of 100ms.

Changes:
  - Use do_gettimeofday() to measure the actual elapsed time.
  According to the documentation, do_gettimeofday() works on most platforms
except some old M68K machines. There are no PCI slots on M68K machines,
so using do_gettimeofday() seems to be safe here.

  - Change the counter data type from "unsigned long" to "long".
     Since the counter value is only 30-bit, "long" should be big enough.
     This change is not related to the mdelay() problem, just for beautification.

Patch tested OK on x86, power4 and power5 machines.

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>


--------------080004000602060701070307
Content-Type: text/plain;
 name="pdc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc2.diff"

--- 01_pdc_mmio/drivers/scsi/pata_pdc2027x.c	2005-08-03 15:43:19.000000000 +0800
+++ 02_pdc_micro/drivers/scsi/pata_pdc2027x.c	2005-08-03 15:44:16.000000000 +0800
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
 
@@ -612,11 +612,13 @@
 static long pdc_detect_pll_input_clock(struct ata_probe_ent *probe_ent) 
 {
 	u32 scr;
-	unsigned long start_count, end_count;
+	long start_count, end_count, usec_elapsed;
+	struct timeval start_time, end_time;
 	long pll_clock;
 
 	/* Read current counter value */
 	start_count = pdc_read_counter(probe_ent);
+	do_gettimeofday(&start_time);
 
 	/* Start the test mode */
 	scr = readl(probe_ent->mmio_base + PDC_SYS_CTL);
@@ -629,6 +631,7 @@
 
 	/* Read the counter values again */
 	end_count = pdc_read_counter(probe_ent);
+	do_gettimeofday(&end_time);
 
 	/* Stop the test mode */
 	scr = readl(probe_ent->mmio_base + PDC_SYS_CTL);
@@ -637,7 +640,9 @@
 	wmb();
 
 	/* calculate the input clock in Hz */
-	pll_clock = (long) ((start_count - end_count) * 10);
+	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
+		(end_time.tv_usec - start_time.tv_usec);
+	pll_clock = (start_count - end_count) / 100 * (100000000 / usec_elapsed);
 
 	PDPRINTK("start[%lu] end[%lu] \n", start_count, end_count);
 	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);

--------------080004000602060701070307--


