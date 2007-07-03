From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] ide: pdc202xx_new PLL input clock fix
Date: Tue, 03 Jul 2007 13:21:57 +0800
Message-ID: <4689DCF5.3040809@tw.ibm.com>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com> <46809EA7.5090005@tw.ibm.com> <4680A773.2020009@tw.ibm.com> <200707022013.04383.bzolnier@gmail.com> <46893D48.3060801@ru.mvista.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:55055 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbXGCFWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 01:22:11 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l635M8mJ010002
	for <linux-ide@vger.kernel.org>; Tue, 3 Jul 2007 01:22:08 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l635M8MS268190
	for <linux-ide@vger.kernel.org>; Mon, 2 Jul 2007 23:22:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l635M79E029438
	for <linux-ide@vger.kernel.org>; Mon, 2 Jul 2007 23:22:08 -0600
In-Reply-To: <46893D48.3060801@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bahadir Balban <bahadir.balban@gmail.com>, linux-ide@vger.kernel.org

Recently the PLL input clock of Promise 2027x is sometimes detected
higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
It seems sometimes the mdelay() function is not as precise as it
used to be. Per Alan's advice, HT or power management might affect
the precision of mdelay().

This patch calls gettimeofday() to mesure the time elapsed and
calculate the PLL input clock accordingly.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
(I have the Promise adapter at hand, so it's easier for me to verify.)
Attached please find the patch and the test result on my box for your review:
[   72.186805] PDC20275: chipset revision 1
[   72.196768] start[1039788039] end[1039620652] pll[16804952]
[   72.196819] PDC20275: PLL input clock is 16804 kHz
[   72.226586] PDC20275: 100% native mode on irq 10

Maybe Bahadir could also help to verify if it helps to his "hda lost interrupt" problem.

--- linux-2.6.22-rc7/drivers/ide/pci/pdc202xx_new.c.ori	2007-07-02 14:40:08.000000000 +0800
+++ linux-2.6.22-rc7/drivers/ide/pci/pdc202xx_new.c	2007-07-03 13:06:40.000000000 +0800
@@ -306,11 +306,13 @@ static long __devinit read_counter(u32 d
  */
 static long __devinit detect_pll_input_clock(unsigned long dma_base)
 {
+	struct timeval start_time, end_time;
 	long start_count, end_count;
-	long pll_input;
+	long pll_input, usec_elapsed;
 	u8 scr1;
 
 	start_count = read_counter(dma_base);
+	do_gettimeofday(&start_time);
 
 	/* Start the test mode */
 	outb(0x01, dma_base + 0x01);
@@ -322,6 +324,7 @@ static long __devinit detect_pll_input_c
 	mdelay(10);
 
 	end_count = read_counter(dma_base);
+	do_gettimeofday(&end_time);
 
 	/* Stop the test mode */
 	outb(0x01, dma_base + 0x01);
@@ -333,7 +336,10 @@ static long __devinit detect_pll_input_c
 	 * Calculate the input clock in Hz
 	 * (the clock counter is 30 bit wide and counts down)
 	 */
-	pll_input = ((start_count - end_count) & 0x3ffffff) * 100;
+	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
+		(end_time.tv_usec - start_time.tv_usec);
+	pll_input = ((start_count - end_count) & 0x3ffffff) / 10 *
+		(10000000 / usec_elapsed);
 
 	DBG("start[%ld] end[%ld]\n", start_count, end_count);
 


