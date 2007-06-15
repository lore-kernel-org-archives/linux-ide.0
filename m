From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 7/9] libata: pdc_freeze() semantic change
Date: Fri, 15 Jun 2007 11:30:07 +0800
Message-ID: <467207BF.9020409@tw.ibm.com>
References: <46720353.90209@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:51617 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbXFODaR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jun 2007 23:30:17 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5F3UCAm018579
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 23:30:12 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5F3UCGr167158
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:30:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5F3UBV1014847
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:30:11 -0600
In-Reply-To: <46720353.90209@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>
Cc: Doug Maxey <dwm@enoyolf.org>, Tejun Heo <htejun@gmail.com>, Mikael Pettersson <mikpe@it.uu.se>

Patch 7/9:

 After checking the current implementations of freeze()/thaw(), it seems only pdc_freeze()
do more than simple irq masking. Remove the DMA disable code from pdc_freeze().

The question is the design/semantic of freeze()/thaw().
Maybe we should limit them to simple irq on/off?

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 06_add_freeze_thaw_to_lldd/drivers/ata/sata_promise.c 07_sata_promise_freeze/drivers/ata/sata_promise.c
--- 06_add_freeze_thaw_to_lldd/drivers/ata/sata_promise.c	2007-06-11 17:23:47.000000000 +0800
+++ 07_sata_promise_freeze/drivers/ata/sata_promise.c	2007-06-13 13:39:33.000000000 +0800
@@ -581,7 +581,6 @@ static void pdc_freeze(struct ata_port *
 
 	tmp = readl(mmio + PDC_CTLSTAT);
 	tmp |= PDC_IRQ_DISABLE;
-	tmp &= ~PDC_DMA_ENABLE;
 	writel(tmp, mmio + PDC_CTLSTAT);
 	readl(mmio + PDC_CTLSTAT); /* flush */
 }


