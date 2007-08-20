From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2.6.23-rc3] libata: pata_pdc2027x PLL detection minor cleanup
Date: Mon, 20 Aug 2007 16:56:29 +0800
Message-ID: <46C9573D.70207@tw.ibm.com>
References: <200708182058.l7IKwrcJ016820@harpo.it.uu.se> <46C763D1.7060801@garzik.org> <46C78B57.5070808@tw.ibm.com> <46C7948B.1080107@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:49015 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbXHTI4o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Aug 2007 04:56:44 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7K8ugCn023225
	for <linux-ide@vger.kernel.org>; Mon, 20 Aug 2007 04:56:42 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7K8ufR3205316
	for <linux-ide@vger.kernel.org>; Mon, 20 Aug 2007 02:56:42 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7K8ufhd012101
	for <linux-ide@vger.kernel.org>; Mon, 20 Aug 2007 02:56:41 -0600
In-Reply-To: <46C7948B.1080107@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Sergei Shtylyov <sshtylyov@ru.mvista.com>


Minor cleanup to remove the unneeded rmb()s per Jeff's advice. Also removed the
pll_clock < 0 check since pll_clock now guaranteed to be >= 0 after Mikael's patch.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Tested ok on both x86 and ppc64, together with Mikael's patch.

diff -Nrup 01_mikael/drivers/ata/pata_pdc2027x.c 02_pdc_pll_fix2/drivers/ata/pata_pdc2027x.c
--- 01_mikael/drivers/ata/pata_pdc2027x.c	2007-08-20 10:43:38.000000000 +0800
+++ 02_pdc_pll_fix2/drivers/ata/pata_pdc2027x.c	2007-08-20 10:48:22.000000000 +0800
@@ -565,12 +565,10 @@ static long pdc_read_counter(struct ata_
 retry:
 	bccrl = readl(mmio_base + PDC_BYTE_COUNT) & 0x7fff;
 	bccrh = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0x7fff;
-	rmb();
 
 	/* Read the counter values again for verification */
 	bccrlv = readl(mmio_base + PDC_BYTE_COUNT) & 0x7fff;
 	bccrhv = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0x7fff;
-	rmb();
 
 	counter = (bccrh << 15) | bccrl;
 
@@ -745,9 +743,6 @@ static int pdc_hardware_init(struct ata_
 	 */
 	pll_clock = pdc_detect_pll_input_clock(host);
 
-	if (pll_clock < 0) /* counter overflow? Try again. */
-		pll_clock = pdc_detect_pll_input_clock(host);
-
 	dev_printk(KERN_INFO, host->dev, "PLL input clock %ld kHz\n", pll_clock/1000);
 
 	/* Adjust PLL control register */


