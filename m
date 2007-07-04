From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 7/10] libata: pdc_freeze() semantic change
Date: Wed, 04 Jul 2007 17:01:46 +0800
Message-ID: <468B61FA.6050900@tw.ibm.com>
References: <468B5C97.1000803@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:57125 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323AbXGDJBw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 05:01:52 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6491pr8024025
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 05:01:51 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l6491pT3187628
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 03:01:51 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6491osG023826
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 03:01:51 -0600
In-Reply-To: <468B5C97.1000803@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, Mikael Pettersson <mikpe@it.uu.se>

Patch 7/10:

 After checking the current implementations of freeze()/thaw(), it seems only pdc_freeze()
do more than simple irq masking. Remove the DMA stop code from pdc_freeze().

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 06_add_freeze_thaw_to_lldd/drivers/ata/sata_promise.c 07_sata_promise_freeze/drivers/ata/sata_promise.c
--- 06_add_freeze_thaw_to_lldd/drivers/ata/sata_promise.c	2007-07-04 12:09:29.000000000 +0800
+++ 07_sata_promise_freeze/drivers/ata/sata_promise.c	2007-07-04 13:17:59.000000000 +0800
@@ -581,7 +581,6 @@ static void pdc_freeze(struct ata_port *
 
 	tmp = readl(mmio + PDC_CTLSTAT);
 	tmp |= PDC_IRQ_DISABLE;
-	tmp &= ~PDC_DMA_ENABLE;
 	writel(tmp, mmio + PDC_CTLSTAT);
 	readl(mmio + PDC_CTLSTAT); /* flush */
 }


