From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/4] libata-dev-2.6: pdc2027x move the PLL counter reading
 code
Date: Mon, 11 Apr 2005 18:06:46 +0800
Message-ID: <425A4C36.5040106@tw.ibm.com>
References: <425A49F6.3040904@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000606070903010902090200"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:31715 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261754AbVDKKHr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Apr 2005 06:07:47 -0400
In-Reply-To: <425A49F6.3040904@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000606070903010902090200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Change:
    pdc2027x: move the PLL counter reading code to a separate function.

Attached please find the patch 3/4 against the libata-dev-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------000606070903010902090200
Content-Type: text/plain;
 name="pdc_060_1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc_060_1.diff"

--- libata-dev-2.6-059/drivers/scsi/pata_pdc2027x.c	2005-04-11 15:04:32.000000000 +0800
+++ libata-dev-2.6-reorg/drivers/scsi/pata_pdc2027x.c	2005-04-11 15:05:28.000000000 +0800
@@ -455,6 +455,33 @@
 }
 
 /**
+ * pdc_read_counter - Read the ctr counter
+ * @probe_ent: for the port address
+ */
+
+static unsigned long pdc_read_counter(struct ata_probe_ent *probe_ent)
+{
+	u8 ctr0, ctr1, ctr2, ctr3;
+	unsigned long counter;
+
+	outb(0x20, probe_ent->port[0].bmdma_addr + 0x01);
+	ctr0 = inb(probe_ent->port[0].bmdma_addr + 0x03);
+	outb(0x21, probe_ent->port[0].bmdma_addr + 0x01);
+	ctr1 = inb(probe_ent->port[0].bmdma_addr + 0x03);
+	outb(0x20, probe_ent->port[1].bmdma_addr + 0x01);
+	ctr2 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+	outb(0x21, probe_ent->port[1].bmdma_addr + 0x01);
+	ctr3 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+
+	counter = (ctr3 << 23) | (ctr2 << 15) | (ctr1 << 8) | ctr0;
+
+	PDPRINTK("ctr0[%X] ctr1[%X] ctr2[%X] ctr3[%X]\n", 
+		 ctr0, ctr1, ctr2, ctr3);
+
+	return counter;
+}
+
+/**
  * adjust_pll - Adjust the PLL input clock in Hz.
  *
  * @pdc_controller: controller specific information
@@ -550,6 +577,7 @@
 
 	return;
 }
+
 /**
  * detect_pll_input_clock - Detect the PLL input clock in Hz.
  * @probe_ent: for the port address
@@ -559,28 +587,11 @@
 static long pdc_detect_pll_input_clock(struct ata_probe_ent *probe_ent) 
 {
 	u8 scr1;
-	unsigned long ctr0;
-	unsigned long ctr1;
-	unsigned long ctr2 = 0;
-	unsigned long ctr3 = 0;
-
 	unsigned long start_count, end_count;
 	long pll_clock;
 
 	/* Read current counter value */
-	outb(0x20, probe_ent->port[0].bmdma_addr + 0x01);
-	ctr0 = inb(probe_ent->port[0].bmdma_addr + 0x03);
-	outb(0x21, probe_ent->port[0].bmdma_addr + 0x01);
-	ctr1 = inb(probe_ent->port[0].bmdma_addr + 0x03);
-	
-	outb(0x20, probe_ent->port[1].bmdma_addr + 0x01);
-	ctr2 = inb(probe_ent->port[1].bmdma_addr + 0x03);
-	outb(0x21, probe_ent->port[1].bmdma_addr + 0x01);
-	ctr3 = inb(probe_ent->port[1].bmdma_addr + 0x03);
-
-	start_count = (ctr3 << 23 ) | (ctr2 << 15) | (ctr1 << 8) | ctr0;
-
-	PDPRINTK("ctr0[%lX] ctr1[%lX] ctr2 [%lX] ctr3 [%lX]\n", ctr0, ctr1, ctr2, ctr3);
+	start_count = pdc_read_counter(probe_ent);
 
 	/* Start the test mode */
 	outb(0x01, probe_ent->port[0].bmdma_addr + 0x01);
@@ -592,19 +603,7 @@
 	udelay(1000);
 
 	/* Read the counter values again */
-	outb(0x20, probe_ent->port[0].bmdma_addr + 0x01);
-	ctr0 = inb(probe_ent->port[0].bmdma_addr + 0x03);
-	outb(0x21, probe_ent->port[0].bmdma_addr + 0x01);
-	ctr1 = inb(probe_ent->port[0].bmdma_addr + 0x03);
-	
-	outb(0x20, probe_ent->port[1].bmdma_addr + 0x01);
-	ctr2 = inb(probe_ent->port[1].bmdma_addr + 0x03);
-	outb(0x21, probe_ent->port[1].bmdma_addr + 0x01);
-	ctr3 = inb(probe_ent->port[1].bmdma_addr + 0x03);
-
-	end_count = (ctr3 << 23 ) | (ctr2 << 15) | (ctr1 << 8) | ctr0;
-
-	PDPRINTK("ctr0[%lX] ctr1[%lX] ctr2 [%lX] ctr3 [%lX]\n", ctr0, ctr1, ctr2, ctr3);
+	end_count = pdc_read_counter(probe_ent);
 
 	/* Stop the test mode */
 	outb(0x01, probe_ent->port[0].bmdma_addr + 0x01);

--------------000606070903010902090200--


