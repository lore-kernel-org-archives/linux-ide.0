From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Date: Tue, 26 Jun 2007 13:43:15 +0800
Message-ID: <4680A773.2020009@tw.ibm.com>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com>	<467A9923.6010203@ru.mvista.com>	<467F5127.4060006@tw.ibm.com> <20070625101009.48269d6e@the-village.bc.nu> <46809EA7.5090005@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:60133 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbXFZFnY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jun 2007 01:43:24 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5Q5hOAn004356
	for <linux-ide@vger.kernel.org>; Tue, 26 Jun 2007 01:43:24 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5Q5hOdf261122
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 23:43:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5Q5hMgF005761
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 23:43:23 -0600
In-Reply-To: <46809EA7.5090005@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bahadir Balban <bahadir.balban@gmail.com>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, Doug Maxey <dwm@enoyolf.org>

Recently the PLL input clock of pata_pdc2027x is sometimes detected
higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
It seems sometimes the mdelay() function is not as precise as it
used to be. Per Alan's advice, HT or power management might affect
the precision of mdelay().

This patch calls gettimeofday() to mesure the time elapsed and
calculate the PLL input clock accordingly.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---

Did more test. For mdelay(100) the usec_elapsed is usually 99287.
However, sometimes the usec_elapsed is 118934, longer than expected.

Jun 26 12:12:29 p4ht-s kernel: [ 9156.490991] ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
Jun 26 12:12:29 p4ht-s kernel: [ 9156.610175] usec_elapsed[118934]
Jun 26 12:12:29 p4ht-s kernel: [ 9156.610511] pata_pdc2027x 0000:02:05.0: PLL input clock 16817 kHz

After the patch, the PLL input clock detected looks more accurate.
For your review, thanks.

diff -Nrup 00_libata-dev/drivers/ata/pata_pdc2027x.c 01_gettimeofday/drivers/ata/pata_pdc2027x.c
--- 00_libata-dev/drivers/ata/pata_pdc2027x.c	2007-06-01 12:08:21.000000000 +0800
+++ 01_gettimeofday/drivers/ata/pata_pdc2027x.c	2007-06-26 13:08:34.000000000 +0800
@@ -689,10 +689,12 @@ static long pdc_detect_pll_input_clock(s
 	void __iomem *mmio_base = host->iomap[PDC_MMIO_BAR];
 	u32 scr;
 	long start_count, end_count;
-	long pll_clock;
+	struct timeval start_time, end_time;
+	long pll_clock, usec_elapsed;
 
 	/* Read current counter value */
 	start_count = pdc_read_counter(host);
+	do_gettimeofday(&start_time);
 
 	/* Start the test mode */
 	scr = readl(mmio_base + PDC_SYS_CTL);
@@ -705,6 +707,7 @@ static long pdc_detect_pll_input_clock(s
 
 	/* Read the counter values again */
 	end_count = pdc_read_counter(host);
+	do_gettimeofday(&end_time);
 
 	/* Stop the test mode */
 	scr = readl(mmio_base + PDC_SYS_CTL);
@@ -713,7 +716,11 @@ static long pdc_detect_pll_input_clock(s
 	readl(mmio_base + PDC_SYS_CTL); /* flush */
 
 	/* calculate the input clock in Hz */
-	pll_clock = (start_count - end_count) * 10;
+	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
+		(end_time.tv_usec - start_time.tv_usec);
+
+	pll_clock = (start_count - end_count) / 100 *
+		(100000000 / usec_elapsed);
 
 	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
 	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);


