From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/7] sata_promise: pdc_freeze() semantic change
Date: Sat, 07 Jul 2007 15:02:49 +0800
Message-ID: <468F3A99.5040005@tw.ibm.com>
References: <468F3949.5050800@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:52633 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbXGGHC5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 03:02:57 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l676vbTH027587
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 02:57:37 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l6772vZt127622
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:02:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6772upX008539
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:02:57 -0600
In-Reply-To: <468F3949.5050800@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Mikael Pettersson <mikpe@it.uu.se>

 After checking the current implementations of freeze()/thaw(), it seems only pdc_freeze()
does more than simple irq masking. Remove the DMA stop code from pdc_freeze().

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 01_remove_leftover_irqon/drivers/ata/sata_promise.c 02_sata_pdc_freeze/drivers/ata/sata_promise.c
--- 01_remove_leftover_irqon/drivers/ata/sata_promise.c	2007-07-07 09:58:55.000000000 +0800
+++ 02_sata_pdc_freeze/drivers/ata/sata_promise.c	2007-07-07 10:39:22.000000000 +0800
@@ -578,7 +578,6 @@ static void pdc_freeze(struct ata_port *
 
 	tmp = readl(mmio + PDC_CTLSTAT);
 	tmp |= PDC_IRQ_DISABLE;
-	tmp &= ~PDC_DMA_ENABLE;
 	writel(tmp, mmio + PDC_CTLSTAT);
 	readl(mmio + PDC_CTLSTAT); /* flush */
 }


