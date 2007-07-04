From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/10] libata: call irq_off from bmdma_freeze()
Date: Wed, 04 Jul 2007 16:52:56 +0800
Message-ID: <468B5FE8.9080609@tw.ibm.com>
References: <468B5C97.1000803@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:60092 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756907AbXGDIxB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 04:53:01 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l648r1Qp013045
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 04:53:01 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l648r0S2243742
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:53:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l648r0DW010724
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:53:00 -0600
In-Reply-To: <468B5C97.1000803@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Patch 4/10:
  Call irq_off() from bmdma_freeze() and remove duplicated code.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---


diff -Nrup 03_add_irq_off_lldd/drivers/ata/libata-sff.c 04_convert_freeze/drivers/ata/libata-sff.c
--- 03_add_irq_off_lldd/drivers/ata/libata-sff.c	2007-07-04 11:57:33.000000000 +0800
+++ 04_convert_freeze/drivers/ata/libata-sff.c	2007-07-04 13:12:38.000000000 +0800
@@ -413,20 +413,7 @@ void ata_bmdma_stop(struct ata_queued_cm
  */
 void ata_bmdma_freeze(struct ata_port *ap)
 {
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
-	ap->ctl |= ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	iowrite8(ap->ctl, ioaddr->ctl_addr);
-
-	/* Under certain circumstances, some controllers raise IRQ on
-	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
-	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
-	 */
-	ata_chk_status(ap);
-
-	ap->ops->irq_clear(ap);
+	ap->ops->irq_off(ap);
 }
 
 /**
diff -Nrup 03_add_irq_off_lldd/drivers/ata/pata_scc.c 04_convert_freeze/drivers/ata/pata_scc.c
--- 03_add_irq_off_lldd/drivers/ata/pata_scc.c	2007-07-04 12:09:29.000000000 +0800
+++ 04_convert_freeze/drivers/ata/pata_scc.c	2007-07-04 13:12:38.000000000 +0800
@@ -875,20 +875,7 @@ static u8 scc_irq_ack (struct ata_port *
 
 static void scc_bmdma_freeze (struct ata_port *ap)
 {
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
-	ap->ctl |= ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	out_be32(ioaddr->ctl_addr, ap->ctl);
-
-	/* Under certain circumstances, some controllers raise IRQ on
-	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
-	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
-	 */
-	ata_chk_status(ap);
-
-	ap->ops->irq_clear(ap);
+	scc_irq_off(ap);
 }
 
 /**


