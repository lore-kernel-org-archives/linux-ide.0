From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata-dev-2.6: pdc2027x yet another PLL fix
Date: Fri, 29 Apr 2005 11:19:55 +0800
Message-ID: <4271A7DB.9030202@tw.ibm.com>
References: <425A49F6.3040904@tw.ibm.com> <4264A057.9020604@tw.ibm.com> <426F539D.3090605@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060303090908090206090607"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:40417 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262374AbVD2DUb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Apr 2005 23:20:31 -0400
In-Reply-To: <426F539D.3090605@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060303090908090206090607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

   Yet another pdc2027x PLL fix.

Problem:
   The mdelay(100) does not delay exactly 100 ms on power5 machines
with the CPU micro-partitioning feature turned on.

Changes:
  - Change the "unsigned long" counter data type to "long".
    (Since the counter value is only 30-bit, "long" should be enough.)
  - Add do_gettimeofday() to measure the elapsed time.

Patch tested OK on power4, power5 and x86 machines.
(According to the document, do_gettimeofday() works on most platforms
except some old M68K machines. There are no PCI slots on those machines,
using do_gettimeofday() seems to be safe here.)

Attached please find the patch against the libata-dev-2.6 tree
for your review. Thanks.


Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------060303090908090206090607
Content-Type: text/plain;
 name="pdc062.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc062.diff"

--- linux-ori/drivers/scsi/pata_pdc2027x.c	2005-04-27 18:13:09.000000000 +0800
+++ linux/drivers/scsi/pata_pdc2027x.c	2005-04-28 16:34:36.000000000 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.61"
+#define DRV_VERSION	"0.62"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -472,10 +472,10 @@
  * @probe_ent: for the port address
  */
 
-static unsigned long pdc_read_counter(struct ata_probe_ent *probe_ent)
+static long pdc_read_counter(struct ata_probe_ent *probe_ent)
 {
 	u8 ctr0, ctr1, ctr2, ctr3;
-	unsigned long counter;
+	long counter;
 	u8 ctr0v, ctr1v, ctr2v, ctr3v;
 	int retry = 1;
 
@@ -625,11 +625,13 @@
 static long pdc_detect_pll_input_clock(struct ata_probe_ent *probe_ent) 
 {
 	u8 scr1;
-	unsigned long start_count, end_count;
-	long pll_clock;
+	long start_count, end_count;
+	struct timeval start_time, end_time;
+	long pll_clock, usec_elapsed;
 
 	/* Read current counter value */
 	start_count = pdc_read_counter(probe_ent);
+	do_gettimeofday(&start_time);
 
 	/* Start the test mode */
 	outb(0x01, probe_ent->port[0].bmdma_addr + 0x01);
@@ -642,6 +644,7 @@
 
 	/* Read the counter values again */
 	end_count = pdc_read_counter(probe_ent);
+	do_gettimeofday(&end_time);
 
 	/* Stop the test mode */
 	outb(0x01, probe_ent->port[0].bmdma_addr + 0x01);
@@ -650,7 +653,9 @@
 	outb(scr1 & 0xBF, probe_ent->port[0].bmdma_addr + 0x03);
 
 	/* calculate the input clock in Hz */
-	pll_clock = (long) ((start_count - end_count) * 10);
+	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 + 
+		(end_time.tv_usec - start_time.tv_usec);
+	pll_clock = (start_count - end_count) / 100 * (100000000 / usec_elapsed);
 
 	PDPRINTK("start[%lu] end[%lu] \n", start_count, end_count);
 	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);

--------------060303090908090206090607--


